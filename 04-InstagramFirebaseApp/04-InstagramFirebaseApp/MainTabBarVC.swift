//
//  MainTabBarVC.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 29/01/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    fileprivate func createTabBarController (selectedIcon: UIImage, unselectedIcon: UIImage) -> UINavigationController {
        
        let layout = UICollectionViewFlowLayout()
        let VC = UICollectionViewController(collectionViewLayout: layout)
        let NavVC = UINavigationController(rootViewController: VC)
        
        NavVC.tabBarItem.image = unselectedIcon
        NavVC.tabBarItem.selectedImage = selectedIcon
        
        return NavVC
        
    }
    
    @objc func showLogin () {
        
        let loginVC = LoginVC()
        let loginNavController = UINavigationController(rootViewController: loginVC)
        present(loginNavController, animated: true, completion: nil)
    }
    
    func setupViewControllers () {
        
        //user like plus search home
        
        //like button
        let likeVC = createTabBarController(selectedIcon: #imageLiteral(resourceName: "like_selected"), unselectedIcon: #imageLiteral(resourceName: "like_unselected"))
        
        //plus add pic
        
        let plusVC = createTabBarController(selectedIcon: #imageLiteral(resourceName: "plus_unselected"), unselectedIcon: #imageLiteral(resourceName: "plus_unselected"))
        
        //search
        
        let searchVC = createTabBarController(selectedIcon: #imageLiteral(resourceName: "search_selected"), unselectedIcon: #imageLiteral(resourceName: "search_unselected"))
        
        //home
        
        let homeVC = createTabBarController(selectedIcon: #imageLiteral(resourceName: "home_selected"), unselectedIcon: #imageLiteral(resourceName: "home_unselected"))
        
        //user profile
        let userProfileLayout = UICollectionViewFlowLayout()
        let userProfileVC = UserProfileVC(collectionViewLayout: userProfileLayout)
        let userProfileVCNav = UINavigationController(rootViewController: userProfileVC)
        
        
        userProfileVCNav.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileVCNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        UITabBar.appearance().tintColor = .black
        
        viewControllers = [userProfileVCNav, homeVC, plusVC, searchVC, likeVC]
        
        //set tab bar items at right position
        
        guard let items = tabBar.items else  { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        //show login if no current user
        if (Auth.auth().currentUser?.uid == nil) {
            
            perform(#selector(showLogin), with: nil, afterDelay: 0.01)
            return
        }
        
       
        view.backgroundColor = .white
        
        setupViewControllers()
        
        
        
    }//End viewDidLoad
    
    
    
    
}// End Of Tab Bar VC

extension MainTabBarVC{
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        
        //print(index)
        
        if index == 2 {
            
            let layout = UICollectionViewFlowLayout()
            
            let photoSelectorVC = PhotoSelectorVC(collectionViewLayout: layout)
            
            let navPhotoSelectorVC = UINavigationController(rootViewController: photoSelectorVC)
            
            present(navPhotoSelectorVC, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    
    
    
    
    
    
    
    
}
