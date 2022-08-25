//
//  PayWallHeaderView.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 25.08.22.
//

import UIKit

class PayWallHeaderView: UIView {

    
    private let headerImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "crown.fill"))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(headerImageView)
        backgroundColor = .systemPink
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       // headerImageView.center = self.center
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        
        
        NSLayoutConstraint.activate(
            [
                //HeaderImageView
                headerImageView.widthAnchor.constraint(equalToConstant: 110),
                headerImageView.heightAnchor.constraint(equalToConstant: 110),
                headerImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                headerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                
                
                
            ])
        
        
        
        
    }
    
}
