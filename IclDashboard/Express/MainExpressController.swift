//
//  MainExpressController.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 29/09/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MainExpressController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var FilterView: UIView!
    @IBOutlet weak var viewBranch: UIView!
    @IBOutlet weak var viewCourier: UIView!
    @IBOutlet weak var btnCourier: UIButton!
    @IBOutlet weak var btnBranch: UIButton!
    @IBOutlet weak var consTopFilterBranch: NSLayoutConstraint!
    @IBOutlet weak var heightFilterBranch: NSLayoutConstraint!
    @IBOutlet weak var tableBranch: UITableView!
    @IBOutlet weak var tableCourier: UITableView!
    
    var cekTableBranch = [CekTableBranchExpress]()
    var cekTableCourier = [CekTableCourierExpress]()
    var server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MainView.layer.cornerRadius = 24
        MainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        FilterView.layer.cornerRadius = 24
        FilterView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewCourier.alpha = 0
        consTopFilterBranch.constant = 0
        heightFilterBranch.constant = 0
        
        self.tableBranch.dataSource = self
        self.tableBranch.delegate = self
        self.tableCourier.dataSource = self
        self.tableCourier.delegate = self
        
        getListBranchExpress()
        
        var Sess:Bool = UserDefaults.standard.bool(forKey: "Session")
        var User:String = UserDefaults.standard.string(forKey: "Username") ?? ""
        
    }
    
    @IBAction func btnCourier(_ sender: Any) {

        UIView.animate(withDuration: 1/3, delay: 0, options: .curveEaseIn, animations: {
            self.consTopFilterBranch.constant = 20
            self.heightFilterBranch.constant = 40
        }, completion: nil)
            self.viewCourier.alpha = 1
        getListCourierExpress()
        
    }
    
    @IBAction func btnBranch(_ sender: Any) {
        
        viewCourier.alpha = 0
        consTopFilterBranch.constant = 0
        heightFilterBranch.constant = 0
        getListBranchExpress()
        
    }
    
    private func getListBranchExpress(){
        
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
        
        AF.request(self.server.URL + self.server.URL_EX_PERF_BRANCH, method: .get, parameters: parameters,encoding: URLEncoding.queryString,headers: headers)
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

                        self.cekTableBranch.append(CekTableBranchExpress(String(no),BranchName, Kurir,OD,OK, UN,IP,String(format:"%.0f",pers)))

                    }
                    break
                case .failure(let error):
                    print(error)
                    break
            }
            self.tableBranch.reloadData()
        }

    }
    
    private func getListCourierExpress(){
        
        let BranchCode:String = "117140001"
        let Date:String = "2020-10-14"
        let Month:String = "10"
        let Year:String = "2020"
//        let ProfileType:String = "superuser"
//        let Username:String = "fatur.fauzi"
        let ViewBy:String = "Daily"
        let SortBy:String = "Percent"
        
        let parameters: Parameters = ["BranchCode": BranchCode ,"Date": Date,"Month": Month,"Year": Year,"ViewBy": ViewBy,"SortBy": SortBy ]
        
        let headers:HTTPHeaders = ["Auth": "5h4olRTOxusILWBxEQUC8B2mXmXtYDkhC81JJwMzYNKGtm1Ami"]
        
        AF.request(self.server.URL + self.server.URL_EX_PERF_COURIER, method: .get, parameters: parameters,encoding: URLEncoding.queryString,headers: headers)
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

                        self.cekTableCourier.append(CekTableCourierExpress(String(no),CourierName, CourierCode,OD,OK, UN,IP,String(format:"%.0f",pers)))

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
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableBranchExpress") as! TableBranchExpress
            cell.setData(data)
            
            return cell
        }else{
            let data2 = cekTableCourier[indexPath.row]
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "TableCourierExpress") as! TableCourierExpress
            cell2.setData(data2)
            return cell2
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView != self.tableBranch{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc:HomeCourierController = storyboard.instantiateViewController(withIdentifier: "sbHomeCourier") as! HomeCourierController
            let row = cekTableCourier[indexPath.row]
            vc.courierName = row.CourierName
            vc.courierCode = row.CourierCode
            self.present(vc, animated: true, completion: nil)
        }
    }

}
