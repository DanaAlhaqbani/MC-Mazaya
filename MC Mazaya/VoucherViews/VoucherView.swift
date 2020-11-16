//
//  OffersView.swift
//  Segmented views
//
//  Created by Ajwan Alshaye on 19/02/1442 AH.



import UIKit
import Firebase

class VoucherView: UIViewController ,UITableViewDelegate, UITableViewDataSource{
   

    @IBOutlet weak var tableview: UITableView!
    
    
    @IBOutlet var UseAnoffer : UIButton!
    
    var voucherRef: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
    var Categories = [Category]()
    var Trades = [Trademark]()
    var offers = [Offer]()
    var vouchers = [Offer]()
    var UserVoucher = [Voucher]()
    var OffersTitles = [String]()
    var OffersNames = [String]()
    var ref: DatabaseReference?
    var Trade : Trademark!
    
    var voucherPoints : String?
    var voucherTitle : String?
    var discountCode : String?
    var voucherDes : String?
    var userPN : Int?
    var voucherNum = 0
    var isUsedVoucher = false
    var isValidUserPoints = false
    var numOfCopons : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("============user Vouchers==============")
        print(UserVoucher)
      self.offers = Trade.offers ?? []
        tableview.delegate = self
        tableview.dataSource = self
        tableview.heightAnchor.constraint(equalToConstant: tableview.contentSize.height).isActive = true
        UseAnoffer.setButton()
        UseAnoffer.titleLabel?.font =  UIFont(name: "stc_font_regular", size: 17.0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vouchers.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableview.dequeueReusableCell(withIdentifier: "trademarkCell") as! CustomTableViewCell
        cell.nameLabel.text = vouchers[indexPath.row].offerTitle
        cell.addressLabel.text = vouchers[indexPath.row].offersDetails
        cell.servicetype.text = ("نوع الخدمة:" + (vouchers[indexPath.row].serviceType!))
          
        
        
        //action for selectedOffer
     //  cell.selectedOFfer.addTarget(self, action: #selector(OfferView.onClickedButton(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 105
       }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.vouchers[indexPath.row])
        //tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        
        for _ in 1...10{
            
            cell.selectedrow!.image = UIImage.init(named: "selected")
            voucherPoints = vouchers[indexPath.row].numberOfPoints
            voucherNum = vouchers[indexPath.row].offerNum ?? 0
            voucherTitle = vouchers[indexPath.row].offerTitle
            discountCode = vouchers[indexPath.row].DiscountCode
            voucherDes = vouchers[indexPath.row].offersDetails
            numOfCopons = vouchers[indexPath.row].numberOfCoupons
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
                let voucher = ["BrandName" : Trade.BrandName , "BrandImage": Trade.brandImage, "VoucherTitle" : voucherTitle , "VoucherCode" : discountCode , "VoucherDes" : voucherDes, "voucherNum" : voucherNum] as [String : Any]
                                     let ref = Database.database().reference().child("Users").child(userID!).child("VoucherList")
                                     let key = ref.childByAutoId().key
                                     ref.child(key!).setValue(voucher)
                                     print("Success Add voucher to user vouchers list")
                // Decrease Vouchers number
                let voucherNS = String(voucherNum)
                var couponsNum = Int(numOfCopons!)
                couponsNum = couponsNum! - 1
                let updatedNumOfCopons = String(couponsNum!)
                print(updatedNumOfCopons)
                let ref2 = Database.database().reference().child("Categories").child(Trade.catID!).child("TradeMarks").child(Trade.tradID!).child("Offers")
                ref2.child(String(voucherNum)).updateChildValues(["NumberOfCoupons" : updatedNumOfCopons])
                print(Trade.catID!)
                print(Trade.tradID!)
                print(voucherNS)
                print("Descreased copouns")
                // Decrease user points
                let voucherPInt = Int(voucherPoints!)!
                let updatedPoints = userPN! - voucherPInt
            
                Database.database().reference().child("Users").child(userID!).updateChildValues(["Points" : "\(updatedPoints)"])

        }
        else {
                
            let alert = self.alertContent( title: "عذراً لا يمكنك استبدال هذة القسيمة ", message:  "عدد نقاطك غير كافي للحصول على هذة القسيمة" )
            self.present(alert, animated: true, completion: nil)
        }
        } else{
            let alert = self.alertContent( title: "عذراً لا يمكنك استبدال هذة القسيمة ", message:  "القسيمة الشرائية المختارة مستخدمة مسبقاً" )
                      self.present(alert, animated: true, completion: nil)
            print("++++++++++USED VOUCHER+++++++++++")
        }
      
    }
    
    //check if the voucher is not already used by the user
    func checkUsedVoucher() -> Bool {
        for voucher in self.UserVoucher {
                let UvoucherNum = voucher.voucherNum
                if UvoucherNum == self.voucherNum {
                     self.isUsedVoucher = true
            }
                else{
                    
                    self.isUsedVoucher = false

            }
            
            }
        return isUsedVoucher
    }
    
    // check if the user points is greater than voucher points

    func checkUserPoints()-> Bool{
        let userPoints = userData.points
         userPN = Int(userPoints)
              let voucherPN = Int(voucherPoints!)
              print("==============points============")
              if userPN! >= voucherPN! {
                  isValidUserPoints = true
              }
              else {
                isValidUserPoints = false
        }
        return isValidUserPoints
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

