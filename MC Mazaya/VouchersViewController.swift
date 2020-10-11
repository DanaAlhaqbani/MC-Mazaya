//
//  VouchersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

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
     var MyVouchersTitle = ["قسيمة بقيمة ٢٠٠ ", "قسيمة بقيمة ١٥٠"]
     var MyVouchersNames = ["حلويات سعد الدين", "باتشي"]
    var MyVouchersImages = ["patchi" , "images" ]


    // master array
    lazy var titlesToDisplay = AvaVouchersTitles
    lazy var namesToDisplay = AvaVouchersNames
    lazy var imagesToDisplay = AvaVouchersImage
     override func viewDidLoad() {
         super.viewDidLoad()
        print("============is there trades============")
        print(Trades)
        //trademarksTableView.reloadData()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        VoucherSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        VoucherSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        VoucherSC.font(name: "STC", size: 18)

        VoucherSC.selectedSegmentIndex = 1
        VoucherSC.addTarget(self, action: #selector(handleSCChange), for: .valueChanged)
         getVouchers()
         trademarksTableView.dataSource = self
        trademarksTableView.delegate = self
         // Make the table view looks good
         trademarksTableView.separatorStyle = .none
         trademarksTableView.showsVerticalScrollIndicator = false
          let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
         cell.trademarkImage.sendSubviewToBack(cell.trademarkView)

     }
    @objc fileprivate func handleSCChange(){
        print(VoucherSC.selectedSegmentIndex)
        switch VoucherSC.selectedSegmentIndex {
        case 1:
            namesToDisplay = AvaVouchersNames
            titlesToDisplay = AvaVouchersTitles
            imagesToDisplay = AvaVouchersImage
        case 0:
            namesToDisplay = MyVouchersNames
            titlesToDisplay = MyVouchersTitle
            imagesToDisplay = MyVouchersImages
           
        default:
            break
        }
        trademarksTableView.reloadData()
    }
     func getVouchers(){
         for cat in Categories {
             let trades = cat.trademarks ?? []
              for trad in trades{
             let name = trad.BrandName ?? ""
                 let image = trad.brandImage ?? ""
             let tradOffers = trad.offers ?? []
             
              for offer in tradOffers {
                 
                 if offer.offerType == "قسيمة" {
                     let offerTilte = offer.offerTitle ?? ""
                     AvaVouchersNames.append(name)
                     AvaVouchersImage.append(image)
                     AvaVouchersTitles.append(offerTilte)
                    vouchersTrade.append(trad)
                 }
                 
             }
             }
         }
       
          
     }



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
               let dis = segue.destination as! VoucherDetailsVC
               dis.tradeInfo = sender as? Trademark
               dis.Categories = self.Categories
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
        let trade = vouchersTrade[indexPath.row]
        performSegue(withIdentifier: "toVoucherDetails", sender: trade)
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
        cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 2
        cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkView.layer.borderWidth = 1.5
        cell.trademarkImage.layer.borderWidth = 1.5
        cell.trademarkView.layer.borderColor = UIColor.gray.cgColor
        cell.trademarkImage.layer.borderColor = UIColor.gray.cgColor
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
