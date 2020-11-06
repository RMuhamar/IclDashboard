//
//  CekTableCourierBilling.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 22/10/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import Foundation

class CekTableCourierBilling {
    
    var No:String
    var CourierName:String
    var CourierCode:String
    var OD:String
    var OK:String
    var UN:String
    var IP:String
    var PersentasionOK:String
    
    init(_ No:String, _ CourierName:String, _ CourierCode:String, _ OD:String, _ OK:String, _ UN:String,_ IP:String, _ PersentasionOK:String){
        self.No = No
        self.CourierName = CourierName
        self.CourierCode = CourierCode
        self.OD = OD
        self.OK = OK
        self.UN = UN
        self.IP = IP
        self.PersentasionOK = PersentasionOK
        
      }
}
