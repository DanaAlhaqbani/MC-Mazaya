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

class BigOffersViewController: UIViewController, handleRetrievedData{
    func retrievedcopyCategories(myData dataObject: [Category]) {
        
    }
    
    func reloadTable() {
        trademarksTableView.reloadData()
    }
    
    func retrievedCategories(myData dataObject: [Category]) {
        self.Categories = dataObject
    }
    
    var Categories = [Category]()
      var Trades = [Trademark]()
    var BigOffersTitles = [String]()
    var BigOffersNames = [String]()
    var BigOffersImage = [String]()
    var ref: DatabaseReference?
    let firstVC = launchViewController()
    // for trademarks images
    var sectionsImages : [[String: Any]] = []
    
    @IBOutlet weak var trademarksTableView: UITableView!
    var trademarks = ["باتشي","جوديفا","ماكدونالدز","هرفي"] //[String]()
   var trademarksImages = ["patchi","patchi","patchi","patchi"] //[String]()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        getBigOffers()
        firstVC.deleagte = self
       // retrieveTrades()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
         let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        cell.trademarkImage.sendSubviewToBack(cell.trademarkView)

    }

           
    func getBigOffers(){
        for cat in Categories {
            let trades = cat.trademarks ?? []
             for trad in trades{
            let name = trad.BrandName ?? ""
                let image = trad.brandImage ?? ""
            let tradOffers = trad.offers ?? []
            
             for offer in tradOffers {
                
                if offer.offerType == "صفقة" {
                    let offerTilte = offer.offerTitle ?? ""
                    BigOffersNames.append(name)
                    BigOffersImage.append(image)
                    BigOffersTitles.append(offerTilte)
                    
               
                }
                
            }
            }
        }
      
         
    }


}

extension BigOffersViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BigOffersNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        let trademarkName = BigOffersNames[indexPath.row]
        let offerTitle = BigOffersTitles[indexPath.row]
        let offerImage = BigOffersImage[indexPath.row]
        //let trademarkImage = trademarksImages[indexPath.row]
         cell.trademarkName.text = trademarkName
         cell.Des.text = offerTitle
         cell.trademarkImage.sd_setImage(with: URL(string: offerImage ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
        //cell.trademarkImage.image = UIImage(named: trademarkImage)
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
    



