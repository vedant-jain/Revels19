//
//  LoaderTVCell.swift
//  IECSE
//
//  Created by Naman Jain on 15/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LoaderTVCell: UITableViewCell {
    
    let animationView: LOTAnimationView = {
        let view = LOTAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.setAnimation(named: "l3")
        view.play()
        view.loopAnimation = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(animationView)
        print("animating")
        _ = animationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        _ = animationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        _ = animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        _ = animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

