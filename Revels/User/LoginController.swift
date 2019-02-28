//
//  LoginController.swift
//  IECSE
//
//  Created by Naman Jain on 6/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit
import Alamofire
import Lottie
import AudioToolbox
import SafariServices

class LoginController: UIViewController {
    
    var userController : UserController?
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    
    lazy var loginButton: LoadingButton = {
        let button = LoadingButton(type: .system)
        button.backgroundColor = UIColor.init(r: 35, g: 35, b: 35)
        button.setTitle("Login", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    func handleIncompleteDetails(text: String){
        loginButton.setTitle(text, for: UIControl.State())
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.loginButton.setTitle("Login", for: UIControl.State())
            
        })
        return
        
    }
    @objc func handleLogin(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            handleIncompleteDetails(text: "Invalid Format")
            return
        }
        if email == "" && password == ""{
            handleIncompleteDetails(text: "Please enter your Credentials")
            return
        }
        if email == ""{
            handleIncompleteDetails(text: "Please enter your Email ID")
            return
        }
        if validateEmail(enteredEmail: email) == false {
            handleIncompleteDetails(text: "Invalid Email ID")
            return
        }
        if password == ""{
            handleIncompleteDetails(text: "Please enter your Password")
            return
        }
        view.endEditing(true)
        self.loginButton.showLoading()
        let parameters : Dictionary = ["email" : email, "password" : password]
        

        Alamofire.request("https://register.mitrevels.in/loginios", method: .post, parameters: parameters).responseJSON{ response in
            switch response.result {
            case .success:
                guard let items = response.result.value as? [String:AnyObject] else {
                    DispatchQueue.main.async(execute: {
                        self.loginButton.hideLoading()
                        let alertController = UIAlertController(title: "Unable to Fetch Data", message: "Please try again later.", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    })
                    return
                }

                if items["success"] as? Bool == true{
                    self.getUserDetails()
                }else{
                    self.loginButton.hideLoading()
                    self.handleIncompleteDetails(text: "Incorrect Credentials, please try again.")
                    self.emailTextField.becomeFirstResponder()
                }
                break
            case .failure(let error):
                self.loginButton.hideLoading()
                self.handleIncompleteDetails(text: "Uh, Oh! The server is not responding.")
                AudioServicesPlaySystemSound(1521)
                print(error)
            }
        }
    }
    
    func getUserDetails(){
        Alamofire.request("https://register.mitrevels.in/userProfile", method: .get, parameters: nil).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(userProfileResponse.self, from: data)
                        let data = response.data
                        
                            UserDefaults.standard.set(data.id, forKey: "type")
                        if let memId = data.qr{
                            UserDefaults.standard.set(memId, forKey: "memId")
                        }
                        if let name = data.name{
                            UserDefaults.standard.set(name, forKey: "name")
                        }
                        if let collname = data.collname {
                            UserDefaults.standard.set(collname, forKey: "college")
                        }
                        if let email = data.email{
                            UserDefaults.standard.set(email, forKey: "email")
                        }
                        if let phone = data.mobile{
                            UserDefaults.standard.set(phone, forKey: "phone")
                        }
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        AudioServicesPlaySystemSound(1520)
                        UserDefaults.standard.synchronize()
                        self.userController?.updateInfo()
                        self.dismiss(animated: true, completion: nil)
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
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "revels")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var bottomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
//        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openRevelsWebsite)))
        return imageView
    }()
    
    let animationView: LOTAnimationView = {
        let view = LOTAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.alpha = 0
        view.setAnimation(named: "bubble")
        view.play()
        view.loopAnimation = true
        return view
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.init(r: 35, g: 35, b: 35)
        button.setTitle("Sign Up", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(openSignUpUrl), for: .touchUpInside)
        return button
    }()
    
    lazy var continueAsGuestButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.init(r: 35, g: 35, b: 35)
        button.setTitle("Continue as Guest", for: UIControl.State())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(dismissLogin), for: .touchUpInside)
        return button
    }()
    
    @objc func openSignUpUrl(){
        if let url = URL(string: "https://register.mitrevels.in"){
            UIApplication.shared.open(url)
        }
    }
    
    @objc func dismissLogin(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateEmail(enteredEmail: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        observeKeyboardNotifications()
        
        view.backgroundColor = UIColor.init(r: 35, g: 35, b: 35)
        
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.addSubview(continueAsGuestButton)
        view.addSubview(profileImageView)
        view.addSubview(bottomImageView)
        view.addSubview(animationView)
        
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()


    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    @objc func willEnterForeground() {
        animationView.play()
    }
    
    func setupProfileImageView() {
        //need x, y, width, height constraints
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        animationView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        animationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -15).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        bottomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bottomImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        bottomImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        

        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)

        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setupLoginRegisterButton() {
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 9).isActive = true
        signupButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        continueAsGuestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueAsGuestButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 9).isActive = true
        continueAsGuestButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        continueAsGuestButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.animationView.alpha = 0
            self.profileImageView.alpha = 1
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = -90
            self.animationView.alpha = 1
            self.profileImageView.alpha = 0
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
}

