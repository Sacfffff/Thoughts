//
//  PostPreviewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 30.08.22.
//

import Foundation

 final class PostPreviewModel {
    let title : String
    let imageURL : URL?
    var imageData : Data?
     
     init(title : String, imageURL : URL?){
         self.title = title
         self.imageURL = imageURL
     }
    
}
