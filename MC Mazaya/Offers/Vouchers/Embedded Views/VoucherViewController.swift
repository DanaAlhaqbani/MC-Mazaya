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
import FirebaseDatabase

class VoucherViewController : UIViewController , UITextViewDelegate {
   
    let user = Auth.auth().currentUser?.uid
    var voucher : Voucher?
    var voucherEmbeddedView : VoucherView?
    var branchesEmbeddedView : VouchersBranches?
    var aboutEmbeddedView : VoucherInfo?
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
           if let vc = segue.destination as? VoucherView, segue.identifier == "toDetails" {
                vc.Trade = self.tradeInfo
                vc.voucher = self.voucher
                self.voucherEmbeddedView = vc
           }
           if let vc = segue.destination as? VouchersBranches, segue.identifier == "toBranches" {
               vc.Trade = self.tradeInfo
               self.branchesEmbeddedView = vc
           }
           if let vc = segue.destination as? VoucherInfo, segue.identifier == "toAboutUs" {
               vc.Trade = self.tradeInfo
               self.aboutEmbeddedView = vc
           }
       }
       

       
   }
  
