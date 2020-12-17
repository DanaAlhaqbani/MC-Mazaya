//
//  BranchView.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 10/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DealBranchView : UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ErrorLabel: UILabel!
    var Categories = [Category]()
    var Trades = [Trademark]()
    var branches = [Branch]()
    {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    var Trade : Trademark!
    var ref: DatabaseReference?
    
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
        cell.BDescriprion.text = branches[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
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
