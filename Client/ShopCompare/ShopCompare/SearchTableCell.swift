//
//  SearchTableCell.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/21/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit

class SearchTableCell: UITableViewCell {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backView: UIView!
    
    var product:ProductMdl?
    
    override func awakeFromNib() {
        addButton.layer.borderColor = UIColor(hexString: "#7175D6").CGColor
        addButton.layer.borderWidth = 1
        addButton.layer.cornerRadius = 15
        statusButton.hidden =  true
        backView.layer.cornerRadius = 2
    }
    
    @IBAction func addButtonPressed() {
        
            AppModel.instanta.selectedItemsID = AppModel.instanta.selectedItemsID + ",\(product!.id!)"
            addButton.enabled = false
            addButton.hidden = true
            // TODO: change button color
            
            LoadingScreenCtrl.sharedInstance.showLoading()
            
            // make the best deal request
            SwaggerClientAPI.RestAPI.findBestDeal(list: AppModel.instanta.selectedItemsID).execute { (response, error) in
                
                LoadingScreenCtrl.sharedInstance.hideLoading()
                
                if error == nil && response != nil {
                    AppModel.instanta.shopingList = (response?.body)!
                }
            }
        
    }
    
    @IBAction func statusButtonPressed() {
        
    }
}
