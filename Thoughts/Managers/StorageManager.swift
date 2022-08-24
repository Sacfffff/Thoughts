//
//  StorageManager.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import Foundation
import FirebaseStorage


final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    private init(){}
    
    func uploadUserProfileLPicture(
        email: String,
        image : UIImage?,
        completion:  @escaping (Bool) -> Void
    ) {
        
    }
    
    func downloadUrlForProfilePicture(
        user: UserObject,
        completion: @escaping (URL?) -> Void
    ) {
        
    }
    
    func uploadBlogHeaderImage(
        blogPost: BlogPost,
        image : UIImage?,
        completion:  @escaping (Bool) -> Void
    ) {
        
    }
    
    func downloadUrlForPostHeader(
        blogPost: BlogPost,
        completion: @escaping (URL?) -> Void
    ) {
        
    }
    
}
