//
//  ViewPostViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 30.08.22.
//

import Foundation
protocol ViewPostViewModelProtocol {
    var post : BlogPost {get}
    var isOwnedByCurrentUser : Bool {get}
    
    func logPostViewed()
}

final class ViewPostViewModel: ViewPostViewModelProtocol {
  
    let post : BlogPost
    let isOwnedByCurrentUser : Bool
    
    init(post : BlogPost, isOwnedByCurrentUser : Bool) {
        self.post = post
        self.isOwnedByCurrentUser = isOwnedByCurrentUser
    }
  
    func logPostViewed() {
        TrackPostViewsManager.shared.logPostViewed()
    }
}
