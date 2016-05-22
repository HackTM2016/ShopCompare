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
    
    var product:ProductMdl?
    
    override func awakeFromNib() {
        addButton.layer.borderColor = UIColor(hexString: "#7175D6").CGColor
        addButton.layer.borderWidth = 1
        addButton.layer.cornerRadius = 15
        statusButton.hidden =  true
    }
    
    @IBAction func addButtonPressed() {
    
    }
    
    @IBAction func statusButtonPressed() {
        
    }
}
