//
//  EventCell.swift
//  Revels
//
//  Created by Vedant Jain on 26/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class EEventCell: UICollectionViewCell {
    
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
    
    var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    var delegateCardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(sizeLabel)
        addSubview(delegateCardLabel)
        
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 17
        
        setupTitleLabel()
        setupSizeLabel()
        setupDescLabel()
        setupDelegateCardLabel()
        
    }
    
    fileprivate func setupDelegateCardLabel() {
        delegateCardLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        delegateCardLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width-150).isActive = true
        delegateCardLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        delegateCardLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    fileprivate func setupSizeLabel() {
        sizeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        sizeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        sizeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        sizeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    fileprivate func setupDescLabel() {
        descLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 28).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: sizeLabel.topAnchor, constant: -16).isActive = true
    }
    
}
