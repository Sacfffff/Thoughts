//
//  ProfileViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 27.08.22.
//

import Foundation

protocol ProfileViewModelProtocol {
    var present : (() -> Void)? {get set}
    
    func signOut()
}

final class ProfileViewModel : ProfileViewModelProtocol {
    var present: (() -> Void)?
    
    func signOut() {
        guard let present = present else {
            return
        }

        AuthManager.shared.signOut { success in
            if success {
                UserDefaults.standard.set(nil, forKey: ConstantKeysUserDefaults.kName)
                UserDefaults.standard.set(nil, forKey: ConstantKeysUserDefaults.kEmail)
                DispatchQueue.main.async {
                   present()
                }
            }
        }
    }
    
    
}
