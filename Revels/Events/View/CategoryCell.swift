//
//  CategoryCell.swift
//  Revels
//
//  Created by Vedant Jain on 24/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 8
        return label
    }()
    
    var ccLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(ccLabel)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 17
        
        setupTitleLabel()
        setupCCLabel()
        setupDescLabel()

    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    fileprivate func setupCCLabel() {
        ccLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        ccLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        ccLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        ccLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func setupDescLabel() {
        descLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 28).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: ccLabel.topAnchor, constant: -16).isActive = true
    }
    
}
