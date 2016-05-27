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
    var listChanged = false
    
    init () {
        SwaggerClientAPI.basePath = NSBundle.mainBundle().infoDictionary?["ServerURL"] as! String
        userId = "1"
    }
    
    func adaugaIdInLista(id : String){
        selectedItemsID = selectedItemsID + ",\(id)"
        listChanged = true
    }
}
