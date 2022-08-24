//
//  DataBaseManager.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import Foundation
import FirebaseFirestore


final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    private init(){}
    
    func insertBlogPost(
        with post: String,
        user: String,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
    
    
    func getAllPosts(
        with post: String,
        user: String,
        completion: @escaping ([String]) -> Void
    ) {
        
    }
    
    func getPostsForUser(
        with post: String,
        user: String,
        completion: @escaping ([String]) -> Void
    ) {
        
    }
    
    func insertUser(
        user: String,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
    
}
