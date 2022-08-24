//
//  AuthManager.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import Foundation
import FirebaseAuth

struct UserData {
    var email : String
    var password : String
}

final class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private init(){}
    
    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    func signIn(
        email : String,
        password: String,
        completion: @escaping (Bool) -> Void)
    {
        guard check(email: email, password: password) else {
            completion(false)
            return
        }
        
        auth.signIn(withEmail: email, password: password) { results, error in
            guard results != nil, error == nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
        
    }
    
    func signUp(
        email : String,
        password: String,
        completion: @escaping (Bool) -> Void)
    {
        guard check(email: email, password: password) else {
            completion(false)
            return
        }
        
        auth.createUser(withEmail: email, password: password) { results, error in
            guard results != nil, error == nil else {
                completion(false)
                return
            }
            
            //Account created 
            completion(true)
        }
    }
    
    func signOut(
        completion: (Bool) -> Void)
    {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            completion(false)
        }
    }
    
    private func check(email: String, password: String) -> Bool {
        if  !email.trimmingCharacters(in: .whitespaces).isEmpty,
            !password.trimmingCharacters(in: .whitespaces).isEmpty,
            password.count >= 6 {
            
            return true
        }
        
        return false
        
    }
}
