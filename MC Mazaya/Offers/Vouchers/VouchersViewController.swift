//
//  VouchersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class VouchersViewController: UIViewController {

     @IBOutlet weak var trademarksTableView: UITableView!
    
    @IBOutlet weak var VoucherSC: UISegmentedControl!
    var vouchersTrade = [Trademark]()
     var Categories = [Category]()
     var Trades = [Trademark]()
     let firstVC = launchViewController()
    var VouchersTrade = [Trademark]()
     var AvaVouchersTitles = [String]()
     var AvaVouchersNames = [String]()
     var AvaVouchersImage = [String]()
     var MyVouchersTitle = [String]()
     var MyVouchersNames = [String]()
    var MyVouchersImages = [String]()
    var isMyVoucher = false
    var vouchersList = [Offer]()
    var userVouchers = [Voucher]()
        var userVouchersKey = [String]()
        var voucherRef: DatabaseReference!
        let userID = Auth.auth().currentUser?.uid
    // master array
    lazy var titlesToDisplay = AvaVouchersTitles
    lazy var namesToDisplay = AvaVouchersNames
    lazy var imagesToDisplay = AvaVouchersImage
     override func viewDidLoad() {
         super.viewDidLoad()
        trademarksTableView.separatorStyle = .none

        print("============is there trades============")
        print(Trades)
        //trademarksTableView.reloadData()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        VoucherSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        VoucherSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        VoucherSC.font(name: "STC", size: 18)

        VoucherSC.selectedSegmentIndex = 1
        VoucherSC.addTarget(self, action: #selector(handleSCChange), for: .valueChanged)
//         getVouchers()
         trademarksTableView.dataSource = self
        trademarksTableView.delegate = self
         // Make the table view looks good
         trademarksTableView.separatorStyle = .none
         trademarksTableView.showsVerticalScrollIndicator = false
          let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
         cell.trademarkImage.sendSubviewToBack(cell.trademarkView)
      getUserVoucher()
     }
    func getUserVoucher(){
         // Do any additional setup after loading the view.
        voucherRef = Database.database().reference().child("Users").child(userID!).child("VoucherList");
         voucherRef.observe(DataEventType.value, with: { (snapshot) in
             //if the reference have some values
             if snapshot.childrenCount > 0 {
                 //clearing the list
                 self.userVouchers.removeAll()
                 
                 //iterating through all the values
                 for voucher in snapshot.children.allObjects as! [DataSnapshot] {
                     //getting values
                     let voucherObject = voucher.value as? [String: AnyObject]
                     let brandName = voucherObject?["BrandName"] as? String
                     let brandImage = voucherObject?["BrandImage"] as? String
                    let voucherTitle = voucherObject?["VoucherTitle"] as? String
                    let voucherCode = voucherObject?["VoucherCode"] as? String
                    let voucherNum = voucherObject?["voucherNum"] as? Int
                    let voucherDes =  voucherObject?["VoucherDes"] as? String
                    self.MyVouchersTitle.append(voucherTitle ?? "")
                    self.MyVouchersNames.append(brandName ?? "")
                    self.MyVouchersImages.append(brandImage ?? "")
                    
                     let voucherKey = voucher.key
                     self.userVouchersKey.append(voucherKey)
                     
                     //creating artist object with model and fetched values
//                    let voucher = Voucher(BrandImage: brandName, BrandName: brandImage, Vouchertitle: voucherTitle, VoucherCode: voucherCode, voucherNum: voucherNum, voucherDes: voucherDes)
//                 self.userVouchers.append(voucher)
                 //reloading the tableview
                 self.trademarksTableView.reloadData()
                }}
         })
        }
    @objc fileprivate func handleSCChange(){
        print(VoucherSC.selectedSegmentIndex)
        switch VoucherSC.selectedSegmentIndex {
        case 1:
            namesToDisplay = AvaVouchersNames
            titlesToDisplay = AvaVouchersTitles
            imagesToDisplay = AvaVouchersImage
            isMyVoucher = false
        case 0:
            namesToDisplay = MyVouchersNames
            titlesToDisplay = MyVouchersTitle
            imagesToDisplay = MyVouchersImages
            isMyVoucher = true
           
        default:
            break
        }
        trademarksTableView.reloadData()
    }
//     func getVouchers(){
//         for cat in Categories {
//             let trades = cat.trademarks ?? []
//              for trad in trades{
//             let name = trad.trademarkName ?? ""
//                 let image = trad.imgURL ?? ""
//             let tradOffers = trad.offers ?? []
//
////              for offer in tradOffers {
////
////                 if offer.offerType == "قسيمة" {
////                     let offerTilte = offer.offerTitle ?? ""
////                     AvaVouchersNames.append(name)
////                     AvaVouchersImage.append(image)
////                     AvaVouchersTitles.append(offerTilte)
////                    vouchersTrade.append(trad)
////                    vouchersList.append(offer)
////                 }
////
////             }
//             }
//         }
//
//     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toVoucherDetails" {
               let dis = segue.destination as! VoucherDetails
               dis.tradeInfo = sender as? Trademark
            dis.tradOffers = self.vouchersList
            dis.userVouchers = self.userVouchers
           } // Show Description Segue
    }
}
extension VouchersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesToDisplay.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isMyVoucher == true {
//        self.showCustomAlertWith(message: "مبروك! حصلت قسيمة شرائية نرجوا إبراز هذة الصورة عند المحل للحصول عليها", descMsg: "للحصول على هذة القسيمة إذهب الى المحل وقم بإبراز هذة الصورة", itemimage: nil, actions: nil)
//            self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "voucherAlert") as! singleVoucher
            self.present(nextViewController, animated:true, completion:nil)
            nextViewController.modalPresentationStyle = .popover
        }
        else {
        let trade = vouchersTrade[indexPath.row]
        performSegue(withIdentifier: "toVoucherDetails", sender: trade)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        let trademarkName = namesToDisplay[indexPath.row]
        let offerTitle = titlesToDisplay[indexPath.row]
        let trademarkImage = imagesToDisplay[indexPath.row]
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
