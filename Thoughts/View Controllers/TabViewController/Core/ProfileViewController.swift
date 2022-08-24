//
//  ProfileViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: <#T##String#>), style: .done, target: self, action: #selector(sighOutDidTap))
       
        
    }
    

    @objc private func sighOutDidTap(){
        
    }

}
