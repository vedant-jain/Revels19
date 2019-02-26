//
//  MenuCell.swift
//  Revels
//
//  Created by Naman Jain on 19/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "Menu Item"
        l.font = UIFont.systemFont(ofSize: 15)
        l.textAlignment = .center
        l.textColor = .lightGray
        return l
    }()
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .black : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        _ = label.anchor(safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
