//
//  BranchView.swift
//  MC Mazaya
//
//  Created by Ajwan Alshaye on 24/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class BranchView: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    var Categories = [Category]()
    var Trades = [Trademark]()
    var branches = [Branch]()
    {
        didSet {
            self.tableview.reloadData()
        }
    }
    var Trade : Trademark!
    //  var TradeBranch : Branch!
    
    var ref: DatabaseReference?
    //  var OffersTitles = [String]()
    //  var OffersNames = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.branches = Trade.branches ?? []
        tableview.delegate = self
        tableview.dataSource = self
        tableview.heightAnchor.constraint(equalToConstant: tableview.contentSize.height).isActive = true
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "trademarkCell") as! CustomTableViewCell
        cell.Bname.text = branches[indexPath.row].branchName
//        if  (Allbranch[indexPath.row].BrancheName == "")  && ( Allbranch[indexPath.row].DescriptionBranch == "")  && (Allbranch[indexPath.row].BranchLink == ""){
//            tableView.isHidden = true
//            ErrorLabel.text = " عذرا العرض فقط اون لاين "
//
//        }else{
//            cell.Bname.text = Allbranch[indexPath.row].BrancheName
//            cell.BDescriprion.text = Allbranch[indexPath.row].DescriptionBranch
//            cell.selectionStyle = .none
//        }
//
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        for _ in 1...10{
            
//            UIApplication.shared.open(URL(string: Allbranch[indexPath.row].BranchLink!)! as URL ,options: [:],completionHandler: nil)
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        //  let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
//        let urlString = Allbranch[indexPath.row].BranchLink
        
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableview.reloadData()
        
    }
    
}
