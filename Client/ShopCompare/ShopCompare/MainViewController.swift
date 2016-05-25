//
//  ViewController.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/21/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var browseButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var mainVIew: UIView!

    @IBOutlet weak var browseIndicator: UIView!
    @IBOutlet weak var profileIndicator: UIView!
    
    var searchCtrl : SearchController?
    var addCtrl : AddProductController?
    var listCtrl : MyListViewController?
    var profilCtrl : ProfilController?
    
    var listOnScreen = false
    var profilOnScreen = false
    
    let categories = [
        "LACTATE",
        "FRUCTE",
        "CARNE",
        "DULCIURI"]
    
    let categoryColor = [
        "#47FFC0",
        "#6AFF47",
        "#FF9E47",
        "#FF4747"]
    
    let categorieImage = [
        "LactateImage",
        "FructeImage",
        "CarneImage",
        "DulciuriImage"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        roundedView.layer.cornerRadius = 35
        
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor(hexString: "#9c9fed").CGColor
        textField.layer.borderWidth = 1
        
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor =  UIColor(hexString: "#9c9fed").CGColor
        addButton.layer.cornerRadius = 20
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: SearchController.self))
        searchCtrl = storyboard.instantiateViewControllerWithIdentifier("searchCtrl") as? SearchController
        addCtrl = storyboard.instantiateViewControllerWithIdentifier("addCtrl") as? AddProductController
        listCtrl = storyboard.instantiateViewControllerWithIdentifier("listCtrl") as? MyListViewController
        profilCtrl = storyboard.instantiateViewControllerWithIdentifier("profile") as? ProfilController
            
        AppModel.instanta.userId = "1"
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButtonPressed(sender: UIButton) {
        
        if self.searchWidthConstraint.constant == 40 {
            toggleOnSearch()
        } else {
            toggleOffSearch()
        }
    }

    func toggleOffSearch() {
        textField.resignFirstResponder()
        
        addButton.setTitle("+ Add Item", forState: .Normal)
        
        UIView.animateWithDuration(Double(1), animations: {
            self.searchWidthConstraint.constant = 40
            self.view.layoutIfNeeded()
        })
    }
    
    func toggleOnSearch() {
        textField.becomeFirstResponder()
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        addButton.setTitle("+", forState: .Normal)
        
        UIView.animateWithDuration(Double(1), animations: {
            self.searchWidthConstraint.constant = screenWidth - (18 + 16 + 40)
            self.view.layoutIfNeeded()
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("category", forIndexPath: indexPath) as! CategoryCell
        
        cell.categoryName.text = categories[indexPath.row]
        cell.categoryColor.backgroundColor = UIColor(hexString: categoryColor[indexPath.row])
        cell.categoryImage.image = UIImage(named: categorieImage[indexPath.row])
        cell.backView.layer.cornerRadius = 2
        cell.backView.layer.shadowOffset = CGSize(width: 1, height: 2)
        cell.backView.layer.shadowOpacity = 0.3
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        LoadingScreenCtrl.sharedInstance.showLoading()
        
        // make the server request
        SwaggerClientAPI.RestAPI.findProduct(category: categories[indexPath.row], query: "").execute { (response, error) in
            
            LoadingScreenCtrl.sharedInstance.hideLoading()
            
            if error == nil && response != nil && response?.body.count > 0 {
                self.showSearchScreenWithResponse(response?.body)
            }
        }
        
    }
    
    func showSearchScreenWithResponse(list:[ProductMdl]?) {
        
        searchCtrl?.list = list
        self.collectionView.addSubview(searchCtrl!.view)
        addChildViewController(searchCtrl!)
        searchCtrl?.table.reloadData()
        browseIndicator.hidden = true
        browseButton.setTitle("Inapoi", forState: .Normal)
        
    }
    
    @IBAction func addProductButtonPressed() {
        self.mainVIew.addSubview(addCtrl!.view)
        addChildViewController(addCtrl!)
    }
    
    @IBAction func listButtonPressed() {
        
        if listOnScreen == false {
            self.mainVIew.addSubview(listCtrl!.view)
            addChildViewController(listCtrl!)
            browseIndicator.hidden = true
            profileIndicator.hidden = true
            browseButton.setTitle("Inapoi", forState: .Normal)
            listCtrl?.refreshData()
            listOnScreen = true
        }
        
    }
    
    @IBAction func profileButtonPressed(sender: AnyObject) {
        
        if profilOnScreen == false {
            self.mainVIew.addSubview(profilCtrl!.view)
            addChildViewController(profilCtrl!)
            browseIndicator.hidden = true
            profileIndicator.hidden = false
            listOnScreen = false
            profilOnScreen = true
        }
    }
    
    @IBAction func browseButtonPressed() {
        searchCtrl!.view.removeFromSuperview()
        searchCtrl!.removeFromParentViewController()
        browseIndicator.hidden = false
        browseButton.setTitle("Browse", forState: .Normal)
        listCtrl!.view.removeFromSuperview()
        listCtrl!.removeFromParentViewController()
        profilCtrl?.view.removeFromSuperview()
        profilCtrl?.removeFromParentViewController()
        listOnScreen = false
        profileIndicator.hidden = true
        profilOnScreen = false
    }
    
}

