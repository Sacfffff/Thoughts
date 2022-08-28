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
        let data =
        [
            ConstantKeysUserDefaults.kEmail : user.email,
            ConstantKeysUserDefaults.kName : user.name
        ]
        let documentID = createDocumentID(email: user.email)
        database
            .collection(ConstantKeysDatabase.kDatabaseCollectionGetUsers)
            .document(documentID)
            .setData(data) { error in
                completion(error == nil)
            }
    }
    
    func getUser(email: String, completion: @escaping (UserObject?) -> Void){
       let documentID = createDocumentID(email: email)
        
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
        let path = createDocumentID(email: email)
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

    
    private func createDocumentID(email: String) -> String {
       return email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "-")
    }
    
}
