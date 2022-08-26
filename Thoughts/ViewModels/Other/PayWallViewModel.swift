//
//  PayWallViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 26.08.22.
//

import Foundation

protocol PayWallViewModelProtocol {
    var success : (() -> Void)? {get set}
    var failure : (() -> Void)? {get set}
    func subscribe()
    func restore()
}

final class PayWallViewModel : PayWallViewModelProtocol {
    var success: (() -> Void)?
    
    var failure: (() -> Void)?
    
    func subscribe() {
        IAPManager.shared.fetchPacages { [weak self] package in
            guard let package = package,
            let update = self?.success,
            let failure = self?.failure else { return }
            IAPManager.shared.subscribe(package: package) { success in
                DispatchQueue.main.async {
                    if success {
                        update()
                    } else {
                       failure()
                    }
                }
                
            }
        }
    }
    
    func restore() {
        guard let update = self.success,
              let failure = self.failure else { return }
        IAPManager.shared.restorePurchases {  success in
            DispatchQueue.main.async {
                if success {
                    update()
                } else {
                    failure()
                }
            }
            
        }
    }
    
    
}
