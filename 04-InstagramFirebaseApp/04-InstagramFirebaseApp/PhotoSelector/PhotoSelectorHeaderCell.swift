//
//  PhotoSelectorHeader.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 24/02/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit

class PhotoSelectorHeaderCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupHeader () {
        
        addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
