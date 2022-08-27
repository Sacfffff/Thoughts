//
//  ProfileViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class ProfileViewController: UIViewController {

    private var viewModel : ProfileViewModelProtocol = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
  
    }
    

    private func setUpView(){
        title = "Profile"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sigh Out",
                                                            style: .plain,
                                                            target: self, action: #selector(sighOutDidTap))
      
    }
    @objc private func sighOutDidTap(){
        let alert = UIAlertController(title: "Sign Out",
                                      message: "Are you sure you'd like to sign out?",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { [weak self] _ in
            self?.viewModel.present = {
                let navVC = UINavigationController(rootViewController: SighInViewController())
                navVC.modalPresentationStyle = .fullScreen
                self?.present(navVC, animated: true)
            }
            
            self?.viewModel.signOut()

        }))
        
        present(alert, animated: true)
    }

}
