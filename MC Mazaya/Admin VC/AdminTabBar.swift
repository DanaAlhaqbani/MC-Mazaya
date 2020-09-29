//
//  AdminTabBar.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 20/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class AdminTabBar: UITabBarController {
    let layerGradient = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 1  //enter your tabbar no.
        let green = UIColor(rgb: 0x38a089)
        self.navigationController?.navigationBar.backgroundColor = green

    }
    
}
