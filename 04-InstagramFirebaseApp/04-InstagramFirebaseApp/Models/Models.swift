//
//  Models.swift
//  04-InstagramFirebaseApp
//
//  Created by Andrews Frempong on 14/02/2018.
//  Copyright © 2018 Andrews Frempong. All rights reserved.
//

import UIKit

struct User {
    
    var username: String?
    var userProfileImageUrl: String?
    
    init (userDictionary: [String: Any]) {
        
        self.username = userDictionary["username"] as? String ?? ""
        self.userProfileImageUrl = userDictionary["userProfileImage"] as? String ?? ""
    }
}
