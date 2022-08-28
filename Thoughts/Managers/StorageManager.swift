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
    
    private let storage = Storage.storage()
    private init(){}
    
    func uploadUserProfileLPicture(
        email: String,
        image : UIImage?,
        completion:  @escaping (Bool) -> Void
    ) {
        let path = email
            .replacingOccurrences(of: "@", with: "-")
            .replacingOccurrences(of: ".", with: "_")
        guard let pngData = image?.pngData() else {
            return
        }
        storage
            .reference(withPath: "\(ConstantKeysDatabase.kDataBaseGetPhoto)/\(path)/photo.png")
            .putData(pngData, metadata: nil) { result in
                switch result {
                case .success(_):
                    completion(true)
                case .failure(_):
                    completion(false)
                }
            }
    }
    
    func downloadUrlForProfilePicture(
        path: String,
        completion: @escaping (URL?) -> Void
    ) {
        storage.reference(withPath: path)
            .downloadURL { url, _ in
               completion(url)
            }
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
