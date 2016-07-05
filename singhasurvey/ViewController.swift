//
//  ViewController.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/3/16.
//  Copyright © 2016 Singha. All rights reserved.
//
import SwiftyJSON
import UIKit

class ViewController: UITabBarController {

    var defaults = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        defaults = NSUserDefaults.standardUserDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        let userData = defaults.valueForKey("user_data")
        
        if userData == nil {
            self.performSegueWithIdentifier("Login", sender: self)
        } else {
            let data  = JSON.parse(userData as! String)
            print(data)
            
            let passcode = defaults.valueForKey("passcode")
            
            if passcode == nil {
                self.performSegueWithIdentifier("SetupPasscode", sender: self)
            } else {
                if (!Config.Logged) {
                    self.performSegueWithIdentifier("Passcode", sender: self)
                }
            }
        }

    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
}

