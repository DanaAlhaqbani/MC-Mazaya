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
  
        setupMiddleButton()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 10)!], for: .selected)
        tabBar.backgroundColor = .clear
//        self.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 4  //enter your tabbar no.
        self.navigationController?.navigationBar.setGradientBackground(colorOne: .white, colorTwo: .green)

    }
    
    func setupMiddleButton() {
        let scanButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        var scanButtonFrame = scanButton.frame
        scanButtonFrame.origin.y = view.bounds.height - scanButtonFrame.height - 40
        scanButtonFrame.origin.x = view.bounds.width/2 - scanButtonFrame.size.width/2
        scanButton.frame = scanButtonFrame
        let useTitle = UILabel()
        let QRimage = UIImageView()
        QRimage.image = UIImage(named: "qr")
        QRimage.image = QRimage.image?.imageWithColor(color: .white)
        useTitle.text = "استخدم العرض"
        useTitle.textAlignment = .center
        useTitle.numberOfLines = 2
        useTitle.textColor = .white
        useTitle.font = UIFont(name: "STC", size: 10)
//        scanButton.addSubview(useTitle)
        scanButton.addSubview(QRimage)
//        useTitle.anchor(bottom: scanButton.bottomAnchor, paddingBottom: 13)
//        useTitle.centerXAnchor.constraint(equalTo: scanButton.centerXAnchor).isActive = true
        QRimage.centerXAnchor.constraint(equalTo: scanButton.centerXAnchor).isActive = true
        QRimage.centerYAnchor.constraint(equalTo: scanButton.centerYAnchor).isActive = true
        QRimage.anchor(width: 25, height: 25)
//        let title = NSAttributedString(string: "استخدم العرض", attributes: [NSAttributedString.Key.font: UIFont(name: "STC", size: 10)!, NSAttributedString.Key.foregroundColor: UIColor.white])
//        scanButton.setAttributedTitle(title, for: .normal)
        scanButton.titleLabel?.numberOfLines = 2
        scanButton.titleLabel?.textAlignment = .center
        scanButton.setGradientBackground(colorOne:UIColor(rgb: 0x228986), colorTwo:UIColor(rgb: 0x1C9A8A))
        scanButton.layer.masksToBounds = true
        scanButton.layer.cornerRadius = scanButtonFrame.height/2
        view.addSubview(scanButton)
        view.bringSubviewToFront(tabBar)
        scanButton.setImage(UIImage(named: "example"), for: .normal)
        scanButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
//        self.tabBarItem
        view.layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        selectedIndex = 2
    }
    
}
