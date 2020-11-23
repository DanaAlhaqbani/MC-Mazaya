//
//  MainTabBarController.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 27/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//
import UIKit

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
//        tabBar.backgroundColor = .clear
//        tabBar.backgroundImage = UIImage.from(color: .clear)
//        tabBar.shadowImage = UIImage()
//        let tabbarBackgroundView = RoundShadowView(frame: tabBar.frame)
//        tabbarBackgroundView.layer.cornerRadius = 20
//        tabbarBackgroundView.backgroundColor = .white
//        tabbarBackgroundView.frame.size.height = tabBar.frame.size.height
//        tabbarBackgroundView.frame.size.width = tabBar.frame.size.width
//        view.addSubview(tabbarBackgroundView)
//        let fillerView = UIView()
//        fillerView.frame = tabBar.frame
//        fillerView.layer.masksToBounds = true
//        fillerView.roundCorners([.topLeft, .topRight], radius: 25)
//        fillerView.backgroundColor = .white
//        view.addSubview(fillerView)
//        view.bringSubviewToFront(tabBar)
        self.tabBar.layer.cornerRadius = 25
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = .clear
        tabBar.layer.shadowColor = UIColor.systemGray5.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tabBar.layer.shadowRadius = 15
        tabBar.layer.shadowOpacity = 1
//        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 10)!], for: .selected)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = 4  //enter your tabbar no.
        self.navigationController?.navigationBar.setGradientBackground(colorOne: .white, colorTwo: .green)

    }
}


class RoundShadowView: UIView {

    let containerView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutView() {

        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -8)
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 10.0
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        // pin the containerView to the edges to the view
//        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
////        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}


