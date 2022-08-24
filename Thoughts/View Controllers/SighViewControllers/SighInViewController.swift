//
//  SighInViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class SighInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       setUpView()
    }
    
    private func setUpView(){
        title = "Sign In"
        view.backgroundColor = .systemBackground
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

  

}
