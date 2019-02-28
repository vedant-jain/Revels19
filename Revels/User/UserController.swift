//
//  ViewController.swift
//  IECSE
//
//  Created by Naman Jain on 25/10/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class UserController: UIViewController {
    
//    let parameters : Dictionary = ["email" : "user@iecse.com", "password" : "password"]
    
    var key: Int?
    
    var events = [Event]()
    var registeredEvents = [registeredEvent]()
    
    let masterScroll : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var logoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .red
        button.titleLabel?.textColor = .white
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    lazy var myEventsButton : UIButton = {
        let button = UIButton()
        button.setTitle("My Events", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(named: "gradient"), for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(handleShowEvents), for: .touchUpInside)
        return button
    }()
    
    let textLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.text = ""
        return label
    }()
    
    let titleLabel : UILabel = {
        
        let color = UIColor(white: 0.8, alpha: 1)
        let attributedText = NSMutableAttributedString(string: "Welcome", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 35, weight: .bold), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.black]))
        if let name = UserDefaults.standard.object(forKey: "name") as? String {
            attributedText.append(NSAttributedString(string: "\n\(name)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 24, weight: .medium), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.3, alpha: 1)])))
        }
        if let college = UserDefaults.standard.object(forKey: "college") as? String {
            attributedText.append(NSAttributedString(string: "\n\(college)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 17, weight: .medium), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.4, alpha: 1)])))
        }
        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            attributedText.append(NSAttributedString(string: "\n\(email)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 17, weight: .medium), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.4, alpha: 1)])))
        }
        if let ID = UserDefaults.standard.object(forKey: "type") as? Int {
            attributedText.append(NSAttributedString(string: "\nDelegate ID: \(ID)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 17, weight: .semibold), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.3, alpha: 1)])))
        }
        
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    let qrCodeView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    @objc let qrCodeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        return iv
    }()
    
    @objc let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "gradient")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
            masterScroll.alpha = 0
            perform(#selector(presentLogin), with: nil, afterDelay: 0)
        }else{
            masterScroll.alpha = 1
            if let memId = UserDefaults.standard.object(forKey: "memId") as? String {
                qrCodeImageView.sd_setImage(with: URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=\(memId)"))
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
            
        }else{
            getEvents()
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
                            self.events = events
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                self.getRegisteredEvents()
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
    
    
    func getRegisteredEvents(){
        Alamofire.request("https://register.mitrevels.in/registeredEvents", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(registeredEventsResponse.self, from: data)
                        self.registeredEvents = response.data
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
    
    
    func setupView(){
        view.addSubview(masterScroll)
        masterScroll.showsVerticalScrollIndicator = false
        masterScroll.addSubview(titleLabel)
        masterScroll.addSubview(textLabel)
        masterScroll.addSubview(qrCodeView)
        masterScroll.addSubview(myEventsButton)
        qrCodeView.addSubview(qrCodeImageView)
        masterScroll.addSubview(logoutButton)
        
        _  = qrCodeImageView.anchor(qrCodeView.topAnchor, left: qrCodeView.leftAnchor, bottom: qrCodeView.bottomAnchor, right: qrCodeView.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        
        masterScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        masterScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        masterScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        masterScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        masterScroll.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        masterScroll.contentSize = CGSize(width: 0, height: view.frame.size.height + textLabel.frame.size.height + imageView.frame.size.height + titleLabel.frame.size.height + qrCodeView.frame.size.height + 100)
        
        titleLabel.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: masterScroll.topAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        qrCodeView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        qrCodeView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        qrCodeView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        qrCodeView.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        textLabel.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        textLabel.topAnchor.constraint(equalTo: qrCodeView.bottomAnchor, constant: 16).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: myEventsButton.topAnchor, constant: -16).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        myEventsButton.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        myEventsButton.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        myEventsButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -16).isActive = true
        myEventsButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        myEventsButton.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
        
        
        logoutButton.leadingAnchor.constraint(equalTo: masterScroll.leadingAnchor, constant: 16).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: masterScroll.trailingAnchor, constant: 16).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: masterScroll.bottomAnchor, constant: -16).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: masterScroll.centerXAnchor).isActive = true
    }
    @objc func presentLogin(){
        masterScroll.scrollToTop()
        self.logoutUser()
        let loginController = LoginController()
        loginController.userController = self
        self.present(loginController, animated: true, completion: nil)
    }
    @objc func handleLogout(){
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: "You're about to Logout", message: "Are you sure?", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let dismissAction = UIAlertAction(title: "Logout", style: .destructive, handler: { (action) in
                self.presentLogin()
            })
            alertController.addAction(defaultAction)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    @objc func handleShowEvents(){
        print(registeredEvents.count)
        DispatchQueue.main.async {
            let eventVC = MyEventsTableViewController()
            eventVC.events = self.events
            eventVC.registeredEvents = self.registeredEvents
            let eventNavVC = UINavigationController(rootViewController: eventVC)
            self.present(eventNavVC, animated: true, completion: nil)
        }
    }
    
    func updateInfo(){
        masterScroll.alpha = 1
        let attributedText = NSMutableAttributedString(string: "Welcome", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 35, weight: .bold), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor.black]))
        if let name = UserDefaults.standard.object(forKey: "name") as? String {
            attributedText.append(NSAttributedString(string: "\n\(name)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 24, weight: .medium), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.3, alpha: 1)])))
        }
        if let college = UserDefaults.standard.object(forKey: "college") as? String {
            attributedText.append(NSAttributedString(string: "\n\(college)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 17, weight: .medium), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.4, alpha: 1)])))
        }
        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            attributedText.append(NSAttributedString(string: "\n\(email)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 17, weight: .medium), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.4, alpha: 1)])))
        }
        if let ID = UserDefaults.standard.object(forKey: "type") as? Int {
            attributedText.append(NSAttributedString(string: "\nDelegate ID: \(ID)", attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 17, weight: .semibold), convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): UIColor(white: 0.3, alpha: 1)])))
        }
        titleLabel.attributedText = attributedText
        if let memId = UserDefaults.standard.object(forKey: "memId") as? String {
            qrCodeImageView.sd_setImage(with: URL(string: "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=\(memId)"))
        }
    }
    
    func logoutUser(){
        Alamofire.request("https://register.mitrevels.in/logout", method: .get, parameters: nil).responseJSON{ response in
            switch response.result {
            case .success:
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                break
            case .failure(let error):
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                UserDefaults.standard.synchronize()
                print(error)
            }
        }
    }
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}
