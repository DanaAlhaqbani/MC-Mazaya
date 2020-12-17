//
//  DealViewController.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 10/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class DealViewController : UIViewController , UITextViewDelegate {
    
    let user = Auth.auth().currentUser?.uid
    var deal : Deal?
    var dealEmbeddedView : DealView?
    var branchesEmbeddedView : DealBranchView?
    var aboutEmbeddedView : DealAboutView?
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DealView, segue.identifier == "toDetails" {
            vc.Trade = self.tradeInfo
            vc.deal = self.deal
            self.dealEmbeddedView = vc
            //           self.
        }
        if let vc = segue.destination as? DealBranchView, segue.identifier == "toBranches" {
            vc.Trade = self.tradeInfo
            self.branchesEmbeddedView = vc
        }
        if let vc = segue.destination as? DealAboutView, segue.identifier == "toAboutUs" {
            vc.Trade = self.tradeInfo
            self.aboutEmbeddedView = vc
        }
    }
    
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

