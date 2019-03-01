//
//  ResultsCell.swift
//  Revels
//
//  Created by Vedant Jain on 28/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupViews()
    }
    
    var roundLabel: UILabel = {
        let label = UILabel()
        return UILabel()
    }()
    
    var positionLabel: UILabel = {
        let label = UILabel()
        return UILabel()
    }()
    
    var teamLabel: UILabel = {
        let label = UILabel()
        return UILabel()
    }()
    
    func setupViews() {
        
        addSubview(roundLabel)
        addSubview(positionLabel)
        addSubview(teamLabel)
        
        //don't move this to label initialisers
        roundLabel.textAlignment = .center
        positionLabel.textAlignment = .center
        teamLabel.textAlignment = .center
        
        _ = roundLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: positionLabel.leftAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: (frame.width/3)-32, heightConstant: 0)
        _ = positionLabel.anchor(topAnchor, left: roundLabel.rightAnchor, bottom: bottomAnchor, right: teamLabel.leftAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: (frame.width/3)-32, heightConstant: 0)
        _ = teamLabel.anchor(topAnchor, left: positionLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: (frame.width/3)-32, heightConstant: 0)
        
    }
    
}
