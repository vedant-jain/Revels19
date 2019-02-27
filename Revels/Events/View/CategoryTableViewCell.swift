//
//  CategoryTVCell.swift
//  Revels
//
//  Created by Vedant Jain on 27/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class CategoryTVCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        setupViews()
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
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
    
    var callButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 0.5 * button.bounds.size.width // add the round corners in proportion to the button size
        
        
        return button
    }()
    
    var backgroundCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 17
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews() {
        
        addSubview(backgroundCard)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(callButton)
        
        //for testing
        backgroundCard.frame = CGRect(x: 16, y: 16, width: self.frame.width-32, height: self.frame.height-32)
        titleLabel.frame = CGRect(x: 32, y: 32, width: self.frame.width-64, height: 25)
        descLabel.frame = CGRect(x: 32, y: 80, width: self.frame.width-64, height: 130)
        callButton.frame = CGRect(x: 32, y: 220, width: self.frame.width-64, height: 32)
        
//        setupTitleLabel()
//        setupCallButton()
//        setupDescLabel()
//        setupBackgroundCard()
        
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 32).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 32).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    fileprivate func setupCallButton() {
        callButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = false
        callButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 16).isActive = true
        callButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        callButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    fileprivate func setupDescLabel() {
        descLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 28).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: callButton.topAnchor, constant: 16).isActive = true
    }
    
    fileprivate func setupBackgroundCard() {
//        backgroundCard.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16).isActive = true
//        backgroundCard.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -16).isActive = true
//        backgroundCard.trailingAnchor.constraint(equalTo: descLabel.trailingAnchor, constant: 16).isActive = true
//        backgroundCard.bottomAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 16).isActive = true
        
        
        backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        backgroundCard.bottomAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 16).isActive = true

    }

}
