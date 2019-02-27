//
//  EventTableViewCell.swift
//  Revels
//
//  Created by Vedant Jain on 27/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
    }
    
    var backgroundCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 17
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        
        addSubview(backgroundCard)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(sizeLabel)
        addSubview(delegateCardLabel)
        
        setupTitleLabel()
        setupSizeLabel()
        setupDescLabel()
        setupDelegateCardLabel()
        setupBackgroundCard()
        
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
    
    fileprivate func setupBackgroundCard() {
        backgroundCard.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -16).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: descLabel.trailingAnchor, constant: 16).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 16).isActive = true
    }
    
}
