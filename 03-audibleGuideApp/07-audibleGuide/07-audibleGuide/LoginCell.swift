//
//  LoginCell.swift
//  07-audibleGuide
//
//  Created by Andrews Frempong on 29/12/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//


import UIKit

class LoginCell: UICollectionViewCell {
    
    
    
    let loginPageImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "logo")
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    lazy var emailTextField: LeftPaddedTextField = {
        
        let tv = LeftPaddedTextField()
        tv.placeholder = "Enter email"
        //        tv.backgroundColor = .black
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.init(white: 0.9, alpha: 1).cgColor
        tv.keyboardType = .emailAddress
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()
    
    lazy var passwordTextField: LeftPaddedTextField = {
        
        let tv = LeftPaddedTextField()
        tv.placeholder = "Enter password"
        //        tv.backgroundColor = .black
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.init(white: 0.9, alpha: 1).cgColor
        tv.isSecureTextEntry = true
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()
    
    
    let loginButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    func setupCell () {
        
        //add to cell
        
        addSubview(loginPageImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        
        //constraints
        
        loginPageImageView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        loginPageImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginPageImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        loginPageImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        emailTextField.topAnchor.constraint(equalTo: loginPageImageView.bottomAnchor, constant: 30).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        //vertical spacing 20
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}//end LoginCell


//<!-- left padding placeholders -->

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}

