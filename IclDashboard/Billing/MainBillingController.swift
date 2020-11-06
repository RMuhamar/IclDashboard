//
//  MainBillingController.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 21/10/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainBillingController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var txtFilterBranch: UITextField!
    @IBOutlet weak var heightFilterBranch: NSLayoutConstraint!
    @IBOutlet weak var topConsFilterBranch: NSLayoutConstraint!
    @IBOutlet weak var viewCourier: UIView!
    @IBOutlet weak var viewBranch: UIView!
    @IBOutlet weak var btnBranch: UIButton!
    @IBOutlet weak var btnCourier: UIButton!
    @IBOutlet weak var tableBranch: UITableView!
    @IBOutlet weak var tableCourier: UITableView!
    
    var cekTableBranch = [CekTableBranchBilling]()
    var cekTableCourier = [CekTableCourierBilling]()
    var server = Server()

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.layer.cornerRadius = 24
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewFilter.layer.cornerRadius = 24
        viewFilter.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewCourier.alpha = 0
        topConsFilterBranch.constant = 0
        heightFilterBranch.constant = 0
        
        self.tableBranch.dataSource = self
        self.tableBranch.delegate = self
        self.tableCourier.dataSource = self
        self.tableCourier.delegate = self
        
        getListBranchBilling()
    }
    
    @IBAction func Branch(_ sender: Any) {
        viewCourier.alpha = 0
        topConsFilterBranch.constant = 0
        heightFilterBranch.constant = 0
        getListBranchBilling()
    }
    
    @IBAction func btnCourier(_ sender: Any) {
        UIView.animate(withDuration: 1/3, delay: 0, options: .curveEaseIn, animations: {
            self.topConsFilterBranch.constant = 20
            self.heightFilterBranch.constant = 40
        }, completion: nil)
            self.viewCourier.alpha = 1
        getListCourierBilling()
    }
    
    private func getListBranchBilling(){
        
        let BranchCode:String = "327320001"
        let Date:String = "2020-10-14"
        let Month:String = "10"
        let Year:String = "2020"
        let ProfileType:String = "superuser"
        let Username:String = "fatur.fauzi"
        let ViewBy:String = "Daily"
        let SortBy:String = "Percent"
        
        let parameters: Parameters = ["BranchCode": BranchCode ,"Date": Date,"Month": Month,"Year": Year,"ProfileType": ProfileType,"Username": Username,"ViewBy": ViewBy,"SortBy": SortBy ]
        
        let headers:HTTPHeaders = ["Auth": "5h4olRTOxusILWBxEQUC8B2mXmXtYDkhC81JJwMzYNKGtm1Ami"]
        
        AF.request(self.server.URL + self.server.URL_BS_PERF_BRANCH, method: .get, parameters: parameters,encoding: URLEncoding.queryString,headers: headers)
            .responseJSON {(response) in
    
            switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    for i in 0 ..< json.count{

                    var no = i + 1
                    var pers:Float = 0
                    let BranchName = json[i]["BranchName"].string ?? ""
                    let BranchCode = json[i]["BranchCode"].string ?? ""
                    let Kurir = json[i]["Kurir"].string ?? ""
                    let OD = json[i]["OD"].string ?? ""
                    let OK = json[i]["OK"].string ?? ""
                    let UN = json[i]["UN"].string ?? ""
                    let IP = json[i]["IP"].string ?? ""
                    let Persen = json[i]["Persen"].string ?? ""
                        
                        pers = Float(Persen)!

                        self.cekTableBranch.append(CekTableBranchBilling(String(no),BranchName, Kurir,OD,OK, UN,IP,String(format:"%.0f",pers)))

                    }
                    break
                case .failure(let error):
                    print(error)
                    break
            }
                
            self.tableBranch.reloadData()
        }

    }
    
    private func getListCourierBilling(){
            
            let BranchCode:String = "327320001"
            let Date:String = "2020-10-14"
            let Month:String = "10"
            let Year:String = "2020"
    //        let ProfileType:String = "superuser"
    //        let Username:String = "fatur.fauzi"
            let ViewBy:String = "Daily"
            let SortBy:String = "Percent"
            
            let parameters: Parameters = ["BranchCode": BranchCode ,"Date": Date,"Month": Month,"Year": Year,"ViewBy": ViewBy,"SortBy": SortBy ]
            
            let headers:HTTPHeaders = ["Auth": "5h4olRTOxusILWBxEQUC8B2mXmXtYDkhC81JJwMzYNKGtm1Ami"]
            
            AF.request(self.server.URL + self.server.URL_BS_PERF_COURIER, method: .get, parameters: parameters,encoding: URLEncoding.queryString,headers: headers)
                .responseJSON {(response) in
        
                switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        for i in 0 ..< json.count{

                        var no = i + 1
                        var pers:Float = 0
                        let CourierName = json[i]["CourierName"].string ?? ""
                        let CourierCode = json[i]["CourierCode"].string ?? ""
                        let OD = json[i]["OD"].string ?? ""
                        let OK = json[i]["OK"].string ?? ""
                        let UN = json[i]["UN"].string ?? ""
                        let IP = json[i]["IP"].string ?? ""
                        let Persen = json[i]["Persen"].string ?? ""
                            
                            pers = Float(Persen)!

                            self.cekTableCourier.append(CekTableCourierBilling(String(no),CourierName, CourierCode,OD,OK, UN,IP,String(format:"%.0f",pers)))

                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                }
                self.tableCourier.reloadData()
            }

        }
    
    //table datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableBranch{
            return cekTableBranch.count
        }else{
            return cekTableCourier.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableBranch {
            let data = cekTableBranch[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableBranchBilling") as! TableBranchBilling
            cell.setData(data)
            
            return cell
        }else{
            let data2 = cekTableCourier[indexPath.row]
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "TableCourierBilling") as! TableCourierBilling
            cell2.setData(data2)
            
            return cell2
        }
    }

}
