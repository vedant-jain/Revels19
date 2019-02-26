//
//  CategoryCell.swift
//  Revels
//
//  Created by Vedant Jain on 16/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class TypeCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bigtrans")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bigtrans")
        imageView.alpha = 0.2
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    var category: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    func setupViews() {
        addSubview(bgImageView)
        addSubview(imageView)
        addSubview(title)
        addSubview(category)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 17
        
        imageView.frame = CGRect(x: 23, y: 16, width: 50, height: 50)
        title.frame = CGRect(x: 96, y: 16, width: frame.width, height: 25)
        category.frame = CGRect(x: 96, y: 42, width: frame.width, height: 20)
        bgImageView.frame = CGRect(x: 15, y: 0, width: 250, height: 250)
        
    }
    
}
