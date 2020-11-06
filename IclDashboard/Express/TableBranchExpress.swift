//
//  TableBranchExpress.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 13/10/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import UIKit

class TableBranchExpress:UITableViewCell {
    
    @IBOutlet weak var lNo: UILabel!
    @IBOutlet weak var lBranchName: UILabel!
    @IBOutlet weak var lCourier: UILabel!
    @IBOutlet weak var lOD: UILabel!
    @IBOutlet weak var lOK: UILabel!
    @IBOutlet weak var lUN: UILabel!
    @IBOutlet weak var lIP: UILabel!
    @IBOutlet weak var lPersentasionOK: UILabel!
    
    var CekTable:CekTableBranchExpress!
    
    func setData(_ tablelist:CekTableBranchExpress){
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
