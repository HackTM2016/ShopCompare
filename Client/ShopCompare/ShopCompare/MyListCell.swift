//
//  MyListCell.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/22/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit

class MyListCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var backView: UIView!

    @IBOutlet weak var viewToRound: UIView!
    
    @IBOutlet weak var pretExtra1: UILabel!
    @IBOutlet weak var iconExtra1: UIImageView!
    @IBOutlet weak var numeExtra1: UILabel!
    
    @IBOutlet weak var numeExtra2: UILabel!
    @IBOutlet weak var iconExtra2: UIImageView!
    @IBOutlet weak var pretExtra2: UILabel!
    
    @IBAction func raporteazaButtonPressed() {
    }
    
    override func awakeFromNib() {
        viewToRound.layer.borderColor = UIColor.lightGrayColor().CGColor
        viewToRound.layer.borderWidth = 1
        viewToRound.layer.cornerRadius = 6
        backView.layer.cornerRadius = 2
    }
    
}