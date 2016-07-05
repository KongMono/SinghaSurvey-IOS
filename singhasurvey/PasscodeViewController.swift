//
//  PasscodeViewController.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/5/16.
//  Copyright © 2016 Singha. All rights reserved.
//
import PasscodeField
import UIKit

class PasscodeViewController: UIViewController {
    
    @IBOutlet weak var passcodeField: PasscodeField!
    @IBOutlet weak var textField: UITextField!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.addTarget(self, action: #selector(didChangeText(_:)), forControlEvents: .EditingChanged)
        self.textField.becomeFirstResponder()
        
        self.view.addSubview(passcodeField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didChangeText(textField:UITextField) {
        if let text = textField.text {
            self.passcodeField.progress = text.characters.count
            
            if text.characters.count == 4 {
                let passcode = defaults.valueForKey("passcode") as! String
                if passcode == text {
                    
                    Config.Logged = true
                    self.dismissViewControllerAnimated(true, completion: {})
                }else{
                    self.textField.text = ""
                    self.passcodeField.progress = 0
                    
                    let alert = UIAlertController(title: "Singha Survey", message: "Passcode not match. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
            
        } else {
            self.passcodeField.progress = 0
        }
    }
}

