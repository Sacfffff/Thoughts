//
//  CreatePostViewmodel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 29.08.22.
//

import UIKit

protocol CreatePostViewModelProtocol {
    var selectedHeaderImage : UIImage? {get set}
    var cancel : (() -> Void)? {get set}
    func uploadBlogHeaderImage(email : String, headerImage: UIImage, postTitle: String, postBody: String)
}

final class CreatePostViewModel : CreatePostViewModelProtocol {
    
    private let service : UploadDownloadPicturesService = UploadDownloadPicturesService()
    
    var selectedHeaderImage : UIImage?
    
    var cancel: (() -> Void)?
    
    func uploadBlogHeaderImage(email : String, headerImage: UIImage, postTitle: String, postBody: String) {
        service.uploadBlogHeaderImage(email: email, headerImage: headerImage, postTitle: postTitle, postBody: postBody) { [weak self] successeded in
            guard successeded, let cancel = self?.cancel else { return }
            
            cancel()
            
        }
    }
}
