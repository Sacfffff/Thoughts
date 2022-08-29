//
//  MainViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class MainViewController: UIViewController {

    private let composeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setImage(UIImage(
            systemName: "square.and.pencil",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 30.0,
                weight: .medium)), for: .normal)
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
     
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
        composeButton.layer.cornerRadius = composeButton.width / 2
    }

 
    private func setUpView(){
        view.backgroundColor = .systemBackground
        title = "Home"
        view.addSubview(composeButton)
        composeButton.addTarget(self, action: #selector(composeButtondidTap), for: .touchUpInside)
      
    }
    
    @objc private func composeButtondidTap() {
        present(UINavigationController(rootViewController: CreateNewPostViewController()), animated: true)
    }

    
    private func setupConstraints(){
        
        
        
        NSLayoutConstraint.activate(
            [
                //composeButton
                composeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8.0),
                composeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
                composeButton.widthAnchor.constraint(equalToConstant: 70.0),
                composeButton.heightAnchor.constraint(equalToConstant: 70.0),
               
                
                
                
            ])
        
        
        
        
    }
    
  

}
