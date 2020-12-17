//
//  AllVouchersViewController.swift
//  MC Mazaya
//
//  Created by Alhanouf alabdullah on 23/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AllVouchersView : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var vouchers = [Voucher]()
    var vouchersTrademarks = [Trademark]()
    var trademarkIDs = [String]()
    var selectedVoucher : Voucher?
    var filteredVouchers = [Voucher]()
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getTradmearksIDs()
    }
    
    //MARK: - Table view Delegate and data source functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredVouchers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedVoucher = self.filteredVouchers[indexPath.row]
        let trademark = self.filteredVouchers[indexPath.row].trademark
        performSegue(withIdentifier: "toVoucherDetails", sender: trademark)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        let voucherTrademark = filteredVouchers[indexPath.row].trademark
        let trademarkName = voucherTrademark?.trademarkName
        let offerTitle = filteredVouchers[indexPath.row].offerTitle
        let trademarkImage = voucherTrademark?.imgURL
        cell.trademarkName.text = trademarkName
        cell.Des.text = offerTitle
        cell.trademarkImage.sd_setImage(with: URL(string: trademarkImage ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVoucherDetails" {
            let dis = segue.destination as! VoucherViewController
            dis.tradeInfo = sender as? Trademark
            dis.voucher = self.selectedVoucher
//           dis.tradOffers = self.vouchersList
//           dis.userVouchers = self.userVouchers
        } // Show Description Segue
    }
    
    
    // MARK: - Retreiving functions
    
    func getTradmearksIDs(){
        self.trademarkIDs = []
        let dealRef = Database.database().reference().child("Vouchers")
        dealRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let trademarkID = snap.childSnapshot(forPath: "trademarkID").value as! String
                self.trademarkIDs.append(trademarkID)
            }
            self.getVouchersTrademarks()
        })
    }
    
    
    func getVouchers(){
        self.vouchers = []
        let voucherRef = Database.database().reference().child("Vouchers")
        voucherRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let tradeID = snap.childSnapshot(forPath: "trademarkID").value as! String
                for trademark in self.vouchersTrademarks {
                    if trademark.trademarkID == tradeID {
                        let voucher = Voucher(snap: snap, trademark: trademark)
                        self.vouchers.append(voucher)
                    }
                }
            }
            self.filterVouchersBasedOnRegion()
            self.tableView.reloadData()
        })
    }
    
    
    func getVouchersTrademarks(){
        self.vouchersTrademarks = []
        for id in self.trademarkIDs {
            let trademarkRef = Database.database().reference().child("Trademarks").queryOrderedByKey().queryEqual(toValue: id)
            trademarkRef.observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let trademark = Trademark(snap: snap)
                    self.vouchersTrademarks.append(trademark)
                }
            })
        }
        self.getVouchers()
    }
    
    func filterVouchersBasedOnRegion(){
        filteredVouchers = []
        if userData.region == "الكل" {
            self.filteredVouchers = self.vouchers
        } else {
            for voucher in vouchers {
                let branches = voucher.branches!
                for branch in branches {
                    let region = branch.region
                    print("User region  \(userData.region)، \(region)")
                    if userData.region == region {
                        self.filteredVouchers.append(voucher)
                    }
                }
            }
        }
    } // End of filtering deals based on user region
    

}
