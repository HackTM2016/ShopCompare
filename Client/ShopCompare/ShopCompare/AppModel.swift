//
//  AppModel.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/21/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import Foundation

class AppModel {
    static var sharedInstance = AppModel()
    
    var userId: Int?
    
    init () {
        SwaggerClientAPI.basePath = NSBundle.mainBundle().infoDictionary?["ServerURL"] as! String
    }
}
