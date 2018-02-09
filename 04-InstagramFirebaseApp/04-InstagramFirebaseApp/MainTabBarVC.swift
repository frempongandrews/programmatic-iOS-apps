//
//  MainTabBarVC.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 29/01/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
        //user profile
        let userProfileLayout = UICollectionViewFlowLayout()
        let userProfileVC = UserProfileVC(collectionViewLayout: userProfileLayout)
        let userProfileVCNav = UINavigationController(rootViewController: userProfileVC)
        
        userProfileVCNav.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileVCNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        UITabBar.appearance().tintColor = .black
        
        
        
        viewControllers = [userProfileVCNav, UIViewController()]
        
    }//End viewDidLoad
    
    
    
    
}// End Of Tab Bar VC
