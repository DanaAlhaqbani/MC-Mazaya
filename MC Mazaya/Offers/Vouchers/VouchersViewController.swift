//
//  VouchersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class VouchersViewController: UIViewController {

    @IBOutlet weak var trademarksTableView: UITableView!
    let ref = Database.database().reference()
    var voucherTrademark = Trademark()
    @IBOutlet weak var VoucherSC: UISegmentedControl!
    var vouchersTrade = [Trademark]()
    var vouchers = [Voucher]()
    var Categories = [Category]()
    var Trades = [Trademark]()
    let firstVC = launchViewController()
    var VouchersTrade = [Trademark]()
    var isMyVoucher = false
    var userVouchers = [Voucher]()
    var userVouchersKey = [String]()
    let userID = Auth.auth().currentUser?.uid
    // master array
//    lazy var titlesToDisplay = AvaVouchersTitles
//    lazy var namesToDisplay = AvaVouchersNames
//    lazy var imagesToDisplay = AvaVouchersImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentUI()
        trademarksTableView.dataSource = self
        trademarksTableView.delegate = self
         // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
        getUserVoucher()
        getVouchers()
     }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toVoucherDetails" {
               let dis = segue.destination as! VoucherViewController
               dis.tradeInfo = sender as? Trademark
//            dis.tradOffers = self.vouchersList
//            dis.userVouchers = self.userVouchers
           } // Show Description Segue
    }
}
