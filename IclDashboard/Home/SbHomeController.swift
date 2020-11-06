//
//  SbHomeController.swift
//  IclDashboard
//
//  Created by Nusantara Card Semesta on 11/09/20.
//  Copyright © 2020 RMuhamaR. All rights reserved.
//
import Foundation
import UIKit

class SbHomeController: UIViewController, WormTabStripDelegate {

    var tabs:[UIViewController] = []
    let numberOfTabs = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        setUpViewPager()

    }
    
    func setUpTabs(){
        for i in 1...numberOfTabs {
            if i == 2 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbHomeCreditCard") as! UIViewController
                tabs.append(vc)
            }else if i == 3 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbHomeBilling") as! UIViewController
                tabs.append(vc)
            }else {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbHomeExpress") as! UIViewController
                tabs.append(vc)
            }
            
        }
    }
    
    func setUpViewPager(){
        let frame =  CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        let viewPager:WormTabStrip = WormTabStrip(frame: frame)
        self.view.addSubview(viewPager)
        viewPager.delegate = self
        viewPager.eyStyle.wormStyel = .BUBBLE
        viewPager.eyStyle.isWormEnable = true
        viewPager.eyStyle.spacingBetweenTabs = 10
        viewPager.eyStyle.kWidthOfButtonMargin = 20
        viewPager.eyStyle.tabItemSelectedColor = UIColor(netHex: 0xFFFFFF)
        viewPager.currentTabIndex = 0
        viewPager.buildUI()
    }
    
    func WTSNumberOfTabs() -> Int {
        return numberOfTabs
    }
    
    func WTSTitleForTab(index: Int) -> String {
        var title:String
        if index == 0 {
             title = "EXPRESS"
        }else if index == 1 {
             title = "CREDIT CARD"
        }else{
             title = "BILLING"
        }
        
        return title
    }
    
    func WTSViewOfTab(index: Int) -> UIView {
        let view = tabs[index]
        return view.view
    }
    
    func WTSReachedLeftEdge(panParam: UIPanGestureRecognizer) {
        
    }
    
    func WTSReachedRightEdge(panParam: UIPanGestureRecognizer) {
        
    }

}
