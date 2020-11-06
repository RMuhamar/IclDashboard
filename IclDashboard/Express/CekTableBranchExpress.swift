//
//  CekTableBranchExpress.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 13/10/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import Foundation

class CekTableBranchExpress {
    
    var No:String
    var BranchName:String
    var Courier:String
    var OD:String
    var OK:String
    var UN:String
    var IP:String
    var PersentasionOK:String
    
    init(_ No:String, _ BranchName:String, _ Courier:String, _ OD:String, _ OK:String, _ UN:String,_ IP:String, _ PersentasionOK:String){
        self.No = No
        self.BranchName = BranchName
        self.Courier = Courier
        self.OD = OD
        self.OK = OK
        self.UN = UN
        self.IP = IP
        self.PersentasionOK = PersentasionOK
        
      }
}
