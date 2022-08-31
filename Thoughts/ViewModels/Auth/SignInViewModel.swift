//
//  SignInViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 25.08.22.
//

import Foundation

protocol SignInViewModelProtocol {
    var present : (() -> Void)? {get set}
    
    func signIn(_ email: String, _ password: String)
 
}

final class SignInViewModel : SignInViewModelProtocol {
    var present: (() -> Void)?
    
    func signIn(_ email: String, _ password: String) {
        
        guard let present = present else {
            return
        }

        IAPManager.shared.getSubscriptionStatus(completion: nil)
        
        AuthManager.shared.signIn(email: email, password: password) { success in
            guard success else { return }
            UserDefaults.standard.set(email, forKey: ConstantKeysUserDefaults.kEmail)
            DispatchQueue.main.async {
                present()
            }
        }
    }
    
 
  
    
    
}
