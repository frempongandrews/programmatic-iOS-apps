//
//  PhotoSelectorCell.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 23/02/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit


class PhotoSelectorCell: UICollectionViewCell {
    
    var image: UIImage? {
        
        didSet {
            
            guard let image = image else { return }
            self.imageView.image = image
        }
    }
    
    let imageView: UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    
    func setupCell () {
        
        addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
