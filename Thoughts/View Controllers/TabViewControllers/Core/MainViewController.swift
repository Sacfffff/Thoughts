//
//  MainViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel : MainViewModelProtocol = MainViewModel()
    

    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(PostPreviewTableViewCell.self, forCellReuseIdentifier: "\(PostPreviewTableViewCell.self)")
        tableView.rowHeight = 100.0
        return tableView
    }()
    
    
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
        tableView.frame = view.bounds
    }

 
    private func setUpView(){
        view.backgroundColor = .systemBackground
        title = "Home"
        view.addSubview(tableView)
        view.addSubview(composeButton)
        composeButton.addTarget(self, action: #selector(composeButtondidTap), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.update = tableView.reloadData
        viewModel.fetchAllPosts()
      
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


//MARK: - extension UITableViewDataSource

extension MainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = viewModel.posts[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostPreviewTableViewCell.self)", for: indexPath) as? PostPreviewTableViewCell else { return .init() }
        cell.setUp(with: PostPreviewModel(title: post.title, imageURL: post.headerImageUrl))
        return cell
    }
    

    
}





//MARK: - extension UITableViewDelegate

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticksManager.shared.vibrateForSelection()
        guard TrackPostViewsManager.shared.canViewPost else {
            present(PayWallViewController(), animated: true)
            return
        }
        
        navigationController?.pushViewController(ViewPostViewController(post: viewModel.posts[indexPath.row]), animated: true)
    }
}
