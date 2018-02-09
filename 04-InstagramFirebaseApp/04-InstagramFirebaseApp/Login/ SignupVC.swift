//
//   ighup.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 29/01/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    
    let plusProfileImage: UIImageView = {
        
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "plus_photo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func createTextField (placeholder: String, cornerRadius: CGFloat) -> LeftPaddedTextField{
        
        let textField: LeftPaddedTextField = {
            
            
            let tf = LeftPaddedTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 40) , leftPadding: 10)
            tf.placeholder = placeholder
            tf.borderStyle = .roundedRect
            tf.layer.borderWidth = 1
            tf.layer.borderColor = UIColor.init(white: 0.8, alpha: 0.3).cgColor
            tf.layer.cornerRadius = cornerRadius
            tf.clearButtonMode = .always
            tf.backgroundColor = UIColor.init(white: 0.8, alpha: 0.4)
            
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
        
        return textField
        
    }
    
    lazy var emailTextField = createTextField(placeholder: "Email", cornerRadius: 5)
    lazy var usernameTextField = createTextField(placeholder: "Username", cornerRadius: 5)
    lazy var passwordTextField = createTextField(placeholder: "Password", cornerRadius: 5)
    
    let signupButton: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setTitle("Signup", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 0, green: 123, blue: 181, alpha: 0.4)
        btn.isEnabled = false
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(onSignup), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func onSignup () {
        
    }
    
    let goToLoginButton: UIButton = {
        
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 0.6, alpha: 0.5)])
        attributedTitle.append(NSAttributedString(string: "Login", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 0, green: 123, blue: 181, alpha: 1)]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(onGoToLogin), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func onGoToLogin () {
        print("Going to login")
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func setupView () {
        
        
        view.addSubview(plusProfileImage)
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signupButton)
        view.addSubview(goToLoginButton)
        
        
        plusProfileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        plusProfileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        stackView.distribution = .fillEqually
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.heightAnchor.constraint(equalToConstant: 220).isActive  = true
        
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: plusProfileImage.bottomAnchor, constant: 50).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        
        goToLoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        goToLoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        goToLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
}
