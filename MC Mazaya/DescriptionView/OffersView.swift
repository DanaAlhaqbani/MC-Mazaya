//
//  OffersView.swift
//  Segmented views
//
//  Created by Ajwan Alshaye on 19/02/1442 AH.



import UIKit
import Firebase

class OffersView: UIViewController ,UITableViewDelegate, UITableViewDataSource{
   

    @IBOutlet weak var tableview: UITableView!
    var Categories = [Category]()
    var Trades = [Trademark]()
    var offers = [Offer]()
    var OffersTitles = [String]()
    var OffersNames = [String]()
    var ref: DatabaseReference?
    var Trade : Trademark!
    

     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("============in offers view============")
        print(Trade.offers)
       // getOffers()
        tableview.delegate = self
        tableview.dataSource = self
        
  
        
         //tableview.estimatedRowHeight = 68.0
        tableview.heightAnchor.constraint(equalToConstant: tableview.contentSize.height).isActive = true
        
    }
    
    
    func getOffers(){
           for cat in Categories {
               let trades = cat.trademarks ?? []
                for trad in trades{
               let name = trad.BrandName ?? ""
                   let image = trad.brandImage ?? ""
               let tradOffers = trad.offers ?? []
               
                for offer in tradOffers {
                    
                       let offerTilte = offer.offerTitle ?? ""
                       OffersNames.append(name)
                      // OffersImage.append(image)
                       OffersTitles.append(offerTilte)
                       
                  
                   }
                   
               }
               }
           }
         
            
       
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "trademarkCell") as! CustomTableViewCell
               let trademarkName = OffersNames[indexPath.row]
               let offerTitle = OffersTitles[indexPath.row]
           //    let offerImage = BigOffersImage[indexPath.row]
             
        cell.nameLabel.text = offers[indexPath.row].offerTitle
        print(offers[indexPath.row])
                cell.addressLabel.text = offerTitle
           return cell
                 
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 105
       }
       override func viewDidAppear(_ animated: Bool) {
        
           tableview.reloadData()
           
       }


}
