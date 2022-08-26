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
    
    func insert(
        blodPost: BlogPost,
        user: UserObject,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
    
    
    func getAllPosts(
        completion: @escaping ([BlogPost]) -> Void
    ) {
        
    }
    
    func getPosts(
        from user: UserObject,
        completion: @escaping ([BlogPost]) -> Void
    ) {
        
    }
    
    func insert(
        user: UserObject,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
    
}
