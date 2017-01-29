//
//  Station.swift
//  TagTheBusSwift
//
//  Created by cyrine on 27/01/2017.
//  Copyright © 2017 cyrine. All rights reserved.
//

import UIKit

class Station: NSObject {
    
    var city:String?
    
    var id:String?
    
    var streetName:String?
    
    var longitude:String?
    
    var latitude:String?
    
    var buses:String?
    
    override init() {
        city=""
        streetName=""
        longitude=""
        latitude=""
        buses=""
        
    }
    
    func fetchStation(dictionary: NSDictionary){
            id=dictionary["id"] as? String
            streetName=dictionary["street_name"] as? String
            latitude=dictionary["lat"] as? String
            longitude=dictionary["lon"] as? String
            city=dictionary["city"] as? String
            buses=dictionary["buses"] as? String
        
    }


}
