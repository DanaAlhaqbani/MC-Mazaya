//
//  VoucherExtensions.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 09/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension VoucherViewController{
    
    func setupUI(){
        BrandName.text = tradeInfo.trademarkName
        let imgURL = tradeInfo.imgURL
        BrandLogo.sd_setImage(with: URL(string: imgURL ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
        WhoAreWeView.alpha = 0
        BranchView.alpha = 0
        OffersView.alpha = 1
        segmentedControl.addUnderlineForSelectedSegment()
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17) as Any], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17) as Any], for: .selected)
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
        let topBorder = CALayer()
        let bottomBorder = CALayer()
   //           topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.BackgroundView.frame.size.width, height: thickness)
   //            topBorder.backgroundColor = UIColor.white.cgColor
        bottomBorder.frame = CGRect(x:0, y: self.BackgroundView.frame.size.height - thickness, width: self.BackgroundView.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor.gray.cgColor
             // BackgroundView.layer.addSublayer(topBorder)
        BackgroundView.layer.addSublayer(bottomBorder)
    }
}



extension VouchersViewController {
    
    func setupSegmentUI(){
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        VoucherSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        VoucherSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
//        VoucherSC.font(name: "STC", size: 18)
        VoucherSC.selectedSegmentIndex = 1
//        VoucherSC.addTarget(self, action: #selector(handleSCChange), for: .valueChanged)
    }
//    @objc fileprivate func handleSCChange(){
//        print(VoucherSC.selectedSegmentIndex)
//        switch VoucherSC.selectedSegmentIndex {
//        case 1:
////            namesToDisplay = AvaVouchersNames
////            titlesToDisplay = AvaVouchersTitles
////            imagesToDisplay = AvaVouchersImage
//            isMyVoucher = false
//        case 0:
////            namesToDisplay = MyVouchersNames
////            titlesToDisplay = MyVouchersTitle
////            imagesToDisplay = MyVouchersImages
//            isMyVoucher = true
//
//        default:
//            break
//        }
//        trademarksTableView.reloadData()
//    }
    
    func getUserVoucher(){
         // Do any additional setup after loading the view.
//        voucherRef = Database.database().reference().child("Users").child(userID!).child("VoucherList");
//        voucherRef.observe(DataEventType.value, with: { (snapshot) in
//             //if the reference have some values
//            if snapshot.childrenCount > 0 {
//                 //clearing the list
//                self.userVouchers.removeAll()
//                 //iterating through all the values
//                for voucher in snapshot.children.allObjects as! [DataSnapshot] {
//                     //getting values
//                    let voucherObject = voucher.value as? [String: AnyObject]
//                    let brandName = voucherObject?["BrandName"] as? String
//                    let brandImage = voucherObject?["BrandImage"] as? String
//                    let voucherTitle = voucherObject?["VoucherTitle"] as? String
//                    let voucherCode = voucherObject?["VoucherCode"] as? String
//                    let voucherNum = voucherObject?["voucherNum"] as? Int
//                    let voucherDes =  voucherObject?["VoucherDes"] as? String
//                    self.MyVouchersTitle.append(voucherTitle ?? "")
//                    self.MyVouchersNames.append(brandName ?? "")
//                    self.MyVouchersImages.append(brandImage ?? "")
//                    let voucherKey = voucher.key
//                    self.userVouchersKey.append(voucherKey)
//                     //creating artist object with model and fetched values
////                    let voucher = Voucher(BrandImage: brandName, BrandName: brandImage, Vouchertitle: voucherTitle, VoucherCode: voucherCode, voucherNum: voucherNum, voucherDes: voucherDes)
////                 self.userVouchers.append(voucher)
//                 //reloading the tableview
//                    self.trademarksTableView.reloadData()
//            }}
//        })
    }
    
}
    
    

