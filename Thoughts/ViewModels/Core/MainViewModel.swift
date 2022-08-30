//
//  MainViewModel.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 25.08.22.
//

import UIKit

protocol MainViewModelProtocol {
    var posts : [BlogPost] {get}
    var update : (() -> Void)? {get set}
   
    func fetchAllPosts()
  
}

final class MainViewModel : MainViewModelProtocol {
    var update : (() -> Void)?
    var posts: [BlogPost] = [] {
        didSet {
           update?()
        }
    }
    
    func fetchAllPosts(){
        DatabaseManager.shared.getAllPosts { [weak self] posts in
            DispatchQueue.main.async {
                self?.posts = posts
            }
        }
   }
}
