//
//  CategoryCell.swift
//  Revels
//
//  Created by Vedant Jain on 16/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class categoryCell1: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CellIcons")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Category Name"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    let category: UILabel = {
        let label = UILabel()
        label.text = "RemoveThisLabel"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()
    
    func setupViews() {
        
        addSubview(imageView)
        addSubview(title)
        addSubview(category)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        title.frame = CGRect(x: 0, y: frame.width, width: frame.width, height: 40)
        category.frame = CGRect(x: 0, y: frame.width + 27, width: frame.width, height: 20)
        
    }
    
}
