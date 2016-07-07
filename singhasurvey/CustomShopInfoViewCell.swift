//
//  CustomShopInfoViewCell.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/7/16.
//  Copyright © 2016 Singha. All rights reserved.
//


import UIKit

class CustomShopInfoViewCell : UITableViewCell {
    
    @IBOutlet weak var mName: UILabel!
    @IBOutlet weak var mTier: UILabel!
    @IBOutlet weak var mCount_survey: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

class CustomerVisitViewCell : UITableViewCell {
    
    @IBOutlet weak var mCustomerName: UILabel!
    @IBOutlet weak var mActivityName: UILabel!
    @IBOutlet weak var mCreatedDate: UILabel!
    @IBOutlet weak var mVenueType: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}