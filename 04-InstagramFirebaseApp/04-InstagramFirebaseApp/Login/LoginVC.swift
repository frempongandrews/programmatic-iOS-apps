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
        v.heightAnchor.constraint(equalToConstant: 220).isActive = true
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
    
    let loginButton: UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("Login", for: .normal)
        btn.backgroundColor = UIColor.rgb(red: 0, green: 123, blue: 181, alpha: 0.4)
        btn.isEnabled = false
        btn.setTitleColor(.white, for: .normal)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let goToSignupButton: UIButton = {
        
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dont have an account? ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(white: 0.6, alpha: 0.5)])
        attributedTitle.append(NSAttributedString(string: "Signup", attributes: [NSAttributedStringKey.foregroundColor : UIColor.rgb(red: 0, green: 123, blue: 181, alpha: 1)]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(onGoToSignup), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc func onGoToSignup () {
        print("Going to signup")
        
        let signupVC = SignupVC()
        
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    
    func setupView () {
        
        view.addSubview(topBar)
        view.addSubview(logo)
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(goToSignupButton)
        
        
        
        topBar.addSubview(logo)
        logo.centerXAnchor.constraint(equalTo: topBar.centerXAnchor  , constant:  0).isActive = true
        logo.centerYAnchor.constraint(equalTo: topBar.centerYAnchor, constant: 0).isActive = true
        
        topBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, loginButton])
        stackView.distribution = .fillEqually
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.heightAnchor.constraint(equalToConstant: 220).isActive  = true
        
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 50).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        
        goToSignupButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        goToSignupButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        goToSignupButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        
        setupView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


class LeftPaddedTextField: UITextField {
    
    var leftPadding: CGFloat
    
     init(frame: CGRect, leftPadding: CGFloat) {
        
        self.leftPadding = leftPadding
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + leftPadding , y: bounds.origin.y, width: bounds.width + leftPadding , height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + leftPadding, y: bounds.origin.y, width: bounds.width + leftPadding, height: bounds.height)
    }
    
}

extension UIColor {
    
    static func rgb (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
        
    }
    
}
