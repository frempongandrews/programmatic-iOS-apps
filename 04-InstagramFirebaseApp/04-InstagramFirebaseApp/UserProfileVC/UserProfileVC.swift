//
//  UserProfileVC.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 29/01/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

//1. Conditional view in maintabbar
//TODO show current username and image


import UIKit
import Firebase

class UserProfileVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var user: User?
    
    //logout button
    
    
    
    
    fileprivate func setupLogoutButton () {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(onLogout))
        
        
    }
    
     @objc func onLogout () {
        print("logging out")
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            print("logout")
            
            do {
                try Auth.auth().signOut()
                
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarVC
                rootViewController.showLogin()
                
                
            } catch let err {
                print("Error while signing out ", err)
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionsheet.addAction(logoutAction)
        actionsheet.addAction(cancelAction)
        
        present(actionsheet, animated: true, completion: nil)
    }
    
    
    private func registerCells () {
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        //header
        collectionView?.register(UserProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    
    
    fileprivate func fetchUser () {

        print("fetching user")
        
        Database.database().reference().child("users").observeSingleEvent(of: .value) { (snapshot) in
            
            //print(snapshot.value)
            
            guard let usersDictionary = snapshot.value as? [String: Any] else { return }
            
            guard let currentUserDictionary = usersDictionary[Auth.auth().currentUser?.uid ?? ""] as? [String: Any] else { return }
            
            let currentUser = User(userDictionary: currentUserDictionary)
            
//            print(currentUser.username)
//            print(currentUser.userProfileImageUrl)
            
            self.user = currentUser
            self.navigationItem.title = currentUser.username
            
            self.collectionView?.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
       self.collectionView?.backgroundColor = .white
        
        setupLogoutButton()
        
        fetchUser()
        
       
        
        
    }//End viewDidLoad
    
    
    //header
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeaderCell
        
        header.user = self.user
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    

    
    //end header
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
}


