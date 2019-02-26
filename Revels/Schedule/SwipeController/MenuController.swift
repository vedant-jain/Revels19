//
//  MenuController.swift
//  Revels
//
//  Created by Naman Jain on 19/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit

protocol MenuControllerDelegate {
    func didTapMenuItem(indexPath: IndexPath)
}

class MenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate let cellId = "cellId"
    fileprivate let menuItems = ["Day 1", "Day 2", "Day 3", "Day 4"]
    
    var delegate: MenuControllerDelegate?
    
    let menuBar: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let markerBar: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let shadowBar: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMenuItem(indexPath: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        view.addSubview(menuBar)
        view.addSubview(shadowBar)
        
        _ = shadowBar.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 0.5)
        _ = menuBar.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0.5, rightConstant: 0, widthConstant: view.frame.width/4, heightConstant: 10)
        menuBar.addSubview(markerBar)
        _ = markerBar.anchor(nil, left: menuBar.leftAnchor, bottom: menuBar.bottomAnchor, right: menuBar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.label.text = menuItems[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return .init(width: width / 4, height: view.frame.height)
    }

}
