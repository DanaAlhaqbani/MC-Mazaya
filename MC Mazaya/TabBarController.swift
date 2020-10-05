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
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 10)!], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 10)!], for: .selected)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 4  //enter your tabbar no.
        self.navigationController?.navigationBar.setGradientBackground(colorOne: .white, colorTwo: .green)

    }
    
}
