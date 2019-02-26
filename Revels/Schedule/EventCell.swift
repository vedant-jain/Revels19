//
//  EventCell.swift
//  Revels
//
//  Created by Naman Jain on 12/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @objc let backgroundCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.08)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.numberOfLines = 0
        return label
    }()
    
    @objc let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    @objc let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitle()
    }
    
    private func setupTitle() {
        addSubview(backgroundCard)
        _ = backgroundCard.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        addSubview(titleLabel)
        _ = titleLabel.anchor(backgroundCard.topAnchor, left: backgroundCard.leftAnchor, bottom: nil, right: backgroundCard.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        addSubview(bodyLabel)
        _ = bodyLabel.anchor(titleLabel.bottomAnchor, left: backgroundCard.leftAnchor, bottom: nil, right: backgroundCard.rightAnchor, topConstant: 2, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        addSubview(dateLabel)
        _ = dateLabel.anchor(bodyLabel.bottomAnchor, left: backgroundCard.leftAnchor, bottom: backgroundCard.bottomAnchor, right: backgroundCard.rightAnchor, topConstant: 5, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension UIView {
    
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
}
