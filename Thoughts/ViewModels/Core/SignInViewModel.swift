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
        //
    }
    
    
}
