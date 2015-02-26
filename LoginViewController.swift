

//
//  LoginViewController.swift
//  LocationTracker
//
//  Created by Nitesh on 12/23/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var validResponseNumber = 0
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

 //   var num: NSNumber!
    override func viewDidLoad() {
       // var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
       
        if(!(defaults.boolForKey("registered"))){
            println("No users registered yet from login")
        }else{
            println("User is registered from login")
            
        }
        
    }
    override func viewDidAppear(animated: Bool) {

        if((NSUserDefaults.standardUserDefaults().dataForKey("loggedin")) == true){
            println("defaults is working")
            performSegueWithIdentifier("login_to_continue", sender: self)
        }
        
    }
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signInBtn(sender: AnyObject) {
        
      
  
      //  var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
      //  var user: NSString =   defaults.objectForKey("username") as NSString
      //  var pass: NSString = defaults.objectForKey("password") as NSString
        
        var tUser: NSString? = NSString(string: usernameField.text)
        var tPass: NSString? = NSString(string: passwordField.text)
        var tempUser = tUser?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        var tempPass = tPass?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        var url = "http://54.67.66.60:3000/Users/"
        var url1 = url.stringByAppendingString(tempUser!)
        var url2 = url1.stringByAppendingString("/")
        var url3 = url2.stringByAppendingString(tempPass!)
        println("url before going in to request is \(url3)")
    
   
        
       /* getPosts(url3) {
            (response) in
            self.processDataRecieved(tempUser!, password: tempPass!, posts: response)
        }*/
        
        
   
        
    }
    func processDataRecieved(user: NSString, password: NSString, posts:NSDictionary){
    
  //   NSLog("username is %@", posts.valueForKey("username"))
    // NSLog("id is %@", posts.valueForKey("_id"))
        
        /*if((posts.valueForKey("username")) != nil){
            NSOperationQueue.mainQueue().addOperationWithBlock {

              self.performSegueWithIdentifier("login_to_continue", sender: self)
            }

        }*/
        
    println(".....................")
        var recievedUser: AnyObject? = posts.valueForKey("username")?
         var recievedPassword: AnyObject? = posts.valueForKey("password")?
        if(recievedUser == nil || recievedPassword == nil){
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
            
            var alert = UIAlertController(title: "Alert", message: "Invalid Username or password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                
            self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            NSOperationQueue.mainQueue().addOperationWithBlock {
                self.defaults.setBool(true, forKey: "loggedin")
                
                    self.performSegueWithIdentifier("login_to_continue", sender: self)
                }
        }

       
    
        
      /*  for (key, value) in posts {
            println("Property: \"\(key as String)\"")
            var temp = key as String
            if (posts.valueForKey(temp) == User)
        }
*/
    }
    
    func getPosts(url: String, callback:(NSDictionary)->()) {
       // println("get posts")
      //  request(url,callback)
    }
    
    func request(url:String,callback:(NSDictionary)->()) {
        var nsURL: NSURL? = NSURL(string: url)
        if(nsURL == nil){
            println("url is nil")
        }else{
            println("url is not nil")
        }
        
        println(callback)
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data,response,error) in
            var error:NSError?
            
            var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error)? as NSDictionary
        
            
            for (key, value) in response{
                println("Property: \"\(key as String)\"")
            }
            
            
            callback(response)
        }
       
        task.resume()
    }
    
    
    

    
}



