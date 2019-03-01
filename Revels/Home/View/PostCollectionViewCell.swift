//
//  PostCollectionViewCell.swift
//  Revels
//
//  Created by Vedant Jain on 28/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    let newsletterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Daily Newsletter", for: .normal)
        return button
    }()
    
    let liveBlogButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("Live Blog", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let instagramButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("@revelsmit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        
        addSubview(headerLabel)
        addSubview(newsletterButton)
        addSubview(liveBlogButton)
        addSubview(instagramButton)
        
        self.bringSubviewToFront(headerLabel)
        
        _ = headerLabel.anchor(topAnchor, left: leftAnchor, bottom: newsletterButton.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 25)
        _ = newsletterButton.anchor(headerLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 100)
        _ = liveBlogButton.anchor(newsletterButton.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 116, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 100)
        _ = instagramButton.anchor(liveBlogButton.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 116, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 100)
        
    }
    
}
