//
//  ResultsCell.swift
//  Revels
//
//  Created by Vedant Jain on 27/02/19.
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
    
    var label: UILabel = {
        let label = UILabel()
        
        return UILabel()
    }()
    
    func setupViews() {
    
        addSubview(label)
        
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    
    }

}
