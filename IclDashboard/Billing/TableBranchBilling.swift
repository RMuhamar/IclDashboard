//
//  TableBranchBilling.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 22/10/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import UIKit

class TableBranchBilling:UITableViewCell {
    
    @IBOutlet weak var lNo: UILabel!
    @IBOutlet weak var lBranchName: UILabel!
    @IBOutlet weak var lCourier: UILabel!
    @IBOutlet weak var lOD: UILabel!
    @IBOutlet weak var lOK: UILabel!
    @IBOutlet weak var lUN: UILabel!
    @IBOutlet weak var lIP: UILabel!
    @IBOutlet weak var lPersentasionOK: UILabel!
    
    var CekTable:CekTableBranchBilling!
    
    func setData(_ tablelist:CekTableBranchBilling){
        self.CekTable = tablelist
        lNo.text = tablelist.No
        lBranchName.text = tablelist.BranchName
        lCourier.text = tablelist.Courier
        lOD.text = tablelist.OD
        lOK.text = tablelist.OK
        lUN.text = tablelist.UN
        lIP.text = tablelist.IP
        lPersentasionOK.text = tablelist.PersentasionOK + "%"
    }
    
    
}
