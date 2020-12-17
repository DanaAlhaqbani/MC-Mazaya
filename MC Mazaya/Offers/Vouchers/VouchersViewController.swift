//
//  VouchersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

class VouchersViewController: UIViewController {
    
    @IBOutlet weak var VoucherSC: UISegmentedControl!
    @IBOutlet weak var allVouchersView: UIView!
    @IBOutlet weak var usedVouchersView: UIView!
    var allVouchers: AllVouchersView?
    var usedVouchers: usedVouchersView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentUI()
        allVouchersView.alpha = 1
        usedVouchersView.alpha = 0
    }
    
    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl){
        VoucherSC.changeUnderlinePosition()
        print(VoucherSC.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 1 {
            allVouchersView.alpha = 1
            usedVouchersView.alpha = 0
        }
        if sender.selectedSegmentIndex == 0 {
            allVouchersView.alpha = 0
            usedVouchersView.alpha = 1
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AllVouchersView, segue.identifier == "toAllVouchers" {
//            vc.Trade = self.tradeInfo
            self.allVouchers = vc
        }
        if let vc = segue.destination as? usedVouchersView, segue.identifier == "toUsedVouchers" {
//            vc.Trade = self.tradeInfo
            self.usedVouchers = vc
        }
    }
    
}
