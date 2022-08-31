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
    func fetchPosts()
    func downloadUrlForProfilePicture(ref: String, completion: @escaping (UIImage?) -> Void)
    func uploadUserProfileLPicture(image: UIImage)
}

final class ProfileViewModel : ProfileViewModelProtocol {

    private let service : UploadDownloadPicturesService = UploadDownloadPicturesService()
     var currentEmail: String
    
     var user : UserObject?
    
     var posts : [BlogPost] = [] {
        didSet {
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
                UserDefaults.standard.set(false, forKey: ConstantKeysUserDefaults.kPremium)
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
    
     func fetchPosts(){
        DatabaseManager.shared.getPosts(from: currentEmail) { [weak self] posts in
            DispatchQueue.main.async {
                self?.posts = posts
            }
           
            
        }
    }
    
    
    func downloadUrlForProfilePicture(ref: String, completion: @escaping (UIImage?) -> Void) {
        service.downloadUrlForProfilePicture(ref: ref, completion: completion)
    }
    
    func uploadUserProfileLPicture(image: UIImage){
        service.uploadUserProfileLPicture(image: image, email: currentEmail) { [weak self] successeded in
            guard successeded else { return }
            self?.fetchProfileData()
        }

    }
    
}
