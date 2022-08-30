//
//  PostHeaderModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 30.08.22.
//

import Foundation

final class PostHeaderModel {
    let imageURL : URL?
    var imageData : Data?
    
    init( imageURL : URL? ) {
        self.imageURL = imageURL
    }
}
