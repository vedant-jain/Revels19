//
//  HomeCell.swift
//  Revels
//
//  Created by Vedant Jain on 15/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    private let cell2 = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // row is 0 for the first row, otherwise 1
    
    let cellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cellCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cellCollectionView.backgroundColor = .white
        cellCollectionView.showsHorizontalScrollIndicator = false
        cellCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return cellCollectionView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Anubhuti"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Want to express your words and thoughts in Hindi but can’t find a stage to display it? Have a knack of writing poems and articles on topics ranging from feelings to political agendas?You know the name"
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let dividerLineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    func setupViews() {
//        backgroundColor = .black
        addSubview(title)
        addSubview(subtitle)
        addSubview(cellCollectionView)
        addSubview(dividerLineView)
        
        cellCollectionView.dataSource = self
        cellCollectionView.delegate = self
        cellCollectionView.register(DetailsCell.self, forCellWithReuseIdentifier: cellID)
        cellCollectionView.register(SliderCell.self, forCellWithReuseIdentifier: cell2)
        
        _ = title.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 22)
        _ = subtitle.anchor(title.bottomAnchor, left: leftAnchor, bottom: cellCollectionView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        _ = cellCollectionView.anchor(nil, left: leftAnchor, bottom: dividerLineView.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 16, rightConstant: 0, widthConstant: 0, heightConstant: 100)
        _ = dividerLineView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
        
        
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": title]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": subtitle]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cellCollectionView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[title(30)][subtitle][cell][divider(0.5)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["cell": cellCollectionView, "divider": dividerLineView, "title": title, "subtitle": subtitle]))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! DetailsCell
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }

}

