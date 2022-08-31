//
//  CreateNewPostViewController.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 23.08.22.
//

import UIKit

class CreateNewPostViewController: UIViewController {
    
    private var viewModel : CreatePostViewModelProtocol = CreatePostViewModel()

    private let headerImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        //imageView.clipsToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        return imageView
    }()
    
    private let titleField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 50.0))
        textField.leftViewMode = .always
        textField.placeholder = "Enter title..."
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.masksToBounds = true
        return textField
    }()
    
    private let textView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        textView.backgroundColor = .secondarySystemBackground
        textView.font = .systemFont(ofSize: 28)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    
    private func setupView(){
        title = "Create Post"
        view.backgroundColor = .systemBackground
        view.addSubview(headerImageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerViewDidTap))
        headerImageView.addGestureRecognizer(tap)
        view.addSubview(textView)
        view.addSubview(titleField)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonDidTap))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(postButtonDidTap))
    }
    
    

    @objc private func cancelButtonDidTap(){
        dismiss(animated: true)
    }
  
    @objc private func postButtonDidTap(){
        guard let title = titleField.text,
              let body = textView.text,
              let headerImage = viewModel.selectedHeaderImage,
        !title.trimmingCharacters(in: .whitespaces).isEmpty,
        !body.trimmingCharacters(in: .whitespaces).isEmpty,
        let email = UserDefaults.standard.string(forKey: ConstantKeysUserDefaults.kEmail) else {
            let alert = UIAlertController(title: "Enter post details", message: "Please enter the information to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
 
        DispatchQueue.main.async { [weak self] in
            HapticksManager.shared.vibrate(for: .success)
            self?.viewModel.cancel = self?.cancelButtonDidTap
            self?.viewModel.uploadBlogHeaderImage(email: email, headerImage: headerImage, postTitle: title, postBody: body)
        }
       
      
        
    }
    
    @objc private func headerViewDidTap(){
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

    
    private func setupConstraints(){
        
        
        
        NSLayoutConstraint.activate(
            [
                
                //titleField
                titleField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0),
                titleField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
                titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                titleField.heightAnchor.constraint(equalToConstant: 50.0),
                
                //headerImageView
                headerImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                headerImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                headerImageView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 8.0),
                headerImageView.heightAnchor.constraint(equalToConstant: 160),
            
                
                //textView
                textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0),
                textView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
                textView.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10.0),
                textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                
                
                
            ])
        
        
        
        
    }
}

//MARK: - extension UINavigationControllerDelegate, UIImagePickerControllerDelegate 
extension CreateNewPostViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        viewModel.selectedHeaderImage = image
        headerImageView.image = image
    }
}
