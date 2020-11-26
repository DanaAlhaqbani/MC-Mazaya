//
//  DealView.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 10/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DealView: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableview: UITableView!
    var deal : Deal?
    @IBOutlet var UseAnoffer : UIButton!
    var ref: DatabaseReference?
    var Trade : Trademark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //      self.offers = Trade.offers ?? []
        tableview.delegate = self
        tableview.dataSource = self
        tableview.heightAnchor.constraint(equalToConstant: tableview.contentSize.height).isActive = true
        UseAnoffer.setButton()
        UseAnoffer.titleLabel?.font =  UIFont(name: "stc_font_regular", size: 17.0)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "trademarkCell") as! CustomTableViewCell
        cell.nameLabel.text = deal?.offerTitle
        cell.addressLabel.text = deal?.offersDetails
        cell.servicetype.text = ("نوع الخدمة:" + (deal?.serviceType ?? ""))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        for _ in 1...10{
            
            cell.selectedrow!.image = UIImage.init(named: "selected")
            
            
        }
        //        if indexPath.row == 0{
        //                   cell.selectedrow!.image = UIImage.init(named: "selected")
        //               }
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        for _ in 1...10{
            cell.selectedrow!.image = UIImage.init(named: "unselected")
        }
        
        //    if indexPath.row == 0{
        //    cell.selectedrow!.image = UIImage.init(named: "unselected")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    
    @IBAction func UseAnOffer(_ sender: Any) {
        print("Tapped")
    }
    
    
    @objc func onClickedButton(_ sender:Any?) {
    }
    
    func AlertBox (){
    }
    
    @IBAction func alertButtonAction(_ sender: Any) {
        let actionYes : [String: () -> Void] = [ "" : { (
            self.MoveTOScaner(),
            print("tapped YES")
        )}]
        let actionNo : [String: () -> Void] = [ "" : { (
            print("tapped NO")
        ) }]
        let arrayActions = [actionYes, actionNo]
        self.showCustomAlertWithScaner(
            message: "",
            descMsg: "" ,
            itemimage: #imageLiteral(resourceName: "qr-code"),
            actions: arrayActions)
    }

    func MoveTOScaner(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
        nextViewController.modalPresentationStyle = .popover
    }
}

