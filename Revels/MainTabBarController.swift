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
        let homeViewController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let homeViewNavigationController = UINavigationController(rootViewController: homeViewController)
        homeViewNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        //schedule page
        let schedulePageController = ScheduleController(collectionViewLayout: UICollectionViewFlowLayout())
        let schedulePageNavigationController = UINavigationController(rootViewController: schedulePageController)
        schedulePageNavigationController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "schedule"), tag: 1)
        
//        //categories page
//        let categoriesController = CategoriesController(collectionViewLayout: StretchyHeaderLayout())
//        categoriesController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(named: "categories"), tag: 2)
        
        //type page
        let typeController = TypeController(collectionViewLayout: UICollectionViewFlowLayout())
        let typeNavigationController = UINavigationController(rootViewController: typeController)
        typeNavigationController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(named: "events"), tag: 2)
        
        //results page
        let resultsController = ResultsController()
        let resultsNavigationController = UINavigationController(rootViewController: resultsController)
        resultsNavigationController.tabBarItem = UITabBarItem(title: "Results", image: UIImage(named: "results"), tag: 3)
        
        //add to tab bar
        viewControllers = [homeViewNavigationController, schedulePageNavigationController, typeNavigationController, resultsNavigationController]
        
    }
}
