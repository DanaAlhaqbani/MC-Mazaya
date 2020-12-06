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
    var isFav : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkFavorite()
        getOffers()
        getBranches()
    }


        
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl){
        //  guard let segmentcontrol = sender as? UISegmentedControl else {return }
        segmentedControl.changeUnderlinePosition()
        print(segmentedControl.selectedSegmentIndex)
        if segmentedControl.numberOfSegments == 3 {
            if sender.selectedSegmentIndex == 2 {
                OffersView.alpha = 1
                WhoAreWeView.alpha = 0
                BranchView.alpha = 0
            }
            if sender.selectedSegmentIndex == 1 {
                OffersView.alpha = 0
                BranchView.alpha = 1
                WhoAreWeView.alpha = 0
            }
            if sender.selectedSegmentIndex == 0 {
                OffersView.alpha = 0
                BranchView.alpha = 0
                WhoAreWeView.alpha = 1
            }
        } else {
            if sender.selectedSegmentIndex == 1 {
                OffersView.alpha = 1
                WhoAreWeView.alpha = 0
            }
            if sender.selectedSegmentIndex == 0 {
                OffersView.alpha = 0
                WhoAreWeView.alpha = 1
            }
        }

        }

        func addTopAndBottomBorders() {
           let thickness: CGFloat = 1.0
            _ = CALayer()
           let bottomBorder = CALayer()
//           topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.BackgroundView.frame.size.width, height: thickness)
//            topBorder.backgroundColor = UIColor.white.cgColor
           bottomBorder.frame = CGRect(x:0, y: self.BackgroundView.frame.size.height - thickness, width: self.BackgroundView.frame.size.width, height:thickness)
           bottomBorder.backgroundColor = UIColor.gray.cgColor
          // BackgroundView.layer.addSublayer(topBorder)
           BackgroundView.layer.addSublayer(bottomBorder)
        }
        
        
    @IBAction func IsFavorite(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isFav = sender.isSelected
        
      if isFav == true {
        self.ref.child("Users/\(user!)/FavoriteTrademarks/\(tradeInfo.trademarkID!)").setValue(true)
//            self.star.isSelected = true
        } else {
            self.ref.child("Users/\(user!)/FavoriteTrademarks").observeSingleEvent(of: .value, with: { (snap) in
                if let dict = snap.value as? [String: Any] {
                    for i in dict {
                        if i.key == self.tradeInfo.trademarkID {
                            self.ref.child("Users/\(self.user!)/FavoriteTrademarks/\(i.key)").removeValue()
                        }
                    }
                }
            })
//            self.star.isSelected = false
        }
        
    } // End of handling star pressing
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OfferView, segue.identifier == "toDetails" {
            vc.Trade = self.tradeInfo
            self.offerVC = vc
        }
        if let vc = segue.destination as? BranchView, segue.identifier == "toBranches" {
            vc.Trade = self.tradeInfo
            self.BranchVC = vc
        }
        if let vc = segue.destination as? WhoWeAreView, segue.identifier == "toAboutUs" {
            vc.Trade = self.tradeInfo
            self.WWAVVC = vc
        }
    }
    
    
    func setupFavouriteButton(){
        if !isFav {
            self.star.isSelected = false
        } else {
            self.star.isSelected = true
        }
        star.setImage(UIImage(named: "Checked"), for: .selected)
        star.setImage(UIImage(named: "Unchecked"), for: .normal)
    }
    
    func checkFavorite(){
        ref.child("Users/\(user!)/FavoriteTrademarks").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let id = snap.key
                print("Aaaaaaaa")

                if self.tradeInfo.trademarkID == id {
                    print("Aaaaaaaa")
                    self.isFav = true
                } else {
                    self.isFav = false
                }
            }
            self.setupFavouriteButton()
        })
    }

    
}
