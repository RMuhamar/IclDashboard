//
//  TableCourierBilling.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 22/10/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import UIKit

class TableCourierBilling:UITableViewCell {
    @IBOutlet weak var No: UILabel!
    @IBOutlet weak var CourierName: UILabel!
    @IBOutlet weak var CourierCode: UILabel!
    
    @IBOutlet weak var OD: UILabel!
    @IBOutlet weak var OK: UILabel!
    @IBOutlet weak var UN: UILabel!
    @IBOutlet weak var IP: UILabel!
    @IBOutlet weak var lPersentasionOK: UILabel!
    
    var CekTable:CekTableCourierBilling!
    
    func setData(_ tablelist:CekTableCourierBilling){
        self.CekTable = tablelist
        No.text = tablelist.No
        CourierName.text = tablelist.CourierName
        CourierCode.text = tablelist.CourierCode
        OD.text = tablelist.OD
        OK.text = tablelist.OK
        UN.text = tablelist.UN
        IP.text = tablelist.IP
        lPersentasionOK.text = tablelist.PersentasionOK + "%"
    }
}
