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
        label.textAlignment = .center
        return UILabel()
    }()
    
    var positionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return UILabel()
    }()
    
    var teamLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return UILabel()
    }()
    
    func setupViews() {
        
        addSubview(roundLabel)
        addSubview(positionLabel)
        addSubview(teamLabel)
        
        roundLabel.frame = CGRect(x: 16, y: 0, width: 100, height: frame.height)
        positionLabel.frame = CGRect(x: 132, y: 0, width: 100, height: frame.height)
        teamLabel.frame = CGRect(x: 245, y: 0, width: 100, height: frame.height)
        
    }
    
}
