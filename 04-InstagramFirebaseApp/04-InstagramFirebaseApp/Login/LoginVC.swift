//
//  LoginVC.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 29/01/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    let topBar: UIView = {
       
        let v = UIView()
        v.backgroundColor = UIColor.rgb(red: 0, green: 123, blue: 181, alpha: 1)
        
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return v
        
    }()
    
    let logo: UIImageView = {
       
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Instagram_logo_white")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func createTextField (placeholder: String, cornerRadius: CGFloat) -> UITextField{
        
        let textField: UITextField = {
           
            let tf = UITextField()
            tf.placeholder = placeholder
            tf.layer.borderWidth = 1
            tf.layer.cornerRadius = cornerRadius
            
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
        
        return textField
        
    }
    
    lazy var emailTextField = createTextField(placeholder: "Email", cornerRadius: 5)
    
    
    func setupHeader () {
        
        view.addSubview(topBar)
        view.addSubview(logo)
        
        topBar.addSubview(logo)
        logo.centerXAnchor.constraint(equalTo: topBar.centerXAnchor  , constant:  0).isActive = true
        logo.centerYAnchor.constraint(equalTo: topBar.centerYAnchor, constant: 0).isActive = true
        
        topBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupHeader()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


extension UIColor {
    
    static func rgb (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
        
    }
    
}
