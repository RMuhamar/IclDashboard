//
//  server.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 13/10/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import Foundation

class Server {
    
    var URL:String = "https://apimobile.ptncs.com/php/icl_dashboard/"
    var URL_IDSS:String = "https://idss.ptncs.com/Setting/"
    var URL_APPS :String = "https://apimobile.ptncs.com/php/apps_service/"
    
    var LOGIN_SUCCESS = "success"
    
    var URL_USER_LOGIN:String  = "MobileAppsLogin.aspx";
    var URL_GETDATA_ACCOUNT:String  = "userGetData_Account.php?";
    var URL_EX_PERF_BRANCH:String  = "getData_ex_branch.php?";//BranchCode=
    var URL_EX_PERF_COURIER:String  = "getData_ex_courier.php?";//BranchCode=
    var URL_EX_PERF_TOTAL:String    = "getData_ex_perf_total.php?";//CourierCode=
    var URL_EX_PERF_DAILY:String    = "getData_ex_perf_daily.php?";//CourierCode=
    
    var URL_CC_PERF_BRANCH:String  = "getData_cc_branch.php?";
    var URL_CC_PERF_COURIER:String  = "getData_cc_courier.php?";
    var URL_CC_PERF_TOTAL:String    = "getData_cc_perf_total.php?";//CourierCode=
    var URL_CC_PERF_DAILY:String    = "getData_cc_perf_daily.php?";//CourierCode=
    
    var URL_BS_PERF_BRANCH:String  = "getData_bs_branch.php?";
    var URL_BS_PERF_COURIER:String  = "getData_bs_courier.php?";
    var URL_BS_PERF_TOTAL:String    = "getData_bs_perf_total.php?";//CourierCode=
    var URL_BS_PERF_DAILY:String    = "getData_bs_perf_daily.php?";//CourierCode=
}
