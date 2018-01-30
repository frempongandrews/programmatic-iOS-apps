//
//  CustomPageCell.swift
//  07-audibleGuide
//
//  Created by Andrews Frempong on 29/12/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//


import UIKit


//<!-- Custom Page Cell -->

class CustomPageCell: UICollectionViewCell {
    
    
    //variables
    
    var page: Page? {
        
        didSet {
            
            //unwrapping page
            
            guard let page = page else { return }
            
            //page image
            pageImageView.image = page.pageImage
            
            
            //page text
            let attributedText = NSMutableAttributedString(string: page.pageTitle, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.pageMessage)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)]))
            
            //centering
            
            let paragrapghStyle = NSMutableParagraphStyle()
            
            paragrapghStyle.alignment = .center
            
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragrapghStyle, range: NSMakeRange(0, attributedText.length))
            
            pageTextView.attributedText = attributedText
        }
    }
    
    
    //UI Components
    
    let pageImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .green
        
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let pageTextView: UITextView = {
        
        let tv = UITextView()
        tv.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()
    
    //<!--end UI Components -->
    
    func setupCell () {
        
        //add to cell
        
        addSubview(pageImageView)
        addSubview(pageTextView)
        
        //constraints
        
        pageImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        pageImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        pageImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        pageImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        
        pageTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        pageTextView.topAnchor.constraint(equalTo: pageImageView.bottomAnchor, constant: 0).isActive = true
        pageTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        pageTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
        
        
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
