//
//  EmailPath.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 29.08.22.
//

import Foundation

final class CreatePathFromEmailService {
    
     func createPath(with email: String) -> String {
       return email
            .replacingOccurrences(of: ".", with: "_")
            .replacingOccurrences(of: "@", with: "-")
    }
}
