//
//  PostService.swift
//  Tracker
//
//  Created by Nitesh on 12/25/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import Foundation
import UIKit
class PostService{
    var responseNumber: NSNumber = NSNumber()
    //var segue: UIStoryboardSegue = UIStoryboardSegue(identifier: "signup_to_login", source: SignUpViewController, destination: LoginViewController)
    
  //  var seque2: UIStoryboardSegue
  //  var destinationViewController: SignUpViewController = segue.sourceViewController as SignUpViewController
  //  var destination: SignUpViewController = SignUpViewController()
    var settings: Settings!
    
    init(){
        self.settings = Settings()
    }
    
    // grabs a specific restaurant
    func getUser(userId : String, userName: String, password: String)-> Bool{
     //   request(settings.getUser(userId), callback: callback)
        
        if(request("http://54.67.66.60:3000/Users/", userName: userName, password: password) == 200){
            return true
        }else{
            return false
        }
        
    }
    
    
    func getUser2(userId : String, userName: String, password: String){
        //   request(settings.getUser(userId), callback: callback)
        
      //  request2("http://192.168.1.242:3000/Users/", userName: userName, password: password)
        
    }
    
    // posts a review with given restaurant ID
    func makePost(userId : String, userName: String, password: String)-> Bool{
     //   post(settings.getUser(userId), userName: userName, password: password)
        if(post("http://54.67.66.60:3000/Users", userName: userName, password: password)){
            return true
        }else{
        return false
        }
    
        
    }
    

    
    private func request(url: String,userName: String, password: String)->NSNumber{
        var num: NSNumber = NSNumber(int: 0)
        var url1 = url.stringByAppendingString(userName)
        var url2 = url1.stringByAppendingString("/")
        var url3 = url2.stringByAppendingString(password)
        var nsURL = NSURL(string: url3)
      //  var response: AutoreleasingUnsafeMutablePointer<NSURLResponse>?
      //  var err: NSErrorPointer!
       // var request: NSURLRequest = NSURLRequest(URL: nsURL!)
       
        
       let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data, response, error) in
            var error: NSError?
           // var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
             var response2 = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSURLResponse
           // callback(response)
            if  let httpResponse = response2 as? NSHTTPURLResponse{
                println("response error from get request is \(httpResponse.statusCode)")
                num = httpResponse.statusCode
            }
            
          
        }
        task.resume()
        return num
    }
    
    private func post(url: String, userName: String, password: String)-> Bool{
       var userNameWithoutSpace = userName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        var sent = false
        
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)//192.168.1.242

        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        NSLog("request is %@", request)

        
        var params = ["username":userNameWithoutSpace, "password": password, "loggedin": false, "friend1": NSNull(), "friend2": NSNull()] as Dictionary<String, NSObject>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
        ///    println(response.statuscode)
            

           
          
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    var success = parseJSON["success"] as? Int
                    println("Succes: \(success)")
                    
                    
                    

                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Error could not parse JSON: \(jsonStr)")
                }
            }
            
            if  let httpResponse = response as? NSHTTPURLResponse{
                println("response error is \(httpResponse.statusCode)")
              
                
                self.responseNumber = httpResponse.statusCode
               // self.destinationViewController?.responseNum = self.responseNumber
                
             //  self.destinationViewController?.resolve()
              //  self.destination.responseNum = self.responseNumber
                
              //  self.destination.resolve()
           
                
            }
        })
        
        task.resume()
        

      
        return true
       
    }

    
}