//
//  SignUpViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 27.08.22.
//

import Foundation

protocol SignUpViewModelProtocol {
    var present : (() -> Void)? {get set}
    
    func signUp(_ email: String, _ password: String, _ name: String)
 
}

final class SignUpViewModel : SignUpViewModelProtocol {
    var present: (() -> Void)?
    
 
    func signUp(_ email: String, _ password: String, _ name: String) {
        guard let present = present else {
            return
        }
        AuthManager.shared.signUp(email: email, password: password) { successed in
            if successed {
                DatabaseManager.shared.insert(user: UserObject(email: email, name: name, profilePictureUrl: nil)) { insertedIn in
                    guard insertedIn else {
                        return
                    }
                    UserDefaults.standard.set(email, forKey: ConstantKeysUserDefaults.kEmail)
                    UserDefaults.standard.set(name, forKey: ConstantKeysUserDefaults.kName)
                    DispatchQueue.main.async {
                        present()
                    }
                }
            } else {
                
            }
        }
    }
    
    
}
