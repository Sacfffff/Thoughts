//
//  PostPreviewTableViewCell.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 30.08.22.
//

import UIKit

class PostPreviewTableViewCell: UITableViewCell {
    
    private let postImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()
    
    private let postTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
        contentView.addSubview(postTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        postTitleLabel.text = nil
    }
    
    func setUp(with model: PostPreviewModel) {
        postTitleLabel.text = model.title
       
        if let data = model.imageData {
            postImageView.image = UIImage(data: data)
        } else if let url = model.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self]  data, _, _ in
                guard let data = data else {
                    return
                }
                
                model.imageData = data
                DispatchQueue.main.async {
                    self?.postImageView.image = UIImage(data: data)
                }

            }.resume()
        }
    }

    
    private func setupConstraints(){
        
        
        
        NSLayoutConstraint.activate(
            [

                //postImageView
                postImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2.0),
                postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
                postImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
                postImageView.widthAnchor.constraint(equalToConstant: contentView.height - 10.0),
                
              //postTitleLabel
                postTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
                postTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),
                postTitleLabel.leftAnchor.constraint(equalTo: postImageView.rightAnchor, constant: 5.0),
                postTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        
        
        
        
    }
    
}
