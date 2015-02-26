//
//  SignUpViewController.swift
//  LocationTracker
//
//  Created by Nitesh on 12/23/14.
//  Copyright (c) 2014 Nitesh. All rights reserved.
//

import UIKit



class SignUpViewController: UIViewController {
  
    
    var postService: PostService!
    var user : User!
    var responseNum: NSNumber = NSNumber()
    
    
    
    @IBOutlet weak var name_Field: UITextField!
    
    
    @IBOutlet weak var username_Field: UITextField!
    
    
    @IBOutlet weak var password_Field: UITextField!
    
    
    
    @IBOutlet weak var retypePassword_Field: UITextField!
    
    @IBAction func create_Button(sender: AnyObject) {
      //  if(checkPasswordsMatch() && !checkForEmptyFields()){
            //registerUser()
            self.performSegueWithIdentifier("signup_to_login", sender: self)

     //   }
        
    }
    
    func resolve(){
        
        if(responseNum == 409){
            
            var alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else if(responseNum == 201){

            self.performSegueWithIdentifier("signup_to_login", sender: self)
            
        }else{
            println("responseNum is not correct \(responseNum)")
            
        }

    }
    
    func checkForEmptyFields()-> Bool{
        if((name_Field.text.isEmpty || username_Field.text.isEmpty || password_Field.text.isEmpty || retypePassword_Field.text.isEmpty)){
            println("some textfields are empty")
            return true
        }else{
            println("none of the textfields are empty")
            return false
        }
        
    }
    
    func registerUser(){
        
         postService = PostService()
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
      
        
        defaults.setObject(username_Field.text, forKey: "username")
        defaults.setObject(password_Field.text, forKey: "password")
        defaults.setBool(false, forKey: "loggedin")

       
        
        defaults.synchronize()

        
 
        var handler: JsonHandler!
        
        handler = JsonHandler()
        
        var params = handler.toDictionary(username_Field.text, password: password_Field.text)
     
        
        
        println("registration successful")
        defaults.setBool(true, forKey: "registered")
    
        self.postService.makePost("100", userName: username_Field.text, password: password_Field.text)

        
        self.performSegueWithIdentifier("signup_to_login", sender: self)

        
        

    }
    
  
    

    func checkPasswordsMatch()->Bool{
        
        if(password_Field.text == retypePassword_Field.text){
            println("passwords match")
            return true
        }else{
            println("passwords do not match")
            return false
        }


       // return true
    }
    @IBAction func gotoLogin_button(sender: AnyObject) {
        
     //   self.dismissViewControllerAnimated(true, completion: nil)
        
        println("going in here")
        self.performSegueWithIdentifier("signup_to_login", sender: self)

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let bundleID = NSBundle.mainBundle().bundleIdentifier
        println("bundle id is \(bundleID)")
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if(!(defaults.boolForKey("registered"))){
            println("No users registered yet")
        }else{
            println("User is already registered")
            
        }
    
        // Do any additional setup after loading the view.
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

