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
    var dealsTrademarks = [Trademark]()
    var selectedDeal : Deal?
    var trademarkIDs = [String]()
    var filteredDeals = [Deal]()
    //    var filteredBranches = [Branch]
    override func viewDidLoad() {
        super.viewDidLoad()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getTradmearksIDs()
    }
    
    
}

extension BigOffersViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDeals.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDeal = self.filteredDeals[indexPath.row]
        let trademark = filteredDeals[indexPath.row].trademark
        performSegue(withIdentifier: "toDeal", sender: trademark)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DealViewController, segue.identifier == "toDeal" {
            vc.tradeInfo = sender as? Trademark
            vc.deal = self.selectedDeal
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        if filteredDeals.count != 0 {
            let trademark = filteredDeals[indexPath.row].trademark
            let trademarkName = trademark?.trademarkName
            let trademarkImage = trademark?.imgURL ?? ""
            let offerTitle = filteredDeals[indexPath.row].offerTitle
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
        }
        return cell
    }
    
    func getTradmearksIDs(){
        self.trademarkIDs = []
        let dealRef = Database.database().reference().child("Deals")
        dealRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let trademarkID = snap.childSnapshot(forPath: "trademarkID").value as! String
                self.trademarkIDs.append(trademarkID)
            }
            self.getDealsTrademarks()
        })
    }
    
    
    func getDeals(){
        self.deals = []
        let dealRef = Database.database().reference().child("Deals")
        dealRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let tradeID = snap.childSnapshot(forPath: "trademarkID").value as! String
                for trademark in self.dealsTrademarks {
                    if trademark.trademarkID == tradeID {
                        let deal = Deal(snapshot: snap, trademark: trademark)
                        self.deals.append(deal)
                    }
                }
            }
            self.filterDealsBasedOnRegion()
            self.trademarksTableView.reloadData()
        })
    }
    
    
    func getDealsTrademarks(){
        self.dealsTrademarks = []
        for id in self.trademarkIDs {
            let trademarkRef = Database.database().reference().child("Trademarks").queryOrderedByKey().queryEqual(toValue: id)
            trademarkRef.observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let trademark = Trademark(snap: snap)
                    self.dealsTrademarks.append(trademark)
                }
            })
        }
        self.getDeals()
    }
    
    func filterDealsBasedOnRegion(){
        filteredDeals = []
        for deal in deals {
            if userData.region == "الكل" && deal.userType == "الكل" {
                self.filteredDeals.append(deal)
            } else if userData.region == "الكل" && userData.userType == deal.userType {
                self.filteredDeals.append(deal)
            } else {
                let branches = deal.branches!
                for branch in branches {
                    let region = branch.region
                    if userData.region == region && (deal.userType == userData.userType || deal.userType == "الكل") {
                        self.filteredDeals.append(deal)
                    }
                }
            }
        }
    } // End of filtering deals based on user region
    
}




