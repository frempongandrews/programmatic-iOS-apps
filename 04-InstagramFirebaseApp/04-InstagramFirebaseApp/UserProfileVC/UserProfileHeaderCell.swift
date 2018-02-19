//
//  UserProfileHeaderCell.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 08/02/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit


class UserProfileHeaderCell: UICollectionViewCell {
    
    var user: User?{
        
        didSet{
            //get user
            
            
            guard let user = user else { return }
                
            
            
            
            //set image
            guard let userProfileImageUrl = user.userProfileImageUrl else { return }
            downloadImage(from: userProfileImageUrl)
            
            
            //set name
            guard let username = user.username else { return }
            let attributedText = NSMutableAttributedString(string: username, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)])
            self.userProfileNameLabel.attributedText = attributedText
                
            
            
            
            
            
            
        }
        
        
    }
    
    
    fileprivate func downloadImage (from url: String) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Error while downloading image ", err)
                return
            }
            
            guard let data = data else { return }
            
            let downloadedImage = UIImage(data: data)
            
            
            DispatchQueue.main.async {
                
                self.userProfileImageView.image = downloadedImage
            }
            
        }.resume()
    }
    
    
    let userProfileImageView: UIImageView = {
       
        let iv = UIImageView()
//        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.heightAnchor.constraint(equalToConstant: 80).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return iv
        
    }()
    
    
    private func createButtonWithTitle (numberTitle: String, subTitle: String) -> UIButton {
        
        let button: UIButton = {
           
            let btn = UIButton(type: .system)
            
            let attributedTitle = NSMutableAttributedString(string: numberTitle, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)])
            attributedTitle.append(NSAttributedString(string: "\n\(subTitle)", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black]))
            btn.titleLabel?.numberOfLines = 0
            btn.titleLabel?.textAlignment = .center
           btn.setAttributedTitle(attributedTitle, for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
            
        }()
        
        return button
    }
    
    lazy var postsButton = self.createButtonWithTitle(numberTitle: "10", subTitle: "posts")
    lazy var followersButton = self.createButtonWithTitle(numberTitle: "300K", subTitle: "followers")
    lazy var followingsButton = self.createButtonWithTitle(numberTitle: "100K", subTitle: "following")
    

    
    let editProfileButton: UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("Edit Profile", for: .normal)
        btn.layer.borderColor = UIColor.rgb(red: 211, green: 211, blue: 211, alpha: 1).cgColor
        btn.layer.borderWidth = 1
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    
    let userProfileNameLabel: UILabel = {
        
        let label = UILabel()
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let divider: UIView = {
       let v = UIView()
        v.backgroundColor = UIColor.rgb(red: 211, green: 211, blue: 211, alpha: 1)
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return v
    }()
    
    //TODO: 3 view options buttons
    fileprivate func createViewOptionButton (icon: UIImage) -> UIButton {
        
        let button: UIButton = {
           
            let btn = UIButton(type: .system)
            btn.setImage(icon, for: .normal)
            btn.clipsToBounds = true
            btn.contentMode = .scaleAspectFill
            
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
        
        return button
    }
    
    lazy var galleryViewButton = self.createViewOptionButton(icon: #imageLiteral(resourceName: "grid"))
    lazy var listViewButton = self.createViewOptionButton(icon: #imageLiteral(resourceName: "list"))
    lazy var favouriteViewButton = self.createViewOptionButton(icon: #imageLiteral(resourceName: "ribbon"))
    
    
    private func setupHeader () {
        
        addSubview(userProfileImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingsButton)
        addSubview(postsButton)
        addSubview(editProfileButton)
        addSubview(userProfileNameLabel)
        addSubview(divider)
        addSubview(galleryViewButton)
        addSubview(listViewButton)
        addSubview(favouriteViewButton)
       
        
        userProfileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        let userStatsContainer = UIStackView(arrangedSubviews: [postsButton, followersButton, followingsButton])
        userStatsContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userStatsContainer)
        userStatsContainer.axis = .horizontal
        userStatsContainer.distribution = .fillEqually
        userStatsContainer.spacing = 10
        
        userStatsContainer.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 30).isActive = true
        userStatsContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        userStatsContainer.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        userStatsContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        editProfileButton.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 20).isActive = true
        editProfileButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        editProfileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        editProfileButton.topAnchor.constraint(equalTo: userStatsContainer.bottomAnchor, constant: 10).isActive = true
        
        
        userProfileNameLabel.leftAnchor.constraint(equalTo: userProfileImageView.leftAnchor, constant: 0).isActive = true
        userProfileNameLabel.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 20).isActive = true
        
        divider.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        divider.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        divider.topAnchor.constraint(equalTo: userProfileNameLabel.bottomAnchor, constant: 20).isActive = true
        
        let viewOptionsContainer = UIStackView(arrangedSubviews: [galleryViewButton, listViewButton, favouriteViewButton])
        viewOptionsContainer.translatesAutoresizingMaskIntoConstraints = false
        viewOptionsContainer.distribution = .fillEqually
        viewOptionsContainer.axis = .horizontal
        viewOptionsContainer.spacing = 10
        addSubview(viewOptionsContainer)
        
        viewOptionsContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        viewOptionsContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        viewOptionsContainer.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 15).isActive = true
        
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //backgroundColor = .green
        
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




    























