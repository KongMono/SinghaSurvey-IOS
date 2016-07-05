//
//  LoginViewController.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/3/16.
//  Copyright © 2016 Singha. All rights reserved.
//
import Alamofire
import JHSpinner
import UIKit
import LMGeocoder
import DynamicColor
import SwiftyJSON

class LoginViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var mUsername:UITextField!
    @IBOutlet weak var mPassword:UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    
    var locationManager:CLLocationManager!
    var location_lat:Double = 0.0
    var location_long:Double = 0.0
    var mDataLogin = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 100.0
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()

    }
    
    override func loadView() {
        super.loadView()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor(hexString: AppColor.colorPrimaryDark)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            
            location_lat = location.coordinate.latitude
            location_long = location.coordinate.longitude
        }
    }
    @IBAction func loginTapped(sender: AnyObject) {
        
        let username = (self.mUsername.text)! as String
        let password = (self.mPassword.text)! as String
        
        if ( username.isEmpty || password.isEmpty || (username.isEmpty && password.isEmpty)) {
            
            let alert = UIAlertController(title: "Singha Survey", message: "Please enter Username and Password", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        } else {
            let post = "username: \(username), password: \(password)" as String
            NSLog("data: %@",post)
        
            callLogin(username ,password: password)
        
        }

    }
    
    @IBAction func forgetPasswordTapped(sender: AnyObject) {
        let alert = UIAlertController(title: "Singha Survey", message: "Enter Username.",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",style: UIAlertActionStyle.Default) {
            (action: UIAlertAction) in
                if let alertTextField = alert.textFields?.first where alertTextField.text != nil {
                    self.callForgotPassword(alertTextField.text!)
                }
        }
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: UIAlertActionStyle.Cancel,
                                   handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "Text here"
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func callForgotPassword(username: String){
        let spinner = JHSpinnerView.showDeterminiteSpinnerOnView(self.view)
        spinner.progress = 0.0
        view.addSubview(spinner)
        
        let parameters = [
            "username": username
        ]
        
        Alamofire.request(.POST, API.service_forgot,parameters: parameters)
            .responseJSON { response in
            
            let json = JSON(response.result.value!)
            let alert = UIAlertController(title: "Singha Survey", message: json["msg"].stringValue, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            spinner.dismiss()
                
        }
        
    }

    func callLogin(username :String,password :String){
        let spinner = JHSpinnerView.showDeterminiteSpinnerOnView(self.view)
        spinner.progress = 0.0
        view.addSubview(spinner)
        
        let parameters = [
            "username": username,
            "password": password,
            "from": "IOS",
            "lat": location_lat,
            "long": location_long
        ]

        
        Alamofire.request(.POST, API.service_login, parameters: parameters as? [String : AnyObject])
            .responseJSON { response in
                
                var json = JSON(response.result.value!)
                print(json)
                if json["msg"] != nil {
                    
                    let alert = UIAlertController(title: "Singha Survey", message: json["msg"].stringValue, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    spinner.dismiss()
                    
                } else {
                
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(json.rawString()!, forKey: "user_data")
                    defaults.synchronize()
                
                    spinner.dismiss()
                    
                    self.dismissViewControllerAnimated(true, completion: {})
                    
                }
        }
    }
  }
