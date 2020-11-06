//
//  HomeCourierController.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 03/11/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import UIKit

class HomeCourierController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var LName: UILabel!
    @IBOutlet weak var LCode: UILabel!
    var courierName:String = ""
    var courierBranch:String = ""
    var courierCode:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.makeRounded()
        LName.text = courierName
        LCode.text = courierCode
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
