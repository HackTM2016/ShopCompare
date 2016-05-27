//
//  AddProductController.swift
//  ShopCompare
//
//  Created by Catalin-Andrei BORA on 5/21/16.
//  Copyright © 2016 HackTM2016. All rights reserved.
//

import UIKit
import CoreLocation

class AddProductController: UIViewController {
 
    var barcodeScanner:ROBarcodeScannerViewController?
    
    @IBOutlet weak var scaneazaInfoText: UILabel!
    @IBOutlet weak var scaneazaButon: UIButton!
    @IBOutlet weak var numeTextfield: UITextField!
    @IBOutlet weak var pretTextfield: UITextField!
    @IBOutlet weak var confirmaButon: UIButton!
    
    @IBOutlet weak var radius1but: UIButton!
    @IBOutlet weak var radius2but: UIButton!
    @IBOutlet weak var radius3but: UIButton!
    @IBOutlet weak var radius4but: UIButton!
    
    var categoriaSelectata = "LACTATE"
    var barcodeValue = "000"
    
    var locManager = CLLocationManager()
    
    let categories = [
        "LACTATE",
        "FRUCTE",
        "CARNE",
        "DULCIURI"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "ROBarcodeScanner", bundle: NSBundle(forClass: ROBarcodeScannerViewController.self))
        barcodeScanner = storyboard.instantiateViewControllerWithIdentifier("ROBarcodeScannerViewControllerScene") as? ROBarcodeScannerViewController
        
        // Do any additional setup after loading the view.
        
        confirmaButon.layer.cornerRadius = 20
        confirmaButon.layer.shadowOffset = CGSize(width: 0, height: 0)
        confirmaButon.layer.shadowOpacity = 0.5
        confirmaButon.layer.shadowRadius = 6
        
        numeTextfield.layer.borderColor = UIColor(hexString: "#6B6B6B").CGColor
        numeTextfield.layer.borderWidth = 1
        numeTextfield.layer.cornerRadius = 20
        
        pretTextfield.layer.borderColor = UIColor(hexString: "#6B6B6B").CGColor
        pretTextfield.layer.borderWidth = 1
        pretTextfield.layer.cornerRadius = 20
        
        radius1but.tag = 0
        radius2but.tag = 2
        radius3but.tag = 1
        radius4but.tag = 3
        
        locManager.requestWhenInUseAuthorization()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddProductController.hideKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func hideKeyboard() {
        numeTextfield.resignFirstResponder()
        pretTextfield.resignFirstResponder()
    }
    
    func cleanup() {
        numeTextfield.text = ""
        pretTextfield.text = ""
        scaneazaInfoText.text = "Scaneaza codul"
        scaneazaButon.enabled = true
        scaneazaButon.setImage(UIImage(named: "scaneaza"), forState: .Normal)
    }
    
    @IBAction func scanClicked() {
        barcodeScanner?.barcodeScanned = { (barcode:String) in
            self.dismissViewControllerAnimated(true, completion: nil)
            print("Received following barcode: \(barcode)")
            self.barcodeValue = barcode
            
            dispatch_async(dispatch_get_main_queue(),{
                self.scaneazaInfoText.text = "Cod scant \n + \(barcode)"
                self.scaneazaButon.enabled = false
                self.scaneazaButon.setImage(UIImage(named:"ScanatDeja"), forState: .Disabled)
            })
        }
        
        if let barcodeScanner = self.barcodeScanner {
            self.presentViewController(barcodeScanner, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonPressed() {
        cleanup()
        
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    @IBAction func confirmButtonPressed() {
        
        var currentLocation = CLLocation()
        var coordonate = "0.00,0.00"

        LoadingScreenCtrl.sharedInstance.showLoading()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            
            currentLocation = locManager.location!
            
            coordonate = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
            
        }
        
        SwaggerClientAPI.RestAPI.addProduct(gpsPosition: coordonate, barcode: barcodeValue, name: numeTextfield.text!, userId: AppModel.instanta.userId!, price: pretTextfield.text!, category: categoriaSelectata).execute { (response, error) in
            
            LoadingScreenCtrl.sharedInstance.hideLoading()
            
            if error == nil && response != nil {
                self.cancelButtonPressed()
            }
        }
        
    }
    
    @IBAction func radiusButtonPressed(sender: UIButton) {
        radius1but.setImage(UIImage(named: "nebifat"), forState: .Normal)
        radius2but.setImage(UIImage(named: "nebifat"), forState: .Normal)
        radius3but.setImage(UIImage(named: "nebifat"), forState: .Normal)
        radius4but.setImage(UIImage(named: "nebifat"), forState: .Normal)
        sender.setImage(UIImage(named: "bifat"), forState: .Normal)
        
        print("selectat :\(categories[sender.tag])")
        
        categoriaSelectata = categories[sender.tag]
    }
    
}
