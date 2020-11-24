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
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17)], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "STC", size: 17)], for: .selected)
        BrandLogo.layer.borderColor = UIColor.systemGray6.cgColor
        BrandLogo.layer.borderWidth = 0.8
        BrandLogo.layer.shadowPath = UIBezierPath(rect: BrandLogo.bounds).cgPath
        BrandLogo.layer.shadowRadius = 5
        BrandLogo.layer.shadowOffset = .zero
        BrandLogo.layer.shadowOpacity = 1
        BrandLogo.layer.cornerRadius = BrandLogo.frame.height / 2
        upperline.addBorder(toSide: .bottom, withColor: UIColor.systemGray5.cgColor, andThickness: 1.0)
        line.addBorder(toSide: .bottom, withColor: UIColor.systemGray5.cgColor, andThickness: 1.0)
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
        VoucherSC.font(name: "STC", size: 18)
        VoucherSC.selectedSegmentIndex = 1
        VoucherSC.addTarget(self, action: #selector(handleSCChange), for: .valueChanged)
    }
    @objc fileprivate func handleSCChange(){
        print(VoucherSC.selectedSegmentIndex)
        switch VoucherSC.selectedSegmentIndex {
        case 1:
//            namesToDisplay = AvaVouchersNames
//            titlesToDisplay = AvaVouchersTitles
//            imagesToDisplay = AvaVouchersImage
            isMyVoucher = false
        case 0:
//            namesToDisplay = MyVouchersNames
//            titlesToDisplay = MyVouchersTitle
//            imagesToDisplay = MyVouchersImages
            isMyVoucher = true
           
        default:
            break
        }
        trademarksTableView.reloadData()
    }
    
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
    
    //MARK: - Retrieve all vouchers
    func getVouchers(){
        ref.child("Vouchers").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                // Create datasnapshot to use it for getting values
                let snap = child as! DataSnapshot
                // Create instance of each voucher
                let voucher = Voucher(offerTitle: snap.childSnapshot(forPath: "offerTitle").value as? String,
                                      offerDetails: snap.childSnapshot(forPath: "offerDetails").value as? String,
                                      voucherCode: snap.childSnapshot(forPath: "voucherCode").value as? String,
                                      numberOfCoupons: snap.childSnapshot(forPath: "numberOfCoupons").value as? String,
                                      numberOfPoints: snap.childSnapshot(forPath: "numberOfPoints").value as? String,
                                      serviceType: snap.childSnapshot(forPath: "serviceType").value as? String,
                                      startDate: snap.childSnapshot(forPath: "startDate").value as? String,
                                      endDate: snap.childSnapshot(forPath: "endDate").value as? String,
                                      trademarkID: snap.childSnapshot(forPath: "trademarkID").value as? String,
                                      branches: snap.childSnapshot(forPath: "branches").value as? [String])
                // Add voucher to vouchers array to display it in table view
                self.vouchers.append(voucher)
            } // End of iterate over all vouchers
            self.trademarksTableView.reloadData()
        }) // End of observation
    } // End of retrieve voucher function

    //MARK: - Get the trademark that offer the voucher
    func getVoucherTrademark(index: IndexPath){
        ref.child("Trademarks").queryOrderedByKey().queryEqual(toValue: self.vouchers[index.row].trademarkID).observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                // Assign value to the trademark variable
                self.voucherTrademark = Trademark(trademarkName: snap.childSnapshot(forPath: "trademarkName").value as? String,
                                          contactNum: snap.childSnapshot(forPath: "contactNum").value as? String,
                                          description: snap.childSnapshot(forPath: "description").value as? String,
                                          email: snap.childSnapshot(forPath: "email").value as? String,
                                          snapchat: snap.childSnapshot(forPath: "snapchat").value as? String,
                                          instagram: snap.childSnapshot(forPath: "instagram").value as? String,
                                          twitter: snap.childSnapshot(forPath: "twitter").value as? String,
                                          website: snap.childSnapshot(forPath: "website").value as? String,
                                          imgURL: snap.childSnapshot(forPath: "imgURL").value as? String,
                                          backgroundImg: snap.childSnapshot(forPath: "backgroundImg").value as? String,
                                          branches: [], offers: [], views: 0,
                                          isFeatured: snap.childSnapshot(forPath: "isFeatured").value as? Bool ,
                                          category: snap.childSnapshot(forPath: "category").value as? String,
                                          trademarkID: snap.key,
                                          serviceType: snap.childSnapshot(forPath: "serviceType").value as? String)
            } // End of iterate over trademarks
            self.trademarksTableView.reloadData()
        }) // End of observation
    } // End of getting voucher's trademark function
    
}

extension VouchersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vouchers.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isMyVoucher == true {
//        self.showCustomAlertWith(message: "مبروك! حصلت قسيمة شرائية نرجوا إبراز هذة الصورة عند المحل للحصول عليها", descMsg: "للحصول على هذة القسيمة إذهب الى المحل وقم بإبراز هذة الصورة", itemimage: nil, actions: nil)
//            self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "voucherAlert") as! usedVoucher
            self.present(nextViewController, animated:true, completion:nil)
            nextViewController.modalPresentationStyle = .popover
        }
        else {
//        let trade = vouchersTrade[indexPath.row]
        performSegue(withIdentifier: "toVoucherDetails", sender: voucherTrademark)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        getVoucherTrademark(index: indexPath)
        let trademarkName = voucherTrademark.trademarkName
        let offerTitle = vouchers[indexPath.row].offerTitle
        let trademarkImage = voucherTrademark.imgURL
        cell.trademarkName.text = trademarkName
        cell.Des.text = offerTitle
        cell.trademarkImage.sd_setImage(with: URL(string: trademarkImage ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
        //make the cell looks good
        cell.trademarkView.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkImage.layer.borderWidth = 0.8
        cell.trademarkImage.layer.borderColor = UIColor.systemGray3.cgColor
        cell.trademarkView.backgroundColor = UIColor(rgb: 0xF4F4F4)
        cell.trademarkView.layer.shadowColor = UIColor.systemGray5.cgColor
        cell.trademarkView.layer.shadowRadius = 2
        cell.trademarkView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.trademarkView.layer.shadowOpacity = 0.5
        cell.trademarkView.clipsToBounds = false
        cell.trademarkImage.bringSubviewToFront(cell.trademarkView)
        //cell.trademarkImage.bringSubviewToFront(cell.trademarkView)
        return cell
    }
    
}
extension UISegmentedControl {
    func font(name:String?, size:CGFloat?) {
        let attributedSegmentFont = NSDictionary(object: UIFont(name: name!, size: size!)!, forKey: NSAttributedString.Key.font as NSCopying)
        setTitleTextAttributes(attributedSegmentFont as [NSObject : AnyObject] as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], for: .normal)
    }
}
