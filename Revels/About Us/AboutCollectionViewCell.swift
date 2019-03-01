//
//  AboutCollectionViewCell.swift
//  Revels
//
//  Created by Vedant Jain on 01/03/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class AboutCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "header"))
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 4.0
        //dont remove, assets have weird black lines
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.cornerRadius = 61
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let platformLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(postLabel)
        addSubview(platformLabel)
        
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: titleLabel.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets.init(top: 16, left: 16, bottom: 8, right: 16), size: CGSize(width: 100, height: 122))
        titleLabel.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: postLabel.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets.init(top: 8, left: 16, bottom: 0, right: 16), size: CGSize())
        postLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets.init(top: 4, left: 16, bottom: 6, right: 16), size: CGSize())
        platformLabel.anchor(top: postLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets.init(top: 8, left: 16, bottom: 0, right: 16), size: CGSize())
    }
}
