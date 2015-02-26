//
//  Post.swift
//  Tracker
//
//  Created by Nitesh on 12/25/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import Foundation
class Post{
    var userName: String
    var password: String
    
    init(userName: String, password: String){
      
        self.userName = userName
        self.password = password
    }
    func toJSON() -> String{
        return ""
    }
}