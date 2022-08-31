//
//  SighInViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit




class SighInViewController: UIViewController {
    
    private var viewModel : SignInViewModelProtocol = SignInViewModel()
    
    private let headerView : SignHeaderView = {
        let view = SignHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        let userImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        userImage.image = UIImage(systemName: "person")
        userImage.tintColor = .gray
        userImage.contentMode = .scaleAspectFit
        userImage.backgroundColor = .clear
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftView.backgroundColor = .clear
        leftView.addSubview(userImage)
        textField.leftViewMode = .always
        textField.leftView = leftView
        textField.placeholder = "Email Address"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8.0
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let passwordField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        let userImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        userImage.image = UIImage(systemName: "lock")
        userImage.tintColor = .gray
        userImage.contentMode = .scaleAspectFit
        userImage.backgroundColor = .clear
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftView.backgroundColor = .clear
        leftView.addSubview(userImage)
        textField.leftViewMode = .always
        textField.leftView = leftView
        textField.isSecureTextEntry = true
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8.0
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = true
        return button
    }()
    
    private let createAccountButton : UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4.0
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       setUpView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setUpView(){
        title = "Sign In"
        view.backgroundColor = .systemBackground
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)
        signInButton.addTarget(self, action: #selector(signInButtonDidTap), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonDidTap), for: .touchUpInside)
    }
    
   
    @objc private func signInButtonDidTap(){
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {return}
        
        HapticksManager.shared.vibrateForSelection()
     
        viewModel.present = { [weak self] in
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
        
        viewModel.signIn(email, password)
    }

    @objc private func createAccountButtonDidTap(){
        navigationController?.pushViewController(SighUpViewController(), animated: true)
    }
    
    private func setupConstraints(){
        
        
        
        NSLayoutConstraint.activate(
            [
                //HeaderView
                headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                headerView.heightAnchor.constraint(equalToConstant: view.height / 5),
                
                //emailField
                emailField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                emailField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor),
                emailField.heightAnchor.constraint(equalToConstant: 50.0),
                
                //passwordField
                passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                passwordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10.0),
                passwordField.heightAnchor.constraint(equalToConstant: 50.0),
                
                //signInButton
                signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10.0),
                signInButton.heightAnchor.constraint(equalToConstant: 50.0),
                
                //createAccountButtom
                createAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                createAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                createAccountButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 40.0),
                createAccountButton.heightAnchor.constraint(equalToConstant: 50.0)
                
            ])
        
        
        
        
    }
  

}
