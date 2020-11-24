//
//  detailsViewController.swift
//  MC Mazaya
//
//  Created by Ajwan Alshaye on 10/02/1442 AH.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class detailsViewController : UIViewController , UITextViewDelegate {

    let user = Auth.auth().currentUser?.uid
    var offers = [Offer]()
    var filteredOffers = [Offer]()
    var branches = [Branch]()
    var offerVC : OfferView?
    var BranchVC : BranchView?
    var WWAVVC : WhoWeAreView?
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
    var ref = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFavouriteButton()
        getOffers()
        getBranches()
    }


        
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl){
        //  guard let segmentcontrol = sender as? UISegmentedControl else {return }
        segmentedControl.changeUnderlinePosition()
        print(segmentedControl.selectedSegmentIndex)
        if segmentedControl.numberOfSegments == 3 {
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
        } else {
            if sender.selectedSegmentIndex == 0 {
                WhoAreWeView.alpha = 1
                BranchView.alpha = 0
                OffersView.alpha = 0
            }
            if sender.selectedSegmentIndex == 1 {
                WhoAreWeView.alpha = 0
                BranchView.alpha = 0
                OffersView.alpha = 1
            }
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
//        if !tradeInfo.isFav! {
//            self.ref.child("Users/\(user!)/FavoriteTradeMarks").childByAutoId().setValue(self.tradeInfo.BrandName)
//            self.star.isSelected = true
//            self.tradeInfo.isFav = true
//        } else {
//            self.ref.child("Users/\(user!)/FavoriteTradeMarks").observeSingleEvent(of: .value, with: { (snap) in
//                if let dict = snap.value as? [String: Any] {
//                    for i in dict {
//                        if i.value as? String == self.tradeInfo.BrandName {
//                            self.ref.child("Users/\(self.user!)/FavoriteTradeMarks/\(i.key)").removeValue()
//                        }
//                    }
//                }
//            })
//            self.star.isSelected = false
//            self.tradeInfo.isFav = false
//        }
        
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
        if let vc = segue.destination as? OfferView, segue.identifier == "info" {
            vc.Trade = self.tradeInfo
            self.offerVC = vc
        }
        if let vc = segue.destination as? BranchView, segue.identifier == "info" {
            vc.Trade = self.tradeInfo
            self.BranchVC = vc
        }
        if let vc = segue.destination as? WhoWeAreView, segue.identifier == "info" {
            vc.Trade = self.tradeInfo
            self.WWAVVC = vc
        }
    }
    
    
    func setupFavouriteButton(){
//        if !tradeInfo.isFav! {
//            self.star.isSelected = false
//        } else {
//            self.star.isSelected = true
//        }
//        star.setImage(UIImage(named: "Checked"), for: .selected)
//        star.setImage(UIImage(named: "Unchecked"), for: .normal)
    }
    

    
}
