//
//  BranchView.swift
//  MC Mazaya
//
//  Created by Ajwan Alshaye on 24/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
class BranchView: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
@IBOutlet weak var tableview: UITableView!
    
    
    var Categories = [Category]()
       var Trades = [Trademark]()
       var Allbranch = [Branch]()
     var Trade : Trademark!
     //  var TradeBranch : Branch!
    
    var ref: DatabaseReference?
     //  var OffersTitles = [String]()
     //  var OffersNames = [String]()
       
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Allbranch = Trade.branches ?? []
        tableview.delegate = self
        tableview.dataSource = self
        tableview.heightAnchor.constraint(equalToConstant: tableview.contentSize.height).isActive = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Allbranch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableview.dequeueReusableCell(withIdentifier: "trademarkCell") as! CustomTableViewCell
        
        cell.Bname.text = Allbranch[indexPath.row].BrancheName
        
        cell.BDescriprion.text = Allbranch[indexPath.row].DescriptionBranch
      
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    

    override func viewDidAppear(_ animated: Bool) {
     
        tableview.reloadData()
        
    }

}
