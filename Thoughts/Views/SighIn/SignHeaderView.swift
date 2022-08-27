//
//  SighInHeaderView.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 27.08.22.
//

import UIKit

class SignHeaderView: UIView {

    private let logoImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let logoLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20.0, weight: .medium)
        label.text = "Explore millioms of articles!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(logoLabel)
        addSubview(logoImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        
        
        NSLayoutConstraint.activate(
            [
                //logoImageView
                logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
                logoImageView.widthAnchor.constraint(equalToConstant: width / 4),
                logoImageView.heightAnchor.constraint(equalToConstant: width / 4),
                
                //logoLabel
                logoLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20.0),
                logoLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20.0),
                logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10.0)
                
                
                
            ])
        
        
        
        
    }
}
