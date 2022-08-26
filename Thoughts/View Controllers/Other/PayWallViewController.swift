//
//  PayWallViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 25.08.22.
//

import UIKit


class PayWallViewController: UIViewController {
    
    private var viewModel : PayWallViewModelProtocol = PayWallViewModel()
    
    private let header : PayWallHeaderView =  {
        let header = PayWallHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private let heroView : PayWallDescriptionView = {
        let view = PayWallDescriptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let restoreButton : UIButton = {
        let button = UIButton()
        button.setTitle("Restore Purchases", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let termsView : UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textAlignment = .center
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 14)
        textView.text = "This is auto-renewable Subscription. it will be charged to you iTunes account before each pay period. You can cancel anytime by Settings > Subscriptions. Restore purchases if previously subscribed."
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
    private func setupView() {
        title = "Thoughts Premium"
        view.backgroundColor = .systemBackground
        view.addSubview(header)
        view.addSubview(buyButton)
        view.addSubview(restoreButton)
        view.addSubview(termsView)
        view.addSubview(heroView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonDidTap))
        setUpButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        setupConstraints()
    }
    
    private func setUpButtons() {
        buyButton.addTarget(self, action: #selector(subscribeButtonDidTap), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func closeButtonDidTap() {
        dismiss(animated: true)
    }

    @objc private func subscribeButtonDidTap() {
        viewModel.success = { [weak self] in self?.dismiss(animated: true) }
        viewModel.failure =  { [weak self] in self?.createAlert(title: "Subscriptopn Failed", message: "We were unable to complete the transaction", preferredStyle: .alert) }
        viewModel.subscribe()
        
    }
    
    
    @objc private func restoreButtonDidTap() {
        viewModel.success = { [weak self] in self?.dismiss(animated: true) }
        viewModel.failure =  { [weak self] in  self?.createAlert(title: "Restorations Failed", message: "We were unable to restore a previous  transaction", preferredStyle: .alert)}
        viewModel.restore()
        
        }
    

private func createAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
     self.present(alert, animated: true)
}

    
    private func setupConstraints(){
        
      
        
        NSLayoutConstraint.activate(
            [
                
                //Header
                header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                header.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                header.widthAnchor.constraint(equalTo: view.widthAnchor),
                header.heightAnchor.constraint(equalToConstant: view.height/3.2),
                
                // Restore Button
                restoreButton.bottomAnchor.constraint(equalTo: termsView.topAnchor, constant: -15.0),
                restoreButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 14.0),
                restoreButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -14.0),
    
                //Buy Button
                buyButton.bottomAnchor.constraint(equalTo: restoreButton.topAnchor, constant: -15.0),
                buyButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 14.0),
                buyButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -14.0),

                
                //termsView
                termsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                termsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0),
                termsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20.0),
                termsView.heightAnchor.constraint(equalToConstant: 100.0),
                
                //heroView
                heroView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20.0),
                heroView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                heroView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                heroView.bottomAnchor.constraint(equalTo: buyButton.topAnchor, constant: -20.0)
               
            ])
        
      
        

}

}
