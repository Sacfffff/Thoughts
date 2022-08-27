//
//  SighUpViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class SighUpViewController: UIViewController {
    
    private var viewModel : SignUpViewModelProtocol = SignUpViewModel()
    private let headerView : SignHeaderView = {
        let view = SignHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let nameField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = .always
        textField.leftView =  UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.placeholder = "Full Name"
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 8.0
        textField.layer.masksToBounds = true
        return textField
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
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 38, height: 40))
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
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.placeholder = "Password"
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
    
    private let signUpButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
        title = "Create Account"
        view.backgroundColor = .systemBackground
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(nameField)
        signUpButton.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func signUpButtonDidTap(){
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let name = nameField.text, !name.isEmpty else {return}
       
        viewModel.present = { [weak self] in
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
        
        viewModel.signUp(email, password, name)
        
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
                
                //nameField
                nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                nameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                nameField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10.0),
                nameField.heightAnchor.constraint(equalToConstant: 50.0),
                
                //emailField
                emailField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                emailField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10.0),
                emailField.heightAnchor.constraint(equalToConstant: 50.0),
                
                //passwordField
                passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                passwordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10.0),
                passwordField.heightAnchor.constraint(equalToConstant: 50.0),
                
                //signUpButton
                signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
                signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
                signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10.0),
                signUpButton.heightAnchor.constraint(equalToConstant: 50.0),
                
                
            ])
        
        
        
        
    }
  

    
}
