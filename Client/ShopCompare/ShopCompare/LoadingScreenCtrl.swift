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
        let windowFrame = UIApplication.sharedApplication().keyWindow?.rootViewController?.view.frame
        loadingView = UIView(frame: windowFrame!)
        loadingView?.backgroundColor = UIColor.whiteColor()
        let logoImage = UIImageView(frame: CGRectMake(((windowFrame?.width)! - 210) / 2, ((windowFrame?.height)! - 200) / 2, 210, 200))
        logoImage.image = UIImage(named: "logoBig")
        loadingView?.addSubview(logoImage)
        
        loadingView?.alpha = 0.9
    }
    
    func showLoading() {
        let currentWindow = UIApplication.sharedApplication().keyWindow?.rootViewController?.view
        currentWindow?.addSubview(loadingView!)
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
}
