//
//  StorageHelper.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 29.08.22.
//

import Foundation
import FirebaseStorage

final class StorageService {
    
    private let storage = Storage.storage()
    
     func upload(_ image: UIImage?, path: String,  completion:  @escaping (Bool) -> Void){
       
        guard let pngData = image?.pngData() else {
            return
        }
        storage
            .reference(withPath: path)
            .putData(pngData, metadata: nil) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        completion(true)
                    case .failure(_):
                        completion(false)
                    }
                }
               
            }
    }
    
     func download(path: String, completion: @escaping (URL?) -> Void){
        storage.reference(withPath: path)
            .downloadURL { url, _ in
                DispatchQueue.main.async {
                    completion(url)
                }
               
            }
    }
}
