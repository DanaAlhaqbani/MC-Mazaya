//
//  OffersView.swift
//  Segmented views
//
//  Created by Ajwan Alshaye on 19/02/1442 AH.



import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class VoucherView: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var UseAnoffer : UIButton!
    var voucher : Voucher?
    var userVouchers = [usedVoucher]()
    var ref: DatabaseReference?
    var Trade : Trademark!
    var userID = Auth.auth().currentUser?.uid
    var isUsedVoucher : Bool?
    var isValidUserPoints : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.nameLabel.text = voucher?.offerTitle
        cell.addressLabel.text = voucher?.offerDetails
        cell.servicetype.text = ("عدد النقاط" + ((voucher?.numberOfPoints)!))
        //action for selectedOffer
        //  cell.selectedOFfer.addTarget(self, action: #selector(OfferView.onClickedButton(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(self.vouchers[indexPath.row])
        //tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        for _ in 1...10{
            
            cell.selectedrow!.image = UIImage.init(named: "selected")
            //            voucherPoints = vouchers[indexPath.row].numberOfPoints
            //            voucherNum = vouchers[indexPath.row].offerNum ?? 0
            //            voucherTitle = vouchers[indexPath.row].offerTitle
            //            discountCode = vouchers[indexPath.row].DiscountCode
            //            voucherDes = vouchers[indexPath.row].offersDetails
            //            numOfCopons = vouchers[indexPath.row].numberOfCoupons
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
        
        if checkUsedVoucher() == false {
            if checkUserPoints() == true {
                // show a successful get voucher message
                
                self.showCustomAlertWith(message: "مبروك! حصلت قسيمة شرائية", descMsg: "", itemimage: nil, actions: nil)
                // Add the voucher to user vouchers list
                let voucher = [ "voucherTitle" : self.voucher?.offerTitle! ?? "" , "voucherCode" : self.voucher?.voucherCode! , "serviceType" : self.voucher?.serviceType! ?? "", "voucherID" : self.voucher?.voucherID! ?? "", "trademarkID" : self.voucher?.trademarkID ?? ""] as [String : Any]
                let ref = Database.database().reference().child("Users").child(userID!).child("MyVouchers")
                let key = self.voucher?.voucherID
                ref.child(key!).setValue(voucher)
                print("Success Add voucher to user vouchers list")
                // Decrease Vouchers number
//                let voucherNS = String(self.voucher.)
                var couponsNum = Int((self.voucher?.numberOfCoupons!)!)
                couponsNum! -= 1
                let updatedNumOfCopons = String(couponsNum!)
                let ref2 = Database.database().reference().child("Vouchers/\(self.voucher?.voucherID! ?? "")/NumberOfCoupons")
                ref2.setValue(updatedNumOfCopons)
                print(Trade.category!)
                print(Trade.trademarkID!)
//                print(voucherNS)
                print("Descreased copouns")
                // Decrease user points
                let voucherPInt = Int((self.voucher?.numberOfPoints!)!)!
                let updatedPoints = Int(userData.points)! - voucherPInt
                Database.database().reference().child("Users/\(userID!)/points").setValue("\(updatedPoints)")
            }
            else {
                let alert = self.alertContent( title: "عذراً لا يمكنك استبدال هذة القسيمة ", message:  "عدد نقاطك غير كافي للحصول على هذة القسيمة" )
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = self.alertContent( title: "عذراً لا يمكنك استبدال هذة القسيمة ", message:  "القسيمة الشرائية المختارة مستخدمة مسبقاً" )
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getUserVouchers(){
        let ref = Database.database().reference().child("Users/\(userID!)/MyVouchers")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let voucher = usedVoucher(snap: snap)
                self.userVouchers.append(voucher)
            }
        })
    }
    
    //check if the voucher is not already used by the user
    func checkUsedVoucher() -> Bool {
        let usedVouchers = userData.myVouchers
        for voucher in usedVouchers {
            print(voucher.voucherID!)
            let UvoucherNum = voucher.voucherID
            if UvoucherNum == self.voucher?.voucherID {
                self.isUsedVoucher = true
            }
            else{
                self.isUsedVoucher = false
            }
        }
        return isUsedVoucher ?? false
    }
    
    // check if the user points is greater than voucher points
    
    func checkUserPoints()-> Bool{
        let userPoints = Int(userData.points)!
//        userPN = Int(userPoints)
        let voucherPN = Int((self.voucher?.numberOfPoints!)!)
        if userPoints >= voucherPN! {
            isValidUserPoints = true
        }
        else {
            isValidUserPoints = false
        }
        return isValidUserPoints ?? false
    }
    @objc func onClickedButton(_ sender:Any?) {
        //  selectesButton.selectedOFfer.setImage(UIImage(named:"selected"), for:.normal)
    }
    
    
    func alertContent(title: String, message: String)-> UIAlertController{
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
}

