//
//  SignInViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 25.08.22.
//

import Foundation

protocol SignInViewModelProtocol {
    
    var present : (() -> Void)? {get set}
   func checkIsPremium()
}

final class SignInViewModel : SignInViewModelProtocol {
 
    
    var present: (() -> Void)?
    
    func checkIsPremium() {
        guard let present = present else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if !IAPManager.shared.isPremium() {
                present()
            }
        }
    }
    
    
}
