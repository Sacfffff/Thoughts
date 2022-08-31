//
//  TrackPostViewsManager.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 31.08.22.
//

import Foundation
import Purchases
import StoreKit

final class TrackPostViewsManager {
    
    static let shared = TrackPostViewsManager()
    
    private let formatter = ISO8601DateFormatter()
    
    private init(){}
    
    private var postEligibleViewDate : Date? {
        get {
            guard let string =  UserDefaults.standard.string(forKey: ConstantKeysUserDefaults.kDate) else { return nil }
            return formatter.date(from: string)
        }
        set {
            guard let date = newValue else { return }
            let string = formatter.string(from: date)
            UserDefaults.standard.set(string, forKey: ConstantKeysUserDefaults.kDate)
        }
       
    }
    
    var canViewPost : Bool {
        if IAPManager.shared.isPremium() {
            return true
        }
        guard let date = postEligibleViewDate else {
            return true
        }
        UserDefaults.standard.set(0, forKey: ConstantKeysUserDefaults.kPostViews)
        return Date() >= date
    }
    
    func logPostViewed() {
        let total = UserDefaults.standard.integer(forKey: ConstantKeysUserDefaults.kPostViews)
        UserDefaults.standard.set(total + 1, forKey: ConstantKeysUserDefaults.kPostViews)
        
        if total == 2 {
            let hour : TimeInterval = 60 * 60
            postEligibleViewDate = Date().addingTimeInterval(hour * 24)
        }
    }
    
}
