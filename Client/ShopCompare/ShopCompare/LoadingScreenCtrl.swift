//
//  LoadingScreenCtrl.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/22/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit

class LoadingScreenCtrl {
    
    var loadingView: UIView?
    
    static var sharedInstance = LoadingScreenCtrl()
    
    init () {
        loadingView = UIView(frame: (UIApplication.sharedApplication().keyWindow?.rootViewController?.view.frame)!)
        loadingView?.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    func showLoading() {
        let currentWindow = UIApplication.sharedApplication().keyWindow?.rootViewController?.view
        currentWindow?.addSubview(loadingView!)
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
}
