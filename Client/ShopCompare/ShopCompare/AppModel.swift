//
//  AppModel.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/21/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import Foundation

class AppModel {
    static var instanta = AppModel()
    
    var userId: String?
    var userCredits : Double = 22
    var selectedItemsID = ""
    var shopingList = [ProductResponseMdl]()
    
    init () {
        SwaggerClientAPI.basePath = NSBundle.mainBundle().infoDictionary?["ServerURL"] as! String
        userId = "1"
    }
}
