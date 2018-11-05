//
//  TabBarViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 11/4/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController, UITabBarControllerDelegate {
    // Tab Controller
    var tabBarCtrl: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarController()
        
        // Do any additional setup after loading the view.
        let chapterScheduleVC = PresentationListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        chapterScheduleVC.title = "My Chapter Schedule"
        
        let personalScheduleVC = UIViewController()
        personalScheduleVC.title = "My Schedule"
        personalScheduleVC.view.backgroundColor = UIColor.red

        tabBarCtrl.viewControllers = [chapterScheduleVC, personalScheduleVC]

    }
    
    func createTabBarController() {
        tabBarCtrl = UITabBarController()
        tabBarCtrl.delegate = self
        tabBarCtrl.tabBar.barStyle = .black
        
        addChild(tabBarCtrl)
        self.view.addSubview(tabBarCtrl.view)
        tabBarCtrl.didMove(toParent: self)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Tabbar controller tapped")
    }
}
