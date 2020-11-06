//
//  ViewController.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 09/09/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var sVersion: UILabel!
    @IBOutlet weak var utfUserName: UITextField!
    @IBOutlet weak var utfPassword: UITextField!
    @IBOutlet weak var LoadingView: AnimationView!
    
    var server = Server()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        content.layer.cornerRadius = 24
        content.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        sVersion.text = appVersion
        utfUserName.delegate = self
        utfPassword.delegate = self
        
        print(UserDefaults.standard.bool(forKey: "Session"))
        print(UserDefaults.standard.string(forKey: "Username"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cekSession()
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        login()
    }
    
    func login(){
        
        LoadingView.alpha = 1
        self.LoadingView.contentMode = .scaleAspectFit
        // 2. Set animation loop mode
        // 3. Adjust animation speed
        self.LoadingView.animationSpeed = 0.9
        // 4. Play animation
        self.backgroundView.addBlurEffect()
        LoadingView.play { (finished) in
        /// Animation stopped
            self.LoadingView.loopMode = .loop
            var sUsername:String = self.utfUserName.text ?? ""
            var sPassword:String = self.utfPassword.text ?? ""
            
            let parameters: [String: String] = [
                            "Username": sUsername,
                            "Password": sPassword
                            ]
                    
            AF.request(self.server.URL_IDSS + self.server.URL_USER_LOGIN, method: .post, parameters: parameters)
                .responseString{(response) in
            
                    switch response.result{
                
                        case .success(let value):

                            if value == self.server.LOGIN_SUCCESS {
                                self.getData()
                                DispatchQueue.main.async {() -> Void in
                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbHome") as! UINavigationController
                                self.present(viewController, animated: true, completion: nil)}
                                
                            } else {
                                self.alertType(title:"Alert",message:value)
                            }

                        break
                        case .failure(let error):
                            self.alertType(title:"",message: "ayolah")
                        break
                    }
                    
                    self.LoadingView.alpha = 0
                    self.LoadingView.stop()
                    self.backgroundView.removeBlurEffect()
                        
            }
            
        }
    }
    
    private func getData(){
        let parameters: Parameters = ["Username": self.utfUserName.text!]
        let headers:HTTPHeaders = ["Auth" : "5h4olRTOxusILWBxEQUC8B2mXmXtYDkhC81JJwMzYNKGtm1Ami"]
        
        AF.request(self.server.URL + self.server.URL_GETDATA_ACCOUNT, method: .get, parameters: parameters,encoding: URLEncoding.queryString,headers: headers)
            .responseJSON {(response) in
                    
            switch response.result{
                        
                case .success(let value):
                        
                    let json = JSON(value)
                        let username = json["result"][0]["UserName"].string!
                        let fullname = json["result"][0]["FullName"].string!
                        let branchcode = json["result"][0]["BranchCode"].string!
                        let branchname = json["result"][0]["BranchName"].string!
                        let profile = json["result"][0]["Profile"].string!
                        let flagstatus = json["result"][0]["FlagStatus"].string ?? ""
                        let icl_dashboard = json["result"][0]["ICL_Dashboard"].string ?? ""
                        
                        UserDefaults.standard.set(username, forKey: "Username")
                        UserDefaults.standard.set(fullname, forKey: "Fullname")
                        UserDefaults.standard.set(branchcode, forKey: "BranchCode")
                        UserDefaults.standard.set(branchname, forKey: "BranchName")
                        UserDefaults.standard.set(profile, forKey: "Profile")
                        UserDefaults.standard.set(flagstatus, forKey: "FlagStatus")
                        UserDefaults.standard.set(icl_dashboard, forKey: "Icl_Dashboard")
                        UserDefaults.standard.set(true, forKey: "Session")
                    
                break
                case .failure(let error):
                        
                    self.alertType(title:"",message:"\(error.localizedDescription)")
                break
            }
                    
        }
    }
    
    func cekSession(){
        var Sess:Bool = UserDefaults.standard.bool(forKey: "Session")
        if Sess == true {
            DispatchQueue.main.async {() -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbHome") as! UINavigationController
                self.LoadingView.alpha = 0
                self.LoadingView.stop()
                self.backgroundView.removeBlurEffect()
            self.present(viewController, animated: true, completion: nil)}
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func alertType(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }


}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: radius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func addBlurEffect(){
        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = self.bounds
        UIView.animate(withDuration: 2) {
            blurEffectView.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        }

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
    let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
    blurredEffectViews.forEach{ blurView in
      blurView.removeFromSuperview()
    }
}
}

