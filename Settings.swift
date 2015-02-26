//
//  Settings.swift
//  Tracker
//
//  Created by Nitesh on 12/25/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import Foundation


class Settings{
    var root = "http://54.67.66.60:3000/Users/"
    
    var viewUsers = "http://54.67.66.60:3000/Users/"
    
    func getUser(u : String) -> String {
        return viewUsers + u + "/"
    }
    
    
    
}