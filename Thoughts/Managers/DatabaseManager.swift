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
    private let pathService = CreatePathFromEmailService()
    
    private init(){}
    
    func insert(
        blodPost: BlogPost,
        email: String,
        completion: @escaping (Bool) -> Void
    ) {
        let data  :  [String : Any] =
        [
            "id" : blodPost.identifier,
            "title" : blodPost.title,
            "body" : blodPost.text,
            "created" : blodPost.timestamp,
            "headerImageURL" : blodPost.headerImageUrl?.absoluteString ?? ""
            
        ]
        let documentID = pathService.createPath(with: email)
        database
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetUsers)
            .document(documentID)
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetPosts)
            .document(blodPost.identifier)
            .setData(data) { error in
                completion(error == nil)
            }
    }
    
    
    func getAllPosts(
        completion: @escaping ([BlogPost]) -> Void
    ) {
      
        database
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetUsers)
            .getDocuments { [weak self] snapshot, error in
                guard let documents = snapshot?.documents.compactMap({ $0.data() }),
                      error == nil else { return }
                let email : [String] = documents.compactMap({ $0[ConstantKeysUserDefaults.kEmail] as? String })
                guard !email.isEmpty else {
                    completion([])
                    return
                }
                
                let group = DispatchGroup()
                var results : [BlogPost] = []
                email.forEach({
                    group.enter()
                    self?.getPosts(from: $0) { userPosts in
                        defer {
                            group.leave()
                        }
                        results.append(contentsOf: userPosts)
                    }
                })
                
                group.notify(queue: .global()) {
                    completion(results)
                }
                
            }
        
    }
    
    func getPosts(
        from email: String,
        completion: @escaping ([BlogPost]) -> Void
    ) {
        let documentID = pathService.createPath(with: email)
        database
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetUsers)
            .document(documentID)
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetPosts)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents.compactMap({ $0.data() }), error == nil else { return }
                
                let posts : [BlogPost] = documents.compactMap { dictionary in
                    guard let id = dictionary["id"] as? String,
                          let title = dictionary["title"] as? String,
                          let body = dictionary["body"] as? String,
                          let created = dictionary["created"] as? TimeInterval,
                          let headerImageURL = dictionary["headerImageURL"] as? String else { return nil }
                    
                   return BlogPost(identifier: id, title: title, timestamp: created, headerImageUrl: URL(string:headerImageURL), text: body)
                    
                }
                    completion(posts)
                   
                
                
            }
    }
    
    func insert(
        user: UserObject,
        completion: @escaping (Bool) -> Void
    ) {
        let data =
        [
            ConstantKeysUserDefaults.kEmail : user.email,
            ConstantKeysUserDefaults.kName : user.name
        ]
        let documentID = pathService.createPath(with: user.email)
        database
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetUsers)
            .document(documentID)
            .setData(data) { error in
                completion(error == nil)
            }
    }
    
    func getUser(email: String, completion: @escaping (UserObject?) -> Void){
       let documentID = pathService.createPath(with: email)
        
        database
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetUsers)
            .document(documentID)
            .getDocument { snapshot, error in
                guard let data = snapshot?.data() as? [String : String],
                      let name = data[ConstantKeysUserDefaults.kName],
                      error == nil  else {
                    completion(nil)
                    return
                }
               
          
                let ref : String? = data[ConstantKeysDatabase.kDataBaseGetPhoto]
                
                completion(UserObject(email: email, name: name, profilePictureRef: ref))
            }
        
    }
    
    func updateProfilePhoto(
        email: String,
        completion:  @escaping (Bool) -> Void
    ) {
        let path = pathService.createPath(with: email)
        let photoRef = "\(ConstantKeysDatabase.kDataBaseGetPhoto)/\(path)/photo.png"
        let dbRef = database
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetUsers)
            .document(path)
        
        dbRef.getDocument { snapshot, error in
            guard var data = snapshot?.data(), error == nil else {
                return
            }
            data[ConstantKeysDatabase.kDataBaseGetPhoto] = photoRef
            dbRef.setData(data) { error in
                completion(error == nil)
            }
        }
    }

    
    
    
}
