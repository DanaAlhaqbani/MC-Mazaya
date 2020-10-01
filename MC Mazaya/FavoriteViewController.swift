//
//  FavoriteViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, handleRetrievedData {
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
        var newOffersImage = [String]()
        var trademarks = ["باتشي","جوديفا","ماكدونالدز","هرفي"] //[String]()
        var trademarksImages = ["patchi","patchi","patchi","patchi"] //[String]()

        override func viewDidLoad() {
            super.viewDidLoad()
          
            print("============load categories in fav page==========")
            print(self.Categories)
        
            firstVC.deleagte = self
            getFavOffers()
            trademarksTableView.delegate = self
            trademarksTableView.dataSource = self
            // Make the table view looks good
            trademarksTableView.separatorStyle = .none
            trademarksTableView.showsVerticalScrollIndicator = false
             let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
            cell.trademarkImage.sendSubviewToBack(cell.trademarkView)

        }
        func getFavOffers(){
            for cat in self.Categories {
                let trades = cat.trademarks ?? []
                 for trad in trades {
                  let name = trad.BrandName ?? ""
                  let image = trad.brandImage ?? ""
                  let tradOffers = trad.offers ?? []
                    for offer in tradOffers {
                       // let isFavOffer = offer.isFav
                        let offerTilte = offer.offerTitle ?? ""
                        print("-----------outside if----------")
                       /* if isFavOffer == true {
                        print("-----------inside if---------")
                        newOffersNames.append(name)
                        newOffersImage.append(image)
                        newOffersTitles.append(offerTilte)
                        print("=============New offers names============")
                        print(newOffersNames)
                        print("=============New offers titles===========")
                        print(newOffersTitles)
                   
                    }
 */
                    
                }
                }
            }
             
        }
 
    }

    extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
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
            //let trademarkImage = trademarksImages[indexPath.row]
            cell.trademarkName.text = trademarkName
            cell.Des.text = offerTitle
            cell.trademarkImage.sd_setImage(with: URL(string: trademarkName ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
            //make the cell looks good
            cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 3
            cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
            cell.trademarkView.layer.borderWidth = 1.5
            cell.trademarkView.layer.borderColor = UIColor.gray.cgColor
            cell.trademarkImage.bringSubviewToFront(cell.trademarkView)

            //cell.trademarkImage.bringSubviewToFront(cell.trademarkView)

            return cell
        }
    /*
    @IBOutlet weak var trademarksTableView: UITableView!
    var trademarks = ["باتشي","جوديفا","ماكدونالدز","هرفي"] //[String]()
   var trademarksImages = ["patchi","patchi","patchi","patchi"] //[String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "مفضلتي"
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
         let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        cell.trademarkImage.sendSubviewToBack(cell.trademarkView)

    }
    


}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trademarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        let trademarkName = trademarks[indexPath.row]
        let trademarkImage = trademarksImages[indexPath.row]
        cell.trademarkName.text = trademarkName
        cell.trademarkImage.image = UIImage(named: trademarkImage)
        //make the cell looks good
        cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 3
        cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkView.layer.borderWidth = 1.5
        cell.trademarkView.layer.borderColor = UIColor.gray.cgColor
        cell.trademarkImage.bringSubviewToFront(cell.trademarkView)

        //cell.trademarkImage.bringSubviewToFront(cell.trademarkView)

        return cell
    }
    */
    
}
