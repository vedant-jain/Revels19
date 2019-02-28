//
//  CategoriesController.swift
//  Revels
//
//  Created by Vedant Jain on 16/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let padding: CGFloat = 16
    fileprivate var lightStatusBar: Bool = true
    var categories = [Categories]()
    
    var myAnimator: UIViewPropertyAnimator?
    
    var headerView: HeaderView?
    
    let headerBar: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Revels'19"
        return label
    }()

    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(categoryCell1.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    func getCategories(){
//       print(UserDefaults.standard.array(forKey: "categories"))
        
        Alamofire.request("https://api.mitrevels.in/categories", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                        if let categories = response.data{
                            self.categories = categories
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.collectionView.refreshControl?.endRefreshing()
                                self.collectionView.reloadData()
                                print("Succesfully got data")
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

    
    fileprivate func setupCustomNavigationBar() {
        view.addSubview(headerBar)
        headerBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.init(), size: CGSize.init(width: view.frame.width, height: 45+UIApplication.shared.statusBarFrame.height))
        headerBar.addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: headerBar.leadingAnchor, bottom: headerBar.bottomAnchor, trailing: headerBar.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: 16, bottom: 10, right: 16), size: CGSize.init())
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width*1080/1920)
    }
    
    func setWhiteStatusBar(){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar.backgroundColor = .white
        }, completion: nil)
    }
    
    func setClearStatusBar(){
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            statusBar.backgroundColor = .clear
        }, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? HeaderView
        return headerView!
    }
    
    
    private let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupCustomNavigationBar()
        getCategories()
        getUserDetails()
        getRegisteredEvents()
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        collectionView.dataSource = self;
        collectionView.delegate = self;

        
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeCell
        cell.title.text = categories[indexPath.item].name
        cell.subtitle.text = categories[indexPath.item].description
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let description = categories[indexPath.item].description {
            return CGSize(width: view.frame.width, height: 160 + getHeight(for: description, font: UIFont.systemFont(ofSize: 15), width: view.frame.width - 32))
        }
        return CGSize(width: view.frame.width, height: 200)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func getHeight(for string: String, font: UIFont, width: CGFloat) -> CGFloat {
        let textStorage = NSTextStorage(string: string)
        let textContainter = NSTextContainer(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainter)
        textStorage.addLayoutManager(layoutManager)
        textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, textStorage.length))
        textContainter.lineFragmentPadding = 0.0
        layoutManager.glyphRange(for: textContainter)
        return layoutManager.usedRect(for: textContainter).size.height
    }
    
    func getUserDetails(){
        Alamofire.request("https://register.mitrevels.in/userProfile", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(userProfileResponse.self, from: data)
                        print(response.data)
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
    
    func getRegisteredEvents(){
        Alamofire.request("https://register.mitrevels.in/registeredEvents", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(registeredEventsResponse.self, from: data)
                        print(response.data)
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
}


class CategoryTableViewController: UITableViewController {
    var categories = [Categories]()
    
    override func viewDidLoad() {
        getCategories()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Revels'19"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func getCategories(){
        Alamofire.request("https://api.mitrevels.in/categories", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                        if let categories = response.data{
                            self.categories = categories.sorted(by: { $0.name!.lowercased() < $1.name!.lowercased() })
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.tableView.reloadData()
                                print("Succesfully got data")
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
    
    func getEvents(){
        Alamofire.request("https://api.mitrevels.in/events", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(EventResponse.self, from: data)
                        if let events = response.data{
                            print(events)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }

    
    
}
