//
//  ViewPostViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 30.08.22.
//

import Foundation
protocol ViewPostViewModelProtocol {
    var post : BlogPost {get}
}

final class ViewPostViewModel: ViewPostViewModelProtocol {
  
    let post : BlogPost
    
    init(post : BlogPost) {
        self.post = post
    }
  
}
