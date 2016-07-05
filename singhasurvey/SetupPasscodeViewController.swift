//
//  SetupPasscodeViewController.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/4/16.
//  Copyright © 2016 Singha. All rights reserved.
//

import UIKit


class SetupPasscodeViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var TextHeader: UILabel!
    @IBOutlet weak var input_new_password: UITextField!
    @IBOutlet weak var input_comfirm_new_password: UITextField!
    
    @IBOutlet weak var btn_done: UIBarButtonItem!
    let limitLength = 4;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setup Passcode"
        self.TextHeader.text = "Please input your new 4-digit passcode"
        
        input_new_password.delegate = self
        input_comfirm_new_password.delegate = self
    }
 
    @IBAction func onclick_done(sender: AnyObject) {
        if(input_new_password.text != input_comfirm_new_password.text){
            let alert = UIAlertController(title: "Singha Survey", message: "Passcode not match. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(input_new_password.text, forKey: "passcode")
            defaults.synchronize()
            
            self.dismissViewControllerAnimated(true, completion: {})
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
}