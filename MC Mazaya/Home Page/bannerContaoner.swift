//
//  bannerContaoner.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 28/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class bannerContaoner: UIViewController {
    @IBOutlet weak var offers: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offers.layer.shadowColor = UIColor.systemGray6.cgColor
        offers.layer.shadowRadius = 2.0
        offers.layer.shadowOpacity = 0.8
        offers.layer.shadowOffset = CGSize(width: 2, height: 2.0)
        offers.layer.cornerRadius = 20
        offers.layer.masksToBounds = false
//        offers.layer.shadowPath.
        offers.clipsToBounds = true
//        offers.image.
    }
    
    
}
