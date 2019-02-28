//
//  MainTabBarController.swift
//  Revels
//
//  Created by Naman Jain on 12/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        
        //home page
        let homeViewController = HomeController(collectionViewLayout: StretchyHeaderLayout())
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        //schedule page
        let schedulePageController = ScheduleController(collectionViewLayout: UICollectionViewFlowLayout())
        let schedulePageNavigationController = UINavigationController(rootViewController: schedulePageController)
        schedulePageNavigationController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule"), tag: 1)
        
        
        let userViewController = UserController()
        userViewController.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "user"), tag: 0)
        
        //type page
        let typeController = TypeController(collectionViewLayout: UICollectionViewFlowLayout())
        let typeNavigationController = UINavigationController(rootViewController: typeController)
        typeNavigationController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(named: "categories"), tag: 2)
        
        
        //results page
        let resultsController = ResultsController()
        let resultsNavigationController = UINavigationController(rootViewController: resultsController)
        resultsNavigationController.tabBarItem = UITabBarItem(title: "Results", image: UIImage(named: "results"), tag: 3)
        
        //add to tab bar
        viewControllers = [homeViewController, typeNavigationController, userViewController, schedulePageNavigationController, resultsNavigationController]
    }
}
