//
//  ShopInfoViewController.swift
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
import AlamofireObjectMapper

class ShopInfoViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var userData:JSON = []
    var offset = "0"
    var limit = "20"
    var mData = [CustomersListData]()
    
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.dataSource = self
        self.mTableView.delegate = self

        let value = defaults.valueForKey("user_data")
        
        let options = PullToRefreshOption()
        options.backgroundColor = UIColor(hexString: AppColor.colorPrimaryDark)
        options.indicatorColor = UIColor.whiteColor()
        
        self.mTableView.addPullToRefresh(options: options,refreshCompletion: { [weak self] in
            var userData = JSON.parse(value! as! String)
            self!.loadData(userData["user_id"].stringValue)
            self!.mTableView.reloadData()
            self!.mTableView.stopPullToRefresh()
            })
        
        if value != nil {
            var userData = JSON.parse(value! as! String)
            self.loadData(userData["user_id"].stringValue)
            self.mTableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        let value = defaults.valueForKey("user_data")
        if value != nil {
            var userData = JSON.parse(value! as! String)
            self.loadData(userData["user_id"].stringValue)
            self.mTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.mTableView.fixedPullToRefreshViewForDidScroll()
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
        
        
        Alamofire.request(.GET, url).responseObject() { (response: Response<CustomersList, NSError>) in
            
            let dataResponse = response.result.value
            self.mData = (dataResponse?.data)! as [CustomersListData]
            self.mTableView.reloadData()

            spinner.dismiss()

        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShopInfoCell") as! CustomShopInfoViewCell
        
        let dict = self.mData[indexPath.row]
        cell.mName.text = dict.name
        cell.mTier.text = dict.tier
        cell.mCount_survey.text = String(dict.count_survey!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}
