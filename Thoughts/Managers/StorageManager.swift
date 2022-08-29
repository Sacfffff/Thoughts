//
//  StorageManager.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import Foundation

import UIKit


final class StorageManager {
    static let shared = StorageManager()
    
    private let storageHelper : StorageService = StorageService()
    private let pathService = CreatePathFromEmailService()

    private init(){}
    
    func uploadUserProfileLPicture(
        email: String,
        image : UIImage?,
        completion:  @escaping (Bool) -> Void
    ) {
        let path = "\(ConstantKeysDatabase.kDataBaseGetPhoto)/\(pathService.createPath(with: email))/photo.png"
        
        storageHelper.upload(image, path: path, completion: completion)
     
    }
    
    func downloadUrlForProfilePicture(
        path: String,
        completion: @escaping (URL?) -> Void
    ) {
        storageHelper.download(path: path, completion: completion)
    }
    
    func uploadBlogHeaderImage(
        email: String,
        blogPostID: String,
        image : UIImage,
        completion:  @escaping (Bool) -> Void
    ) {
        let pathComponent = "\(ConstantKeysDatabase.kDataBaseInsertPostHeader)/\(pathService.createPath(with: email))/\(blogPostID).png"
        storageHelper.upload(image, path: pathComponent, completion: completion)
    }
    
    func downloadUrlForPostHeader(
        email: String,
        blogPostID: String,
        completion: @escaping (URL?) -> Void
    ) {
        let path = "\(ConstantKeysDatabase.kDataBaseInsertPostHeader)/\(pathService.createPath(with: email))/\(blogPostID).png"
        storageHelper.download(path: path, completion: completion)

    }


    
}
