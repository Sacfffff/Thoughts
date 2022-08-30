//
//  PostHeaderTableViewCell.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 30.08.22.
//

import UIKit

class PostHeaderTableViewCell: UITableViewCell {

    
    private let postImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(postImageView)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
            }
    
    func setUp(with model: PostHeaderModel) {
       
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



}
