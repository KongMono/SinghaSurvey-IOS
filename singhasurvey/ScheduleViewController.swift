//
//  ScheduleViewController.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/5/16.
//  Copyright © 2016 Singha. All rights reserved.
//
import PullToRefreshSwift
import UIKit
import Alamofire
import JHSpinner
import SwiftyJSON


class ScheduleViewController: UIViewController {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var userData:JSON = []
    var offset = "0"
    var limit = "20"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = defaults.valueForKey("user_data")
        
        
        let options = PullToRefreshOption()
        options.backgroundColor = UIColor(hexString: AppColor.colorPrimaryDark)
        options.indicatorColor = UIColor.whiteColor()
        
        if value != nil {
            var userData = JSON.parse(value! as! String)
            self.loadData(userData["user_id"].stringValue)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
//        let value = defaults.valueForKey("user_data")
//        if value != nil {
//            var userData = JSON.parse(value! as! String)
//            self.loadData(userData["user_id"].stringValue)
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func loadData(user_id: String){
        let spinner = JHSpinnerView.showDeterminiteSpinnerOnView(self.view)
        spinner.progress = 0.0
        view.addSubview(spinner)
        
        var url = API.service_customers_list;
        
        url = url.replace(":user_id", withString: user_id)
        url = url.replace(":offset", withString: offset)
        url = url.replace(":limit", withString: limit)
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                print(json)
                
                spinner.dismiss()
        }
    }
}
