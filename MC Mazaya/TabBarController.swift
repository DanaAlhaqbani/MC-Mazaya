//
//  TabBarController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 09/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    let layerGradient = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 4  //enter your tabbar no.
        self.navigationController?.navigationBar.setGradientBackground(colorOne: .white, colorTwo: .green)

    }
    
}
