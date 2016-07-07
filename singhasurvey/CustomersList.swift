//
//  CustomersList.swift
//  singhasurvey
//
//  Created by Kong Mono on 7/7/16.
//  Copyright © 2016 Singha. All rights reserved.
//
import ObjectMapper

class CustomersList: Mappable {
    var data: [CustomersListData]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class CustomersListData: Mappable {
    var customer_id: String?
    var name: String?
    var latitude: String?
    var longitude: String?
    var tier: String?
    var count_survey: Int?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        customer_id <- map["customer_id"]
        name <- map["name"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        tier <- map["tier"]
        count_survey <- map["count_survey"]
    }
}
////

class CustomersVisitList: Mappable {
    var data: [CustomersVisitListData]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class CustomersVisitListData: Mappable {
    var visit_id: String?
    var customer_id: String?
    var customer_name: String?
    var latitude: String?
    var longitude: String?
    var activity_name: String?
    var tradition_type: String?
    var created_date: String?
    var venue_type: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        visit_id <- map["visit_id"]
        customer_id <- map["customer_id"]
        customer_name <- map["customer_name"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        activity_name <- map["activity_name"]
        tradition_type <- map["tradition_type"]
        created_date <- map["created_date"]
        venue_type <- map["venue_type"]
    }
}
