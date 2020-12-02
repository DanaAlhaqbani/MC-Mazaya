//
//  NewOffersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit


class NewOffersViewController: UIViewController, handleRetrievedData {
    func retrievedBanners(myData dataObject: [Banner]) {
        
    }
    
    func reloadTable() {
        trademarksTableView.reloadData()
    }
    
    func retrievedCategories(myData dataObject: [Category]) {
        self.Categories = dataObject
    }
    func retrievedcopyCategories(myData dataObject: [Category]) {
        self.Categories = dataObject
    }
    
    @IBOutlet weak var trademarksTableView: UITableView!
    var Categories = [Category]()
    var Trades = [Trademark]()
    let firstVC = launchViewController()
    var newOffersTitles = [String]()
    var newOffersNames = [String]()
    var newOffersImages = [String]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        firstVC.deleagte = self
        getNewOffers()
        trademarksTableView.dataSource = self
        trademarksTableView.delegate = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
         let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        cell.trademarkImage.sendSubviewToBack(cell.trademarkView)

    }
   
    func getNewOffers(){
        for cat in Categories {
            let trades = cat.trademarks ?? []
//             for trad in trades{
//              let name = trad.trademarkName ?? ""
//              let image = trad.imgURL ?? ""
//              let tradOffers = trad.offers ?? []
////                for offer in tradOffers {
////                    let offerDate = offer.s ?? ""
//////                let offerTilte = offer.offerTitle ?? ""
//////                 if self.isNewOffer(offerDate: offerDate){
//////                    newOffersNames.append(name)
//////                    newOffersImages.append(image)
//////                    newOffersTitles.append(offerTilte)
//////                }
////
////            }
//            }
        }
         
    }
    
    
    func isNewOffer(offerDate: String) -> Bool{
        let now = Date.getCurrentDate()
        let dateFormatter = DateFormatter()
        if offerDate != "" {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            guard let Startdate = dateFormatter.date(from: offerDate) else { return true }
            let nowDate =  dateFormatter.date(from: now)
            let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Startdate)
       
        //let start = Date().addingTimeInterval(2629743.83)
            if nowDate != nil && nextMonth != nil {
            if (nowDate! <= nextMonth!) {
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

        dateFormatter.dateFormat = "dd MMMM yyyy"

        return dateFormatter.string(from: Date())

    }
}
extension NewOffersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newOffersTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        let trademarkName = newOffersNames[indexPath.row]
        let offerTitle = newOffersTitles[indexPath.row]
        let trademarkImage = newOffersImages[indexPath.row]
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
    
        
    
    
}