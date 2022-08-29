//
//  ProfileViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class ProfileViewController: UIViewController {

    private var viewModel : ProfileViewModelProtocol
    
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setUpTableView()
      
  
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    init(email: String) {
        viewModel = ProfileViewModel(email: email)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - setUpView
    private func setUpView(){
        title = "Profile"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sigh Out",
                                                            style: .plain,
                                                            target: self, action: #selector(sighOutDidTap))
        viewModel.update = tableView.reloadData
        viewModel.present = { [weak self] in
            self?.setUpTableHeader(
                profilePhotoRef: self?.viewModel.user?.profilePictureRef,
                name: self?.viewModel.user?.name)
        }
        viewModel.fetchProfileData()
        viewModel.fetchPosts()
       
      
    }
   
    //MARK: - setUpTableView
    private func setUpTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setUpTableHeader()
       
    }
    
   
    //MARK: - setUpTableHeader
    private func setUpTableHeader(profilePhotoRef: String? = nil, name: String? = nil) {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width / 1.5))
        headerView.backgroundColor = .systemBlue
        headerView.isUserInteractionEnabled = true
        headerView.clipsToBounds = true
        tableView.tableHeaderView = headerView
        
        let profilePhoto = createProfilePicture(headerView.height)
        headerView.addSubview(profilePhoto)
       
        
        let emailLabel = createEmailLabel(profilePhoto.bottom + 10.0)
        headerView.addSubview(emailLabel)
        

        if let ref = profilePhotoRef {
            
            viewModel.downloadUrlForProfilePicture(ref: ref) { image in
                profilePhoto.image = image
            }

        }
       
    }
    
    //MARK: - createProfilePicture
    private func createProfilePicture(_ y: CGFloat) -> UIImageView {
        let profilePhoto = UIImageView(image: UIImage(systemName: "person.circle"))
        profilePhoto.tintColor = .white
        profilePhoto.contentMode = .scaleAspectFit
        profilePhoto.frame = CGRect(x: (view.width - (view.width / 4.0)) / 2.0,
                                    y: (y - (view.width / 4.0)) / 2.5,
                                    width: view.width / 4.0,
                                    height: view.width / 4.0)
        profilePhoto.isUserInteractionEnabled = true
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.cornerRadius = profilePhoto.width / 2.0
        let tap = UITapGestureRecognizer(target: self, action: #selector(profilePhotoDidTap))
        profilePhoto.addGestureRecognizer(tap)
        return profilePhoto
    }
    
    //MARK: - createEmailLabel
    private func createEmailLabel(_ y: CGFloat) -> UILabel {
        let emailLabel = UILabel(frame: CGRect(x: 20.0, y: y, width: view.width - 40.0, height: 100.0))
        emailLabel.text = viewModel.currentEmail
        emailLabel.textColor = .label
        emailLabel.textAlignment = .center
        emailLabel.font = .systemFont(ofSize: 25.0, weight: .bold)
        return emailLabel
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


    @objc private func profilePhotoDidTap(){
        guard let myEmail = UserDefaults.standard.string(forKey: ConstantKeysUserDefaults.kEmail),
              myEmail == viewModel.currentEmail else {
            return
        }
        
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        let alert = UIAlertController(title: "Choose source", message: "Select what you want", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default,handler: {  _ in
            picker.sourceType = .camera
            self.present(picker, animated: true)
        }))
       alert.addAction(UIAlertAction(title: "Gallery", style: .default,handler: { _ in
          picker.sourceType = .photoLibrary
           self.present(picker, animated: true)
       }))
       alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }

}


//MARK: - extension UITableViewDataSource

extension ProfileViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = viewModel.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = post.title
        return cell
    }
    
    
}





//MARK: - extension UITableViewDelegate

extension ProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(ViewPostViewController(), animated: true)
    }
}

extension ProfileViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
    
       viewModel.uploadUserProfileLPicture(image: image)
    }
}
