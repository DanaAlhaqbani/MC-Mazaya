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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        
}

