//
//  LoginViewController.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/3/16.
//  Copyright © 2016 Singha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mUsername:UITextField!
    @IBOutlet weak var mPassword:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func dismissKeyboard() {
        view.endEditing(true)
    }
    

    
    @IBAction func signinTapped(sender : UIButton) {
        
        
        let username = (self.mUsername.text)! as String
        let password = (self.mPassword.text)! as String
        
        if ( username.isEmpty || password.isEmpty || (username.isEmpty && password.isEmpty)) {
            
            let alert = UIAlertController(title: "Sign in Failed!", message: "Please enter Username and Password", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        } else {
            let post = "username: \(username), password: \(password)" as String
            NSLog("data: %@",post)
            
            
            if username == "1234" && password == "1234" {
                NSLog("Login SUCCESS");
                
                let prefs = NSUserDefaults.standardUserDefaults()
                prefs.setObject(username, forKey: "USERNAME")
                prefs.setInteger(1, forKey: "ISLOGGEDIN")
                prefs.synchronize()
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "Sign in Failed!", message: "wrong username and password", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
    }
    
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
