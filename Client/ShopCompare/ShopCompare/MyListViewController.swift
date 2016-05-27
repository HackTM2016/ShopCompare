//
//  MyListViewController.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/22/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit
import AlamofireImage

class MyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var magazinLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var logoMagazin: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let categoryColor = [
        "LACTATE": "#47FFC0",
        "FRUCTE":"#6AFF47",
        "CARNE":"#FF9E47",
        "DULCIURI":"#FF4747"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppModel.instanta.shopingList.count > 0 ? AppModel.instanta.shopingList.count : 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let product = AppModel.instanta.shopingList[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myListCell", forIndexPath: indexPath) as! MyListCell
        
        cell.itemName.text = product.productMdl!.name
        if let bestPrice = product.bestPrice {
            cell.itemPrice.text = "\(bestPrice.price!)"
        }
        
        cell.categoryView.backgroundColor = UIColor(hexString:categoryColor[(product.productMdl!.category?.rawValue)!]!)
        
        if let atlePreturiList = product.otherPrices {
            if atlePreturiList.count > 0 {
                cell.numeExtra1.text = atlePreturiList[0].store!.rawValue
                cell.pretExtra1.text = "\(atlePreturiList[0].price!) RON"                
            }
            if atlePreturiList.count > 1 {
                cell.numeExtra2.text = atlePreturiList[1].store!.rawValue
                cell.pretExtra2.text = "\(atlePreturiList[1].price!) RON"
            }
        }
        return cell
    }
    
    func refreshData() {
        
        if AppModel.instanta.shopingList.count > 0  {
            if let bestStore = AppModel.instanta.shopingList[0].bestPrice {
                magazinLabel.text = "\(bestStore.store!.rawValue)"
                
                let URL = NSURL(string: bestStore.imageUrl!)!
                let placeholderImage = UIImage(named: "Info")!
                logoMagazin.af_setImageWithURL(URL, placeholderImage: placeholderImage)
            }
            totalLabel.text = "\(AppModel.instanta.shopingList[0].totalSum!) RON"
            
            tableView.reloadData()
        } else {
            magazinLabel.text = ""
            totalLabel.text = "0 RON"
            tableView.reloadData()
            logoMagazin.image = nil
        }
    }
    
    @IBAction func emptyListButtonPressed(sender: UIButton) {
        AppModel.instanta.shopingList.removeAll()
        AppModel.instanta.selectedItemsID = ""
        
        refreshData()
    }
    
}