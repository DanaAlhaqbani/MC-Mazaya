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
    var userVouchers = [Voucher]()
    var favDictionary : NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

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



       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let vc = segue.destination as? VoucherView, segue.identifier == "Vinfo" {
               vc.Trade = self.tradeInfo
               vc.vouchers = self.tradOffers
               vc.UserVoucher = self.userVouchers
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
       

       
   }
  
