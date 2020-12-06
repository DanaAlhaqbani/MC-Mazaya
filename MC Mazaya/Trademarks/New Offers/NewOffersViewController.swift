//
//  NewOffersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewOffersViewController: UIViewController {
    
    @IBOutlet weak var trademarksTableView: UITableView!
    var Trades = [Trademark]()
    var offers = [Offer]()
    var trademarkIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTrademearksIDs()
        trademarksTableView.dataSource = self
        trademarksTableView.delegate = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
        //        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        //        cell.trademarkImage.sendSubviewToBack(cell.trademarkView)
    }
    
    
    
    func isNewOffer(offerDate: String) -> Bool{
        let now = Date.getCurrentDate()
        let dateFormatter = DateFormatter()
        if offerDate != "" {
            dateFormatter.dateFormat = "MMM d, yyyy"
            guard let Startdate = dateFormatter.date(from: offerDate) else { return true }
            let nowDate =  dateFormatter.date(from: now)
            let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Startdate)
            //let start = Date().addingTimeInterval(2629743.83)
            //            let results
            if nowDate != nil && nextMonth != nil {
                if (nowDate! <= nextMonth!) {
                    print(Startdate)
                    return true
                }
            }
        }
        return false
    }
    
    
    
}


extension Date {
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: Date())
    }
}


extension NewOffersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        //        self.getTrademark(index: indexPath)
        let trademark = offers[indexPath.row].trademark
        let trademarkName = trademark?.trademarkName
        let offerTitle = offers[indexPath.row].offerTitle
        let trademarkImage = trademark?.imgURL ?? ""
        cell.trademarkName.text = trademarkName
        cell.Des.text = offerTitle
        cell.trademarkImage.sd_setImage(with: URL(string: trademarkImage ))
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
    
    func getTrademearksIDs(){
        self.trademarkIDs = []
        let dealRef = Database.database().reference().child("Offers")
        dealRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let trademarkID = snap.childSnapshot(forPath: "trademarkID").value as! String
                self.trademarkIDs.append(trademarkID)
            }
            self.getTrademarks()
        })
    }
    
    
    func getNewOffers(){
        self.offers = []
        let dealRef = Database.database().reference().child("Offers")
        dealRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let tradeID = snap.childSnapshot(forPath: "trademarkID").value as! String
                let offerDate = snap.childSnapshot(forPath: "startDate").value as! String
                for trademark in self.Trades {
                    if trademark.trademarkID == tradeID {
                        if self.isNewOffer(offerDate: offerDate) {
                            let offer = Offer(snap: snap, trademark: trademark)
                            self.offers.append(offer)
                        }
                    }
                }
            }
            self.trademarksTableView.reloadData()
        })
    }
    
    
    func getTrademarks(){
        self.Trades = []
        for id in self.trademarkIDs {
            let trademarkRef = Database.database().reference().child("Trademarks").queryOrderedByKey().queryEqual(toValue: id)
            trademarkRef.observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let trademark = Trademark(snap: snap)
                    self.Trades.append(trademark)
                }
            })
        }
        self.getNewOffers()
    }
    
    
    
    
}
