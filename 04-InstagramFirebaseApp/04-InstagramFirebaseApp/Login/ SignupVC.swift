//
//   ighup.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 29/01/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit
import Firebase

//TODO: create user class with details saved to database


class SignupVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    @objc func onChooseProfileImage () {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing   = true
        imagePickerController.delegate = self
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image: UIImage?
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = originalImage
            plusProfileImageButton.setImage(image, for: .normal)
            
        }
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = editedImage
            plusProfileImageButton.setImage(image, for: .normal)
        }
        
        plusProfileImageButton.layer.cornerRadius = 75
        plusProfileImageButton.layer.borderColor = UIColor.black.cgColor
        plusProfileImageButton.layer.borderWidth = 1
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //choose profile image
    
    
    
    
    
    
    //choose profile image: Cho
    
    let plusProfileImageButton: UIButton = {
        
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(onChooseProfileImage), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    func createTextField (placeholder: String, cornerRadius: CGFloat, isSecureTextEntry: Bool ) -> LeftPaddedTextField{
        
        let textField: LeftPaddedTextField = {
            
            let tf = LeftPaddedTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 40) , leftPadding: 10)
            tf.placeholder = placeholder
            tf.isSecureTextEntry = isSecureTextEntry
            tf.borderStyle = .roundedRect
            tf.layer.borderWidth = 1
            tf.layer.borderColor = UIColor.init(white: 0.8, alpha: 0.3).cgColor
            tf.layer.cornerRadius = cornerRadius
            tf.clearButtonMode = .always
            tf.backgroundColor = UIColor.init(white: 0.8, alpha: 0.4)
            tf.addTarget(self, action: #selector(onDetailsChange), for: .editingChanged)
            
            tf.delegate = self
            tf.translatesAutoresizingMaskIntoConstraints = false
            return tf
        }()
        
        return textField
        
    }
    
    lazy var emailTextField = createTextField(placeholder: "Email", cornerRadius: 5, isSecureTextEntry: false)
    lazy var usernameTextField = createTextField(placeholder: "Username", cornerRadius: 5, isSecureTextEntry: false)
    lazy var passwordTextField = createTextField(placeholder: "Password", cornerRadius: 5, isSecureTextEntry: true)
    
    @objc func onDetailsChange () {
        if let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text {
            if email.characters.count > 4 && username.characters.count > 4 && password.characters.count > 4 {
                signupButton.isEnabled = true
                signupButton.backgroundColor = UIColor.rgb(red: 0, green: 123, blue: 181, alpha: 1)
            }
        } else {
            
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 0, green: 123, blue: 181, alpha: 0.4)
        }
    }
    
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
    
    
    func confirmSignup () -> UIView {
        let confirmView: UIView = {
            let v = UIView()
            v.backgroundColor = UIColor.rgb(red: 0, green: 255, blue: 0, alpha: 1)
            
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        return confirmView
    }
    
    
    
    @objc func onSignup () {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        //signup - creating user
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            
            if let err = err {
                print("An error has occured ", err)
                return
            }
            
            
            let userId = user?.uid
            
            //save image to storage
            
            guard let userProfileImage = self.plusProfileImageButton.imageView?.image else { return }
            guard let uploadedProfileImage = UIImageJPEGRepresentation(userProfileImage, 0.3) else { return }
            let uploadedProfileImageName = NSUUID().uuidString
            
            Storage.storage().reference().child("profileImages").child(uploadedProfileImageName).putData(uploadedProfileImage, metadata: nil, completion: { (metadata, err) in
                
                if let err = err {
                    print("Error while storing profile image", err)
                    return
                }
                
                let uploadedImageUrl = metadata?.downloadURL()?.absoluteString
                
                
                //save user to database
                
                if let userId = userId {
                    
                    let userDetails = ["username": username, "userProfileImage": uploadedImageUrl]
                    //let userDictionary = [userId: userDetails]
                    
                    //get user with specific uid
                    Database.database().reference().child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        snapshot.ref.updateChildValues(userDetails)
                        
                        
                        //show green bar confirming it
                        self.confirmSignup()
                        
                        
                    }, withCancel: { (err) in
                        print("An error has occurred", err)
                    })
                    
                }
                
            })
        }
        
        //clear text fields
        
        emailTextField.text = ""
        usernameTextField.text = ""
        passwordTextField.text = ""
        
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
    
    //keyboard observer
    
    func observeKeyboardNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func onKeyboardWillShow () {
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }
        
    }
    
    @objc func onKeyboardWillHide () {
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
        
    }
    
    func setupView () {
        
        
        view.addSubview(plusProfileImageButton)
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signupButton)
        view.addSubview(goToLoginButton)
        
        
        plusProfileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        plusProfileImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        plusProfileImageButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        plusProfileImageButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        stackView.distribution = .fillEqually
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.heightAnchor.constraint(equalToConstant: 220).isActive  = true
        
        
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: plusProfileImageButton.bottomAnchor, constant: 50).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        
        goToLoginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        goToLoginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        goToLoginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
    }
    
    //textfield hide
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        
        
        
        observeKeyboardNotifications()
        
        
    }//End viewDidLoad
    
}







































