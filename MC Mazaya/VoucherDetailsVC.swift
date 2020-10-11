//
//  VoucherDetailsVC.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 17/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseAuth

class VoucherDetailsVC : UIViewController , UITextViewDelegate {
   
    let user = Auth.auth().currentUser
    var offersArray = [Offer]()
    //MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var BrandLogo: UIImageView!
    
    @IBOutlet weak var BackgroundView: UIImageView!
    
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var upperline: UIView!
    
    @IBOutlet weak var Replacement: UIButton!
    
    //MARK:- Variables
   var checked = false
    var tradeInfo : Trademark!
    var Categories = [Category]()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addUnderlineForSelectedSegment()
        print("==============Print selected trade=============")
        print(tradeInfo)
        
        addTopAndBottomBorders()
        
        let yourImage:UIImage = UIImage(named: "images")!
        BrandLogo.maskCircle(inputImage: yourImage)
        
        
        upperline.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 1.0)
        
        line.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 1.0)
        
        Utilities.styleFilledButton(Replacement)

    }
    
    
    //MARK: -
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl){
        segmentedControl.changeUnderlinePosition()
    }

    func addTopAndBottomBorders() {
       let thickness: CGFloat = 1.0
       let topBorder = CALayer()
       let bottomBorder = CALayer()
       topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.BackgroundView.frame.size.width, height: thickness)
        topBorder.backgroundColor = UIColor.white.cgColor
       bottomBorder.frame = CGRect(x:0, y: self.BackgroundView.frame.size.height - thickness, width: self.BackgroundView.frame.size.width, height:thickness)
       bottomBorder.backgroundColor = UIColor.gray.cgColor
       BackgroundView.layer.addSublayer(topBorder)
       BackgroundView.layer.addSublayer(bottomBorder)
    }
    
    
    @IBAction func IsFavorite(_ sender: UIButton) {
        
        if checked {
            UIImage(named:"Unchecked") != nil
            sender.setImage(UIImage(named:"Checked"), for: .normal)
                self.checked = true
            
        }
        else{
        UIImage(named:"Checked") != nil
            sender.setImage( UIImage(named:"Unchecked"), for:.normal)
             checked = true
            
            }
        }
        
    
    /*
    @IBAction func replacePressed(_ sender: Any) {
        let userPoints = userData.points
       // var UserPointsNum = Int(userPoints)
        
       // let voucherPoint = tradeInfo.offers.numberOfPoints ?? "0"
      //  var VoucherPointsNum = Int(voucherPoint)
        if voucherPoint.isEqual(userPoints)  {
            // success
           let alert = self.alertContent(title: "مبروك حصلت على قسيمة شرائية!", message: "سوف يتم إستبدال نقاطك للحصول على هذة القسيمة")
            self.present(alert, animated: true, completion: nil)
        }
        else {
            //Fail
            let alert = self.alertContent(title: "عذراً", message: "عدد نقاطك غير كافي للحصول على هذة القسيمة")
            self.present(alert, animated: true, completion: nil)
        }
    }
*/
    
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            self.navigationController?.popToRootViewController(animated: true)
        }))
        return alertVC
    }
}
