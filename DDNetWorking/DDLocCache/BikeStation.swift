//
//  BikeStation.swift
//  DDFunction
//
//  Created by Ice on 2018/4/26.
//  Copyright © 2018年 Ice. All rights reserved.
//

import Foundation
import CoreLocation
public class BikeStation : NSObject{
    open var cityCode:String?

    public let number:String?
    public let name:String?
    public let lon:String?
    public let lat:String?
    open var address:String?
    open var status:String?
    open var updatetime:String?
    open var totalCount:String?
    open var rentCount:String?
    open var restoreCount:String?
    open var type: String?
    open var deviceId:String?
    open var deviceName:String?
    open var coordType:String?
    open var totalcount:String?
    open var posinfos:String?
    open var coordinateCa:String?
    open var coordinates: [ThirdpartyRetVertexes]?
    open var mscTotalCount: String?
    open var mscRentCount: String?
    open var mscBadCount: String?
    open var redpacPileFlag: String?
    open var blueRentCount: String?
    open var stationType: String?
    
    public init(name:String,number:String,lat:String,lon:String){
        
        self.name = name
        self.number = number
        self.lat = lat
        self.lon = lon
    }
}
