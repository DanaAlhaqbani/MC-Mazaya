//
//  BigOffersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 25/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseAuth
import FirebaseDatabase

class BigOffersViewController: UIViewController {

    

    var ref = Database.database().reference()
    @IBOutlet weak var trademarksTableView: UITableView!
    var deals = [Deal]()
    var dealsTrademark = Trademark()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeals()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
        
    }


}

extension BigOffersViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        getDealsTrademarks(index: indexPath)
        performSegue(withIdentifier: "toDes", sender: dealsTrademark)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let vc = segue.destination as? detailsViewController, segue.identifier == "toDes" {
         vc.tradeInfo = sender as? Trademark
      }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        getDealsTrademarks(index: indexPath)
//        let trademark = deals[indexPath.row].trademark
        let trademarkName = dealsTrademark.trademarkName
        let trademarkImage = dealsTrademark.imgURL ?? ""

        let offerTitle = deals[indexPath.row].offerTitle
        cell.trademarkName.text = trademarkName
        cell.Des.text = offerTitle
        cell.trademarkImage.sd_setImage(with: URL(string: trademarkImage))
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
        cell.trademarkImage.bringSubviewToFront(cell.trademarkView)
        return cell
    }
   
    func getDeals(){
        ref.child("Deals").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let deal = Deal(discountCode: snap.childSnapshot(forPath: "discountCode").value as? String,
                                offersDetails: snap.childSnapshot(forPath: "offerDetails").value as? String,
                                offerTitle: snap.childSnapshot(forPath: "offerTitle").value as? String,
                                serviceType: snap.childSnapshot(forPath: "serviceType").value as? String,
                                endDate: snap.childSnapshot(forPath: "endDate").value as? String,
                                startDate: snap.childSnapshot(forPath: "startDate").value as? String,
                                trademarkID: snap.childSnapshot(forPath: "trademarkID").value as? String,
                                userType: snap.childSnapshot(forPath: "userType").value as? String,
                                usageType: snap.childSnapshot(forPath: "usageType").value as? String,
                                branches: snap.childSnapshot(forPath: "branches").value as? [String])
                self.deals.append(deal)
            }
            self.trademarksTableView.reloadData()
        })
    }
    
    func getDealsTrademarks(index: IndexPath){
        ref.child("Trademarks").queryOrderedByKey().queryEqual(toValue: deals[index.row].trademarkID).observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                self.dealsTrademark = Trademark(trademarkName: snap.childSnapshot(forPath: "trademarkName").value as? String,
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
            }
            self.trademarksTableView.reloadData()
        })
    }
    
        
    }
    



