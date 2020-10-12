//
//  DscriptionViewController.swift
//  MC Mazaya
//
//  Created by Ajwan Alshaye on 10/02/1442 AH.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit
import Firebase

class DscriptionViewController : UIViewController , UITextViewDelegate {

    let user = Auth.auth().currentUser?.uid
    var offerVC : OfferView?
    var tradeInfo : Trademark!
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
    var checked = false
    var ref = Database.database().reference()
    var favTradesKeys = [String]()
    var favTradeKey = String()
    var favTradeValues = [String]()
    var favDictionary : NSDictionary = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        BrandName.text = tradeInfo.BrandName
        let imgURL = tradeInfo.brandImage
        BrandLogo.sd_setImage(with: URL(string: imgURL ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
        WhoAreWeView.alpha = 0
        BranchView.alpha = 0
        OffersView.alpha = 1
        segmentedControl.addUnderlineForSelectedSegment()
        addTopAndBottomBorders()
        upperline.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 1.0)
        line.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 1.0)
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        setupFavouriteButton()
//        star.setImage(UIImage(named: "Unchecked"), for: .normal)
//        star.setImage(UIImage(named: "Checked"), for: .selected)
//        print()
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
        sender.isSelected = !sender.isSelected
        let isChecked = sender.isSelected
        if !isChecked {
            for i in favDictionary {
                if i.value as? String == self.tradeInfo.BrandName {
                    self.ref.child("Users/\(user!)/FavoriteTradeMarks/\(i.key)").removeValue()
                } // Remove trademark if it's already favourite trade
            } // Iterate over Favourite trademarks dictionray
        } else {
            if favDictionary.contains(where: {$0.value as! String == tradeInfo.BrandName! }) {
                
            } else {
                self.ref.child("Users/\(user!)/FavoriteTradeMarks").childByAutoId().setValue(self.tradeInfo.BrandName)
            }
        } // Add Trademark to Favourite Trademarks Dictionary
    } // End of handling star pressing
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OfferView, segue.identifier == "info" {
            vc.Trade = self.tradeInfo
            self.offerVC = vc
        }
    }
    
    
    func setupFavouriteButton(){
        if favDictionary.contains(where: {$0.value as! String == tradeInfo.BrandName! }) {
            self.star.isSelected = true
        } else {
            self.star.isSelected = false
        }
        star.setImage(UIImage(named: "Checked"), for: .selected)
        star.setImage(UIImage(named: "Unchecked"), for: .normal)
    }
}
