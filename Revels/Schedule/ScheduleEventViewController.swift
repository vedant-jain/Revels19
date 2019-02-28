//
//  ModalViewController.swift
//  DeckTransition
//
//  Created by Harshil Shah on 15/10/16.
//  Copyright © 2016 Harshil Shah. All rights reserved.
//

import UIKit
import DeckTransition

class ScheduleEventViewController: UIViewController {
    
    var key: Int?
    
    let masterScroll : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        return view
    }()
    let directionButton : UIButton = {
        let button = UIButton()
        button.setTitle("Apply Now", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .lightGray
        button.titleLabel?.textColor = .white
        return button
    }()
    
    let textLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    @objc let timeCard: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9375504851, blue: 0.9077358842, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc let venueCard: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9375504851, blue: 0.9077358842, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc let maxCard: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9375504851, blue: 0.9077358842, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc let minCard: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9375504851, blue: 0.9077358842, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc let delegateCard: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9375504851, blue: 0.9077358842, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textLabel1 : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Time:\nVenue:\nMax Team Size:\nMin Team Size:\nDelegate Card:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    let textLabel2 : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Time:\nVenue:\nMax Team Size:\nMin Team Size:\nDelegte Card:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    @objc let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationCapturesStatusBarAppearance = true
        
        view.backgroundColor = .white
        view.addSubview(masterScroll)
        masterScroll.addSubview(titleLabel)
        masterScroll.addSubview(textLabel)
        masterScroll.addSubview(timeCard)
        masterScroll.addSubview(venueCard)
        masterScroll.addSubview(maxCard)
        masterScroll.addSubview(minCard)
        masterScroll.addSubview(delegateCard)
//        masterScroll.addSubview(textLabel1)
//        masterScroll.addSubview(textLabel2)
        
        masterScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        masterScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        masterScroll.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        masterScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        masterScroll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let height = timeCard.frame.size.height + venueCard.frame.size.height + 100 + minCard.frame.size.height + maxCard.frame.size.height + delegateCard.frame.size.height
        masterScroll.contentSize = CGSize(width: 0, height: view.frame.size.height + textLabel.frame.size.height + imageView.frame.size.height + titleLabel.frame.size.height + height)
        
        titleLabel.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: masterScroll.topAnchor, constant: 25).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        
        textLabel.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: timeCard.topAnchor, constant: -16).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        timeCard.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        timeCard.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        timeCard.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16).isActive = true
        timeCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        timeCard.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        venueCard.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        venueCard.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        venueCard.topAnchor.constraint(equalTo: timeCard.bottomAnchor, constant: 16).isActive = true
        venueCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        venueCard.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        maxCard.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        maxCard.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        maxCard.topAnchor.constraint(equalTo: venueCard.bottomAnchor, constant: 16).isActive = true
        maxCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        maxCard.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        minCard.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        minCard.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        minCard.topAnchor.constraint(equalTo: maxCard.bottomAnchor, constant: 16).isActive = true
        minCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        minCard.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        delegateCard.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        delegateCard.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        delegateCard.topAnchor.constraint(equalTo: minCard.bottomAnchor, constant: 16).isActive = true
        delegateCard.heightAnchor.constraint(equalToConstant: 100).isActive = true
        delegateCard.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        
        
//        textLabel1.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
//        textLabel1.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
//        textLabel1.topAnchor.constraint(equalTo: timeCard.bottomAnchor, constant: 16).isActive = true
//        textLabel1.bottomAnchor.constraint(equalTo: masterScroll.bottomAnchor, constant: -16).isActive = true
//        textLabel1.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
//
//        textLabel2.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
//        textLabel2.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
//        textLabel2.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 16).isActive = true
//        textLabel2.bottomAnchor.constraint(equalTo: masterScroll.bottomAnchor, constant: -16).isActive = true
//        textLabel2.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true

        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
	
}
