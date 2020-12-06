//
//  DealExtension.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 10/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension DealViewController{
    
    func setupUI(){
        BrandName.text = tradeInfo.trademarkName
        let imgURL = tradeInfo.imgURL
        BrandLogo.sd_setImage(with: URL(string: imgURL ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
        WhoAreWeView.alpha = 0
        BranchView.alpha = 0
        OffersView.alpha = 1
        segmentedControl.addUnderlineForSelectedSegment()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17) as Any], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17)!], for: .selected)
        BrandLogo.layer.borderColor = UIColor.systemGray6.cgColor
        BrandLogo.layer.borderWidth = 0.8
        BrandLogo.layer.shadowPath = UIBezierPath(rect: BrandLogo.bounds).cgPath
        BrandLogo.layer.shadowRadius = 5
        BrandLogo.layer.shadowOffset = .zero
        BrandLogo.layer.shadowOpacity = 1
        BrandLogo.layer.cornerRadius = BrandLogo.frame.height / 2
        upperline.addBorder(toSide: .bottom, withColor: UIColor.systemGray5.cgColor, andThickness: 1.0)
        line.addBorder(toSide: .bottom, withColor: UIColor.systemGray5.cgColor, andThickness: 1.0)
        if tradeInfo.serviceType == "محلي" || tradeInfo.serviceType == "الكل" {
            self.segmentedControl.insertSegment(withTitle: "الفروع", at: 1, animated: true)
        }
    }
    
    func addTopAndBottomBorders() {
        let thickness: CGFloat = 1.0
        _ = CALayer()
        let bottomBorder = CALayer()
   //           topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.BackgroundView.frame.size.width, height: thickness)
   //            topBorder.backgroundColor = UIColor.white.cgColor
        bottomBorder.frame = CGRect(x:0, y: self.BackgroundView.frame.size.height - thickness, width: self.BackgroundView.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.gray.cgColor
             // BackgroundView.layer.addSublayer(topBorder)
        BackgroundView.layer.addSublayer(bottomBorder)
    }
}
