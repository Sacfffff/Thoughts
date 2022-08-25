//
//  PayWallDescriptionView.swift
//  Thoughts
//
//  Created by Aleks Kravtsova on 25.08.22.
//

import UIKit

class PayWallDescriptionView: UIView {

    private let descriptorLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26.0, weight: .medium)
        label.numberOfLines = 0
        label.text = "Join Thoughts Premium to read unlimited posts and articles and browse  thousands of posts!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22.0, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "$4.99 / month"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(descriptorLabel)
        addSubview(priceLabel)
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

                //descriptorLabel
                descriptorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30.0),
                descriptorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20.0),
                descriptorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20.0),
               
                //priceLabel
                priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40.0),
                priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20.0),
                priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20.0)
                
                
            ])
        
        
        
        
    }
}
