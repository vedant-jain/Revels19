//
//  CategoriesController.swift
//  Revels
//
//  Created by Vedant Jain on 16/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SFSafariViewControllerDelegate {
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate let postID = "postID"
    
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
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupCustomNavigationBar()
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: postID)
        
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
        
        if (indexPath.item == 1) {
            let cell: PostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: postID, for: indexPath) as! PostCollectionViewCell
            cell.headerLabel.text = "MIT Post"
            cell.newsletterButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
            cell.newsletterButton.setBackgroundImage(UIImage(named: "newspaper"), for: .normal)
            cell.newsletterButton.tag = 0
            cell.liveBlogButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
            cell.liveBlogButton.tag = 1
            cell.liveBlogButton.setBackgroundImage(UIImage(named: "newspaper2"), for: .normal)
            cell.instagramButton.tag = 2
            cell.instagramButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)
            cell.instagramButton.setBackgroundImage(UIImage(named: "ig-1"), for: .normal)
            return cell
        } else {
            let cell: HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
            cell.title.text = "Events Today"
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM, EEEE"
            let dayText = formatter.string(from: currentDate)
            cell.subtitle.text = dayText
            return cell
        }
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: 400)
        }
        
        return CGSize(width: view.frame.width, height: 300)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    @objc func openLink(sender: UIButton) {
        var urlString = ""
        var url = URL(string: urlString)
        if sender.tag == 0 {
            // open newsletter
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            let day = String((Int(formatter.string(from: currentDate)) ?? -1) - 6)
            formatter.dateFormat = "HH"
            let hours = formatter.string(from: currentDate)
            urlString = "https://google.com/"
            if Int(day) == 0 {
                urlString.append(String(0))
            }
            else{
                if (Int(hours) ?? -1 < 8) {
                    //show previous day's
                    urlString.append(String((Int(day) ?? -1)-1))
                } else {
                    // show
                    urlString.append(day)
                }
            }
            url = URL(string: urlString)
            let safariVC = SFSafariViewController(url: url ?? URL(string: "https://google.com")!)
            self.present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        }
        else if sender.tag == 1 {
            // open live blog
            urlString = "http://themitpost.com/revels-19-liveblog"
            url = URL(string: urlString)
            let safariVC = SFSafariViewController(url: url ?? URL(string: "https://google.com")!)
            self.present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        }
        else {
            // open instagram
            let Username =  "revelsmit"
            let appURL = URL(string: "instagram://user?username=\(Username)")!
            let application = UIApplication.shared
            
            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else {
                // if Instagram app is not installed, open URL inside Safari
                let webURL = URL(string: "https://instagram.com/\(Username)")!
                application.open(webURL)
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
    
}
