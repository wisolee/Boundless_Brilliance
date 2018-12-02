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
    var tab_bar_ctrl: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarController()
        
        // Do any additional setup after loading the view.
        let chapter_schedule_VC = PresentationListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        chapter_schedule_VC.title = "My Chapter Schedule"
        
        let personal_schedule_vc = UIViewController()
        personal_schedule_vc.title = "My Schedule"
        personal_schedule_vc.view.backgroundColor = UIColor.red

        tab_bar_ctrl.viewControllers = [chapter_schedule_VC, personal_schedule_vc]

    }
    
    func createTabBarController() {
        tab_bar_ctrl = UITabBarController()
        tab_bar_ctrl.delegate = self
        tab_bar_ctrl.tabBar.barStyle = .black
        
        addChild(tab_bar_ctrl)
        self.view.addSubview(tab_bar_ctrl.view)
        tab_bar_ctrl.didMove(toParent: self)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Tabbar controller tapped")
    }
}
