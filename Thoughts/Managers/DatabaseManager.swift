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
    
    private enum ConstansKeys {
        static let kDatabaseCollectionInsert = "users"
    }
    
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
        let data =
        [
            "email" : user.email,
            "name" : user.name
        ]
        let documentID = user.email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "_")
        database
            .collection(ConstansKeys.kDatabaseCollectionInsert)
            .document(documentID)
            .setData(data) { error in
                completion(error == nil)
            }
    }
    
}
