//
//  DscriptionViewController.swift
//  MC Mazaya
//
//  Created by Ajwan Alshaye on 10/02/1442 AH.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit


class DscriptionViewController : UIViewController , UITextViewDelegate {

    
      //var myTableView: UITableView  =   UITableView()
      //  var itemsToLoad: [String] = ["One", "Two", "Three"]
        
        
       
        
    var tradeInfo : Trademark!
       
        
   //     @IBOutlet weak var containerView: UIView!
        
        private var currentView : UIView?
    @IBOutlet weak var BrandName: UILabel!
    
        @IBOutlet weak var OffersView: UIView!
    
        @IBOutlet weak var WhoAreWeView: UIView!
    
        @IBOutlet weak var BranchView: UIView!
        
        @IBOutlet weak var segmentedControl: UISegmentedControl!
        
        @IBOutlet weak var BrandLogo: UIImageView!
        
        @IBOutlet weak var BackgroundView: UIImageView!
        
        @IBOutlet weak var line: UIView!
        
        @IBOutlet weak var star: UIButton!
        @IBOutlet weak var upperline: UIView!
        
       // @IBOutlet weak var Replacement: UIButton!
        
        
        var checked = false
        
        override func viewDidLoad() {
               super.viewDidLoad()
            print("===========is printed selected row============")
            print(tradeInfo)
            
            BrandName.text = tradeInfo.BrandName
            
            performSegue(withIdentifier: "info", sender: tradeInfo)
          WhoAreWeView.alpha = 0
                BranchView.alpha = 0
                OffersView.alpha = 1
            segmentedControl.addUnderlineForSelectedSegment()
            
            addTopAndBottomBorders()
            let yourImage:UIImage = UIImage(named: "images")!
            BrandLogo.maskCircle(inputImage: yourImage)
           
            
            upperline.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 1.0)
            
             line.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 1.0)
            
          //  Utilities.styleFilledButton(Replacement)
            
            // Get main screen bounds
            let screenSize: CGRect = UIScreen.main.bounds
                   
                   let screenWidth = screenSize.width
                   let screenHeight = screenSize.height
            


            
    }
        
        
        
       
        private func setInitialView(){
          //  setChildView(subview: firstView)
            
        }
        
        
        
        
        @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl){
            
          //  guard let segmentcontrol = sender as? UISegmentedControl else {return }
        
            segmentedControl.changeUnderlinePosition()
            
            print(segmentedControl.selectedSegmentIndex)
            
          
            
            if sender.selectedSegmentIndex == 0 {
                       WhoAreWeView.alpha = 1
                       BranchView.alpha = 0
                       OffersView.alpha = 0
                   }
                if sender.selectedSegmentIndex == 1 {
                    WhoAreWeView.alpha = 0
                    BranchView.alpha = 1
                    OffersView.alpha = 0
                }
                    
       if sender.selectedSegmentIndex == 2 {
                       WhoAreWeView.alpha = 0
                       BranchView.alpha = 0
                       OffersView.alpha = 1
                   }
            
            
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info"{
            let des = segue.destination as! OffersView
//            des.Trade = self.tradeInfo
            des.Trade = self.tradeInfo
        }
    }
            

}
