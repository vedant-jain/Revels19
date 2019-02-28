//
//  ScheduleController.swift
//  Revels
//
//  Created by Naman Jain on 19/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit
import Alamofire
import DeckTransition

class ScheduleController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MenuControllerDelegate{
    
    var day1Array = [ScheduleEvent]()
    var day2Array = [ScheduleEvent]()
    var day3Array = [ScheduleEvent]()
    var day4Array = [ScheduleEvent]()
    
    var events = [Event]()
    var schedule = [Schedule]()
    
    var screenHeight : CGFloat = 200
    
    fileprivate let menuController = MenuController(collectionViewLayout: UICollectionViewFlowLayout())
    
    fileprivate let cellId = "cellId"
    fileprivate let cellId1 = "cellId1"
    fileprivate let cellId2 = "cellId2"
    fileprivate let cellId3 = "cellId3"
    fileprivate let cellId4 = "cellId4"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuController.delegate = self
        menuController.collectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .centeredHorizontally)
        
        self.collectionView.allowsSelection = false
        self.collectionView.isScrollEnabled = false
        
        setupNavigationBar()
        setupLayout()
        setupCollectionView()
        getEvents()
        calculateScreenHeight()
    }
    
    fileprivate func setupNavigationBar() {
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let titleLabel = UILabel()
        titleLabel.text = "Schedule"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.sizeToFit()
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
    }
    
    func presentEventCard(event : ScheduleEvent){
        var message = event.event?.long_desc
        if let min = event.event?.min_size{
            if let max = event.event?.max_size{
                message?.append("\n\nMinimum team size: \(min)\nMaximum team size: \(max)")
            }
        }
        
        let actionSheet = UIAlertController(title: event.event?.name, message: message, preferredStyle: .actionSheet)

        let cancel = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let reminderAction = UIAlertAction(title: "Set Reminder", style: .default){ action in
            
            return
        }
        let registerAction = UIAlertAction(title: "Register for Event", style: .default){ action in
            if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
                DispatchQueue.main.async(execute: {
                    let alertController = UIAlertController(title: "Sign in to Register", message: "You need to be signed in to register.", preferredStyle: UIAlertController.Style.alert)
                    let logInAction = UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
                        let loginController = LoginController()
                        self.present(loginController, animated: true, completion: nil)
                    })
                    let createNewAccountAction = UIAlertAction(title: "Create New Account", style: .default, handler: { (action) in
                        if let url = URL(string: "https://register.mitrevels.in"){
                            UIApplication.shared.open(url)
                        }
                    })
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    alertController.addAction(logInAction)
                    alertController.addAction(createNewAccountAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                })
                return
            }else{

            guard let id = event.event?.id else {
                return
            }
            let parameters : Dictionary = ["eventid" : id]
            
            
            Alamofire.request("https://register.mitrevels.in/createteam", method: .post, parameters: parameters).responseJSON{ response in
                switch response.result {
                case .success:
                    guard let items = response.result.value as? [String:AnyObject] else {
                        DispatchQueue.main.async(execute: {
                            let alertController = UIAlertController(title: "Unable to Fetch Data", message: "Please try again later.", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        })
                        return
                    }
                    if items["success"] as! Int == 1 {
                        DispatchQueue.main.async(execute: {
                            let alertController = UIAlertController(title: "Congatulations!", message: "You have successfully registered for \(String(describing: event.event?.name)).", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                            self.present(alertController, animated: true, completion: nil)
                        })
                    }else{
                        guard let message = items["msg"]  else {
                            DispatchQueue.main.async(execute: {
                                let alertController = UIAlertController(title: "Uh, Oh!", message: "Some issue occured, please try again later.", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)
                            })
                            return
                        }
                        if message as! String == "Card for event not bought" {
                            DispatchQueue.main.async(execute: {
                                let alertController = UIAlertController(title: "Uh, Oh!", message: "You have not bought the delegate card that is required for this event.", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)
                            })
                        }else if message as! String == "User already registered for event" {
                            DispatchQueue.main.async(execute: {
                                let alertController = UIAlertController(title: "Yay!", message: "You have already registered for this event.", preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)
                            })
                        }else{
                            DispatchQueue.main.async(execute: {
                                let alertController = UIAlertController(title: "Uh, Oh!", message: message as? String, preferredStyle: .alert)
                                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alertController.addAction(defaultAction)
                                self.present(alertController, animated: true, completion: nil)
                            })
                        }

                    }
                    break
                case .failure(let error):
                    print(error)
                }
            }
            }
        }
        actionSheet.addAction(registerAction)
        actionSheet.addAction(reminderAction)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)

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
    
    func calculateScreenHeight(){
        if let tabBarHeight = self.tabBarController?.tabBar.frame.height{
            print(tabBarHeight)
            if let navBarHeight = self.navigationController?.navigationBar.intrinsicContentSize.height{
                print(navBarHeight)
                let guide = view.safeAreaLayoutGuide
                let height = guide.layoutFrame.size.height - (UIApplication.shared.statusBarFrame.height + tabBarHeight + navBarHeight + 60)
                self.screenHeight = height
            }
        }
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView.allowsSelection = true
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        //each day cell has been registered seperately to prevent reusage of cells which caused a very weird bug.
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
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
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! MainCell
        if indexPath.item == 0{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! MainCell
            cell.data = day1Array
        }else if indexPath.item == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId2, for: indexPath) as! MainCell
            cell.data = day2Array
        }else if indexPath.item == 2{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId3, for: indexPath) as! MainCell
            cell.data = day3Array
        }else if indexPath.item == 3{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId4, for: indexPath) as! MainCell
            cell.data = day4Array

        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId1, for: indexPath) as! MainCell
            cell.data = []
        }
        cell.screenHeight = screenHeight
        cell.scheduleController = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let navBarHeight = self.navigationController?.navigationBar.intrinsicContentSize.height{
            return .init(width: view.frame.width, height: view.frame.height - 40 -  UIApplication.shared.statusBarFrame.height - navBarHeight)
        }
        
        return .init(width: view.frame.width, height: view.frame.height - 40 - 44 - UIApplication.shared.statusBarFrame.height)
    }
    
    func getEvents(){
        Alamofire.request("https://api.mitrevels.in/events", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(EventResponse.self, from: data)
                        if let events = response.data{
                            self.events = events
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                self.getSchedule()
                                print("Succesfully got events")
                            }
                        }else{
                            print("Coudnt get data")
                        }
                    }catch let error{
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSchedule(){
        Alamofire.request("https://api.mitrevels.in/schedule", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(ScheduleResponse.self, from: data)
                        if let schedule = response.data{
                            self.schedule = schedule
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                print("Succesfully got schedule")
                                self.makeSchedule()
                            }
                        }else{
                            print("Coudnt get data")
                        }
                    }catch let error{
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func makeSchedule(){
        var eventId = [Int]()
        for item in events{
            eventId.append(item.id)
        }
        
        let eventDict = NSMutableDictionary(objects: events, forKeys: eventId as [NSCopying])
        
        for item in schedule {
            guard let start = item.start, let end = item.end, let venue = item.location, let round = item.round else {
                return
            }
            let event = eventDict[item.event] as! Event
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            let startDate = formatter.date(from: start)
            let endDate = formatter.date(from: end)
            formatter.dateFormat = "h:mm a"
            var dateString = formatter.string(from: startDate!)
            dateString.append(" - \(formatter.string(from: endDate!))")
            formatter.dateFormat = "EEEE"
            let dayString = formatter.string(from: startDate!)
            
            switch (dayString){
            case "Tuesday":
                day1Array.append(ScheduleEvent(event: event, time: dateString, venue: venue, round: round))
            case "Wednesday":
                day2Array.append(ScheduleEvent(event: event, time: dateString, venue: venue, round: round))
            case "Thursday":
                day3Array.append(ScheduleEvent(event: event, time: dateString, venue: venue, round: round))
            case "Friday":
                day4Array.append(ScheduleEvent(event: event, time: dateString, venue: venue, round: round))
            default:
                print("no day found")
            }
            //reload collectionview with the schedule
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0), IndexPath(item: 1, section: 0), IndexPath(item: 2, section: 0), IndexPath(item: 3, section: 0)])
                self.collectionView.allowsSelection = true
                self.collectionView.isScrollEnabled = true
            }
        }
    }
    
}

