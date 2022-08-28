//
//  ProfileViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 27.08.22.
//

import Foundation
import UIKit

protocol ProfileViewModelProtocol {
    var present : (() -> Void)? {get set}
    var update : (() -> Void)? {get set}
    
    var posts : [BlogPost] {get}
    var user : UserObject? {get}
    var currentEmail: String {get}
    
    
    func signOut()
    func fetchProfileData()
    func downloadUrlForProfilePicture(ref: String, completion: @escaping (UIImage?) -> Void)
    func uploadUserProfileLPicture(image: UIImage)
}

final class ProfileViewModel : ProfileViewModelProtocol {

     var currentEmail: String
    
     var user : UserObject?
    
     var posts : [BlogPost] = [] {
        didSet{
           update?()
        }
       
    }
    
    var present: (() -> Void)?
    var update : (() -> Void)?
    
    init(email: String){
        self.currentEmail = email
    }
    
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
    
     func fetchProfileData() {
        DatabaseManager.shared.getUser(email: currentEmail) { [weak self] user in
            guard let user = user,
                  let present = self?.present else {
                return
            }

            self?.user = user
            DispatchQueue.main.async {
                
                present()
               
            }
            
           
        }
    }
    
    
    func downloadUrlForProfilePicture(ref: String, completion: @escaping (UIImage?) -> Void) {
        StorageManager.shared.downloadUrlForProfilePicture(path: ref) { url in
            guard let url = url else {
                return
            }
            
           URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
               guard let data = data else {
                    return
                }

               DispatchQueue.main.async {
                   completion(UIImage(data: data))
                }
           }.resume()

        }
    }
    
    func uploadUserProfileLPicture(image: UIImage){
        StorageManager.shared.uploadUserProfileLPicture(email: self.currentEmail,
                                                        image: image) { [weak self] success in
            guard let strongSelf = self else { return }
            if success {
                DatabaseManager.shared.updateProfilePhoto(email: strongSelf.currentEmail) { updated in
                    guard updated else {
                        return
                    }
                    DispatchQueue.main.async {
                        self?.fetchProfileData()
                    }
                }
            }
        }

    }
    
}
