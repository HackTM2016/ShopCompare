//
//  SearchController.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/21/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var foundInfoLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var list:[ProductMdl]?
    
    let categoryColor = [
        "LACTATE": "#47FFC0",
        "FRUCTE":"#6AFF47",
        "CARNE":"#FF9E47",
        "DULCIURI":"#FF4747"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        table.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list == nil) ? 0 : (list?.count)!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath) as! SearchTableCell
        
        cell.productName.text = list![indexPath.row].name
        cell.categoryView.backgroundColor = UIColor(hexString:categoryColor[(list![indexPath.row].category?.rawValue)!]!)
        cell.product = list![indexPath.row]
        cell.addButton.setTitle("+ Adauga", forState: .Normal)
        cell.addButton.backgroundColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        
        if let id = list![indexPath.row].id {
            
            let rangeOfString = AppModel.instanta.selectedItemsID.rangeOfString(","+id)
            if rangeOfString != nil {
                if rangeOfString?.endIndex == AppModel.instanta.selectedItemsID.endIndex ||
                    AppModel.instanta.selectedItemsID.substringWithRange((rangeOfString?.endIndex)!..<(rangeOfString?.endIndex.advancedBy(1))!) == "," {
                
                    cell.addButton.enabled = false
                    cell.addButton.setTitle("Adaugat", forState: .Normal)
                    cell.addButton.backgroundColor = UIColor(hexString: "#E7E7E7")
                }
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let id = list![indexPath.row].id {
            if AppModel.instanta.selectedItemsID.rangeOfString(","+id) == nil {
                
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! SearchTableCell
                cell.addButtonPressed()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let lista = list {
            foundInfoLabel?.text = "\(lista.count) produse gasite"
        }
        
        table.reloadData()
    }
}