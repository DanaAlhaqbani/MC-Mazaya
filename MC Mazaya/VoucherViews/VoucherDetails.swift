//
//  VoucherDetailsVC.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 17/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class VoucherDetails : UIViewController , UITextViewDelegate {
   
       let user = Auth.auth().currentUser?.uid
       var offerVC : VoucherView?
       var BranchVC : VouchersBranches?
       var WWAVVC : VoucherInfo?
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
      var tradOffers = [Offer]()

       var favDictionary : NSDictionary = [:]
   //    var isFavourite = false
   //    override func viewWillAppear(_ animated: Bool) {
   //        super.viewWillAppear(true)
   //        setupFavouriteButton()
   //    }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           BrandName.text = tradeInfo.BrandName
           let imgURL = tradeInfo.brandImage
           BrandLogo.sd_setImage(with: URL(string: imgURL ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
           WhoAreWeView.alpha = 0
           BranchView.alpha = 0
           OffersView.alpha = 1
           segmentedControl.addUnderlineForSelectedSegment()
           segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17)], for: .normal)
           segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17)], for: .selected)
   //        BrandLogo.layer.shadowColor = UIColor.systemGray6.cgColor
           BrandLogo.layer.borderColor = UIColor.systemGray6.cgColor
           BrandLogo.layer.borderWidth = 0.8
           BrandLogo.layer.shadowPath = UIBezierPath(rect: BrandLogo.bounds).cgPath
           BrandLogo.layer.shadowRadius = 5
           BrandLogo.layer.shadowOffset = .zero
           BrandLogo.layer.shadowOpacity = 1
   //        BrandLogo.layer.shadowColor = UIColor.gray.cgColor
   //        addTopAndBottomBorders()
           BrandLogo.layer.cornerRadius = BrandLogo.frame.height / 2
   //        BrandLogo.layer.borderWidth = 1.5
   //        BrandLogo.layer.borderColor = UIColor.white.cgColor
           upperline.addBorder(toSide: .bottom, withColor: UIColor.systemGray5.cgColor, andThickness: 1.0)
           line.addBorder(toSide: .bottom, withColor: UIColor.systemGray5.cgColor, andThickness: 1.0)
           setupFavouriteButton()
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
   //           topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.BackgroundView.frame.size.width, height: thickness)
   //            topBorder.backgroundColor = UIColor.white.cgColor
              bottomBorder.frame = CGRect(x:0, y: self.BackgroundView.frame.size.height - thickness, width: self.BackgroundView.frame.size.width, height:thickness)
              bottomBorder.backgroundColor = UIColor.gray.cgColor
             // BackgroundView.layer.addSublayer(topBorder)
              BackgroundView.layer.addSublayer(bottomBorder)
           }
           
           
       @IBAction func IsFavorite(_ sender: UIButton) {
           if !tradeInfo.isFav! {
               self.ref.child("Users/\(user!)/FavoriteTradeMarks").childByAutoId().setValue(self.tradeInfo.BrandName)
               self.star.isSelected = true
               self.tradeInfo.isFav = true
           } else {
               self.ref.child("Users/\(user!)/FavoriteTradeMarks").observeSingleEvent(of: .value, with: { (snap) in
                   if let dict = snap.value as? [String: Any] {
                       for i in dict {
                           if i.value as? String == self.tradeInfo.BrandName {
                               self.ref.child("Users/\(self.user!)/FavoriteTradeMarks/\(i.key)").removeValue()
                           }
                       }
                   }
               })
               self.star.isSelected = false
               self.tradeInfo.isFav = false
           }
           
   //        sender.isSelected = !sender.isSelected
   //        let isChecked = sender.isSelected
   //        if !isChecked {
   //            for i in favDictionary {
   //                if i.value as? String == self.tradeInfo.BrandName {
   //                    self.ref.child("Users/\(user!)/FavoriteTradeMarks/\(i.key)").removeValue()
   //                    self.ref.child("Users/\(user!)/FavoriteTradeMarks").observeSingleEvent(of: .value, with: {(snap) in
   //                        if let dict = snap.value as? NSDictionary {
   //                            self.favDictionary = dict
   //                        }
   //                    })
   //                } // Remove trademark if it's already favourite trade
   //            } // Iterate over Favourite trademarks dictionray
   //            print(favDictionary)
   //        } else {
   //            self.ref.child("Users/\(user!)/FavoriteTradeMarks").childByAutoId().setValue(self.tradeInfo.BrandName)
   //        } // Add Trademark to Favourite Trademarks Dictionary
           
       } // End of handling star pressing
       
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let vc = segue.destination as? VoucherView, segue.identifier == "Vinfo" {
               vc.Trade = self.tradeInfo
               vc.vouchers = self.tradOffers
               self.offerVC = vc
           }
           if let vc = segue.destination as? VouchersBranches, segue.identifier == "Vinfo" {
               vc.Trade = self.tradeInfo
               self.BranchVC = vc
           }
           if let vc = segue.destination as? VoucherInfo, segue.identifier == "Vinfo" {
               vc.Trade = self.tradeInfo
               self.WWAVVC = vc
           }
       }
       
       
       func setupFavouriteButton(){
           if !tradeInfo.isFav! {
               self.star.isSelected = false
           } else {
               self.star.isSelected = true
           }
           star.setImage(UIImage(named: "Checked"), for: .selected)
           star.setImage(UIImage(named: "Unchecked"), for: .normal)
       }
       
   }
