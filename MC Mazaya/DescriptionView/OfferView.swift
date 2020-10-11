//
//  OffersView.swift
//  Segmented views
//
//  Created by Ajwan Alshaye on 19/02/1442 AH.



import UIKit
import Firebase

class OfferView: UIViewController ,UITableViewDelegate, UITableViewDataSource{
   

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
        self.offers = Trade.offers ?? []
        tableview.delegate = self
        tableview.dataSource = self
        tableview.heightAnchor.constraint(equalToConstant: tableview.contentSize.height).isActive = true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "trademarkCell") as! CustomTableViewCell
        cell.nameLabel.text = offers[indexPath.row].offerTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 105
       }
       override func viewDidAppear(_ animated: Bool) {
        
           tableview.reloadData()
           
       }


}
