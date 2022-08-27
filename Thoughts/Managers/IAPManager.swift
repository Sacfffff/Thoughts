//
//  IAPManagers.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import Foundation
import Purchases
import StoreKit

final class IAPManager {
    
    private enum ConstantKeys {
        static let kPremium = "Premium"
        static let kOfferings = "default"
    }
    
    static let shared = IAPManager()
    
    
    private init() {}
    
    func isPremium() -> Bool {
        return UserDefaults.standard.bool(forKey: ConstantKeys.kPremium)
    }
    
    func getSubscriptionStatus(completion: ((Bool) -> Void)?) {
        Purchases.shared.purchaserInfo { [weak self] info, error in
            guard let entitlements = info?.entitlements,
                  error == nil  else {
                return
            }
            
            if self?.checkEntitlements(entitlements) == true {
                completion?(true)
            } else {
                completion?(false)
            }
            
        }
    }
    
    func fetchPacages(completion: @escaping (Purchases.Package?) -> Void) {
        Purchases.shared.offerings { offerings, error in
            guard let package = offerings?.offering(identifier: ConstantKeys.kOfferings)?.availablePackages.first,
                  error == nil else {
                completion(nil)
                return
            }
            
            completion(package)
        }
    }
    
    func subscribe(package: Purchases.Package,
                   completion: @escaping (Bool) -> Void){
        guard  !isPremium() else {
            completion(true)
            return
        }
        Purchases.shared.purchasePackage(package) { [weak self] transaction, info, error, userCancelled in
            guard let transaction = transaction,
                  let entitlements = info?.entitlements,
                  error == nil,
                  !userCancelled else {
                return
            }
            
            switch transaction.transactionState {
                
            case .purchasing:
                print("purchasing")
            case .purchased:
                
                if self?.checkEntitlements(entitlements) == true {
                    completion(true)
                } else {
                    completion(false)
                }
            case .failed:
                print("purchasing")
            case .restored:
                print("purchasing")
            case .deferred:
                print("purchasing")
            @unknown default:
                print("purchasing")
            }
        }
    }
    
    func restorePurchases(completion: @escaping (Bool) -> Void){
        Purchases.shared.restoreTransactions { [weak self]info, error in
            guard let entitlements = info?.entitlements,
                  error == nil  else {
                      return
                  }
            
            if self?.checkEntitlements(entitlements) == true {
                completion(true)
            } else {
                completion(false)
            }
            
            
        }
        
        
    }
    
    private func checkEntitlements(_ entitlements: Purchases.EntitlementInfos) -> Bool{
        if entitlements.all[ConstantKeys.kPremium]?.isActive == true {
            UserDefaults.standard.set(true, forKey: ConstantKeys.kPremium)
            return true
        } else {
            UserDefaults.standard.set(false, forKey: ConstantKeys.kPremium)
             return false
        }
    }
    
    
}
