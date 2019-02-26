//
//  CategoriesController.swift
//  Revels
//
//  Created by Vedant Jain on 16/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class CategoriesController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let padding: CGFloat = 16
    fileprivate var lightStatusBar: Bool = true
    
    
    var myAnimator: UIViewPropertyAnimator?
    
    var headerView: HeaderView?
    
    let headerBar: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Categories"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCustomNavigationBar()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    fileprivate func setupCustomNavigationBar() {
        view.addSubview(headerBar)
        headerBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(), size: CGSize.init(width: view.frame.width, height: 45+UIApplication.shared.statusBarFrame.height))
        headerBar.addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: headerBar.leadingAnchor, bottom: headerBar.bottomAnchor, trailing: headerBar.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 16, bottom: 16, right: 16), size: CGSize.init())
        headerBar.alpha = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if lightStatusBar{
            return .lightContent
        }else{
            return .default
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        headerView?.animator.fractionComplete = (-contentOffsetY / 100) - 0.25
        
        if contentOffsetY > view.frame.width*1080/1920 - (UIApplication.shared.statusBarFrame.height+45){
            self.lightStatusBar = false
            setNeedsStatusBarAppearanceUpdate()
            setWhiteStatusBar()
        }else{
            self.lightStatusBar = true
            setNeedsStatusBarAppearanceUpdate()
            setClearStatusBar()
        }
    }
    
    
    
    func setWhiteStatusBar(){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar.backgroundColor = .clear
            self.headerBar.alpha = 1
        }, completion: nil)
    }
    
    func setClearStatusBar(){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar.backgroundColor = .clear
            self.headerBar.alpha = 0
        }, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderView
        return headerView!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width*1080/1920)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-42)/2, height: 214)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
}
