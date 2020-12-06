//
//  VouchersSegmentedVC.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 14/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class VouchersSegmentedVC : UIViewController {
    @IBOutlet weak var availableVouchers: UIView!
    @IBOutlet weak var myVouchers: UIView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
    }
     @IBAction func didChangeSegment(_ sender: UISegmentedControl){
         if sender.selectedSegmentIndex == 0 {
             availableVouchers.alpha = 1
             myVouchers.alpha = 0
         }
         else if sender.selectedSegmentIndex == 1 {
             availableVouchers.alpha = 0
             myVouchers.alpha = 1
         }
     }
}
