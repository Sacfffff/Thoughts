//
//  UploadDownloadPicturesService.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 29.08.22.
//

import UIKit

final class UploadDownloadPicturesService {
    
    func downloadUrlForProfilePicture(ref: String, completion: @escaping (UIImage?) -> Void) {
        StorageManager.shared.downloadUrlForProfilePicture(path: ref) { url in
            guard let url = url else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            }.resume()
            
        }
    }
    
    func uploadUserProfileLPicture(image: UIImage, email: String, completion: @escaping (Bool) -> Void){
        StorageManager.shared.uploadUserProfileLPicture(email: email,
                                                        image: image) { success in
            if success {
                DatabaseManager.shared.updateProfilePhoto(email: email) { updated in
                    guard updated else {
                        completion(false)
                        return
                    }
                    DispatchQueue.main.async {
                        completion(true)
                    }
                }
            }
        }
    }
    
    func uploadBlogHeaderImage(email : String, headerImage: UIImage, postTitle: String, postBody: String, completion: @escaping (Bool) -> Void) {
        let newPostId = UUID().uuidString
        StorageManager.shared.uploadBlogHeaderImage(email: email, blogPostID: newPostId, image: headerImage) { success in
            guard success else {
                completion(false)
                return }
            
            StorageManager.shared.downloadUrlForPostHeader(email: email, blogPostID: newPostId) { url in
                guard let headerURL = url else {
                    completion(false)
                    return }
                
                let post = BlogPost(identifier: newPostId,
                                    title: postTitle,
                                    timestamp: Date().timeIntervalSince1970,
                                    headerImageUrl: headerURL,
                                    text: postBody)
                DatabaseManager.shared.insert(blodPost: post, email: email) { posted in
                    guard posted else {
                        completion(false)
                        return }
                    
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    
                }
                
            }
            
            
        }

    }
}
