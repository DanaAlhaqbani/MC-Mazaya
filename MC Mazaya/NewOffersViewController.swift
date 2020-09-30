//
//  NewOffersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit


class NewOffersViewController: UIViewController, handleRetrievedData {
    func reloadTable() {
        trademarksTableView.reloadData()
    }
    
    func retrievedCategories(myData dataObject: [Category]) {
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
        print("==========Is passed Categories=========")
        print(Categories)
        getNewOffers()
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
         let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        cell.trademarkImage.sendSubviewToBack(cell.trademarkView)

    }
    
    func getNewOffers(){
        for cat in Categories {
            let trades = cat.trademarks ?? []
             for trad in trades{
              let name = trad.BrandName ?? ""
              let image = trad.brandImage ?? ""
              let tradOffers = trad.offers ?? []
                for offer in tradOffers {
                 let offerDate = offer.startDate ?? ""
                let offerTilte = offer.offerTitle ?? ""
                    print("==============Is there start date==============")
                    print(offerDate)
                 if self.isNewOffer(offerDate: offerDate){
                    print("===========inside if==========")
                    newOffersNames.append(name)
                    newOffersImages.append(image)
                    newOffersTitles.append(offerTilte)
                    print("=============New offers names============")
                    print(newOffersNames)
                    print("=============New offers titles===========")
                    print(newOffersTitles)
               
                }
                
            }
            }
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
