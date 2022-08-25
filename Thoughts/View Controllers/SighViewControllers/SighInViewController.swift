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
        checkIsPremium()
    }
    
    private func setUpView(){
        title = "Sign In"
        view.backgroundColor = .systemBackground
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }

  
    //off to view model
    
    private func checkIsPremium() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if !IAPManager.shared.isPremium() {
                self.present(UINavigationController(rootViewController: PayWallViewController()), animated: true)
            }
        }
    }

}
