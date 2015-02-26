//
//  User.swift
//  Tracker
//
//  Created by Nitesh on 12/26/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import Foundation
class User{
    
    var id: String
    var name : String
    var userName: String
    var password: String
    
    
    init(id: String, name : String, userName: String, password: String){
        self.id = id
        self.name = name
        self.userName = userName
        self.password = password
        
       
    }
    func getId() -> String{
        return self.id
    }
    
    func setId(id : String){
        self.id = id
    }
    func getName()-> String{
        return self.name
    }
    func setName(name : String){
        self.name = name
    }
    
    func getPassword() -> String{
        return self.password
    }
    
    func setPassword(password : String){
        self.password = password
    }
    func getUserName()-> String{
        return self.userName
    }
    func setUserName(userName : String){
        self.userName = userName
    }
}