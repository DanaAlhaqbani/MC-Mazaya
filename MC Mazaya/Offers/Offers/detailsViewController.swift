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
        bottomBorder.frame = CGRect(x:0, y: self.BackgroundView.frame.size.height - thickness, width: self.BackgroundView.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.gray.cgColor
        // BackgroundView.layer.addSublayer(topBorder)
        BackgroundView.layer.addSublayer(bottomBorder)
    }
    
    // MARK: - Handling pressing on star button
    @IBAction func IsFavorite(_ sender: UIButton) {
        // Each press will change the state of selection
        sender.isSelected = !sender.isSelected
        self.isFav = sender.isSelected
        // Check if it's already selected to deal with each state
        if isFav == true {
            // Add it to the user's favorite
            self.ref.child("Users/\(user!)/FavoriteTrademarks/\(tradeInfo.trademarkID!)").setValue(true)
        } else {
            // Remove it from user's favorite
            self.ref.child("Users/\(user!)/FavoriteTrademarks").observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let id = snap.key
                    if id == self.tradeInfo.trademarkID {
                        self.ref.child("Users/\(self.user!)/FavoriteTrademarks/\(id)").removeValue()
                    } // Check of trademarks' ids
                } // Iterate over all children
            }) // End of user's favorite observation
        } //End of handling unfavorite trademark
        
    } // End of handling star pressing
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Show details view inside container
        if let vc = segue.destination as? OfferView, segue.identifier == "toDetails" {
            vc.Trade = self.tradeInfo
            self.offerVC = vc
        }
        // Show branches view inside container
        if let vc = segue.destination as? BranchView, segue.identifier == "toBranches" {
            vc.Trade = self.tradeInfo
            self.BranchVC = vc
        }
        // Show About us view inside container
        if let vc = segue.destination as? WhoWeAreView, segue.identifier == "toAboutUs" {
            vc.Trade = self.tradeInfo
            self.WWAVVC = vc
        }
    } // End of prepare for segue function
    
    // MARK: - Favorite settings
    // Set the appropriate star "filled or unfilled" for the trademark
    func setupFavouriteButton(star: UIButton){
        // Check if it's alreade favorite or not
        if !isFav {
            self.star.isSelected = false
        } else {
            self.star.isSelected = true
        }
        //Assign stars to each state
        star.setImage(UIImage(named: "Checked"), for: .selected)
        star.setImage(UIImage(named: "Unchecked"), for: .normal)
    } // End of setting up favorite stars Function
    
    // Check if the trademark is favorite
    func checkFavorite(){
        ref.child("Users/\(user!)/FavoriteTrademarks").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let id = snap.key
                // If it's favorite, fill the star, otherwise keep it unfilled
                if self.tradeInfo.trademarkID == id {
                    self.isFav = true
                } else {
                    self.isFav = false
                }
            } // End of iterate over all user's favorite trademarks
            self.setupFavouriteButton(star: self.star)
        }) // End of observation
    } // End of checking favorite function
    
    
}
