//
//  ScheduleController.swift
//  Revels
//
//  Created by Naman Jain on 19/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit

struct Event{
    let eventName: String?
    let eventTime: String?
    let eventVenue: String?
    let eventDate: String?
    let eventType: String?
    
    init(name: String, time: String, venue: String, date: String, type: String) {
        self.eventName = name
        self.eventTime = time
        self.eventVenue = venue
        self.eventDate = date
        self.eventType = type
    }
    
    func returnName() -> String{
        if let name = eventName{
            return name
        }
        return "event n/a"
    }
}


class ScheduleController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MenuControllerDelegate{
    
    var day1Array : [Event] = [Event(name: "Day 1 Event", time: "nil", venue: "nil", date: "nil", type: "nil"), Event(name: "Day1 event 2", time: "", venue: "", date: "", type: "")]
    var day2Array = ["Day 2", "Phantom", "Chinatown", "Hello Children"]
    var day3Array = ["Day 3", "PineApple", "KIWI"]
    var day4Array = ["Day 4", "Sweet Lime"]
    
    fileprivate let menuController = MenuController(collectionViewLayout: UICollectionViewFlowLayout())
    
    fileprivate let cellId1 = "cellId1"
    fileprivate let cellId2 = "cellId2"
    fileprivate let cellId3 = "cellId3"
    fileprivate let cellId4 = "cellId4"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuController.delegate = self
        menuController.collectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .centeredHorizontally)
        
        setupNavigationBar()
        setupLayout()
        setupCollectionView()
    }
    
    fileprivate func setupNavigationBar() {
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationItem.title = "Schedule"
        
        let titleLabel = UILabel()
        titleLabel.text = "Schedule"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let favButton = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: self, action: #selector(handleFavourite))
        favButton.tintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        _ = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleRefresh))
        navigationItem.rightBarButtonItems = [favButton]
    }
    
    @objc func handleFavourite(){
        print("Handle Favourite")
    }
    
    @objc func handleRefresh(){
        print("Handle Refresh")
    }
    
    fileprivate func setupLayout() {
        let menuView = menuController.view!
        view.addSubview(menuView)
        _ = menuView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        collectionView.backgroundColor = .white
        _ = collectionView.anchor(menuView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0 )
    }
    
    func didTapMenuItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / 4
        menuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.allowsSelection = true
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        //each day cell has been registered seperately to prevent reusage of cells which caused a very weird bug.
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: cellId1)
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: cellId2)
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: cellId3)
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: cellId4)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! MainCell
            cell.data = day1Array
            return cell
        }else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! MainCell
            cell.data = day1Array
            return cell
        }else if indexPath.item == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath) as! MainCell
            cell.data = day1Array
            return cell
        }else if indexPath.item == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! MainCell
            cell.data = day1Array
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! MainCell
            cell.data = []
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let navBarHeight = self.navigationController?.navigationBar.intrinsicContentSize.height{
            return .init(width: view.frame.width, height: view.frame.height - 40 -  UIApplication.shared.statusBarFrame.height - navBarHeight)
        }
        
        return .init(width: view.frame.width, height: view.frame.height - 40 - 44 - UIApplication.shared.statusBarFrame.height)
    }
    
}

