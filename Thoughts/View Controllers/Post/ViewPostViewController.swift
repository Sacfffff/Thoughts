//
//  ViewPostViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

enum ViewPostSections : Int {
    case title = 0
    case header = 1
    case body = 2
}

class ViewPostViewController: UIViewController {
    
    private let viewModel : ViewPostViewModelProtocol
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PostHeaderTableViewCell.self, forCellReuseIdentifier: "\(PostHeaderTableViewCell.self)")
        return tableView
    }()

    init(post: BlogPost, isOwnedByCurrentUser: Bool = false){
        viewModel = ViewPostViewModel(post: post, isOwnedByCurrentUser: isOwnedByCurrentUser)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

    private func setupView() {
        title = "Post"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        if !viewModel.isOwnedByCurrentUser {
            viewModel.logPostViewed()
        }
    }

}

//MARK: - extension UITableViewDataSource
extension ViewPostViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = ViewPostSections(rawValue: indexPath.row)
        switch type {
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = .systemFont(ofSize: 25.0, weight: .bold)
            cell.textLabel?.text = viewModel.post.title
            cell.selectionStyle = .none
            return cell
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostHeaderTableViewCell.self)", for: indexPath) as? PostHeaderTableViewCell else { return .init() }
            cell.setUp(with: PostHeaderModel(imageURL: viewModel.post.headerImageUrl))
            cell.selectionStyle = .none
            return cell
        case .body:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            cell.textLabel?.text = viewModel.post.text
            return cell
        case .none:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = ViewPostSections(rawValue: indexPath.row)
        switch type {
        case .title:
            return UITableView.automaticDimension
        case .header:
            return 150.0
        case .body:
            return UITableView.automaticDimension
        case .none:
            fatalError()
        }
    }
}


//MARK: - extension UITableViewDelegate
extension ViewPostViewController : UITableViewDelegate {
    
}
