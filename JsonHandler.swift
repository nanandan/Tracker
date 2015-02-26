//
//  JsonHandler.swift
//  Tracker
//
//  Created by Nitesh on 12/26/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import Foundation
class JsonHandler{
    func safeSet(d: NSMutableDictionary, k: String, v: String) {
        if (v != "") {
            d[k] = v
        }
    }
    func toDictionary(userName: String, password: String)-> NSDictionary{
        
        var jsonable = NSMutableDictionary()
        self.safeSet(jsonable, k: "username",v: userName)
        self.safeSet(jsonable,k: "password", v: password)
        return jsonable
        
    }
}