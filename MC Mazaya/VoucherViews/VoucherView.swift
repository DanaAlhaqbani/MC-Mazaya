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
    
    
    
    var Categories = [Category]()
    var Trades = [Trademark]()
    var offers = [Offer]()
    var vouchers = [Offer]()
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

      //  selectesButton.selectedOFfer.setImage(UIImage(named:"selected"), for:.normal)

      
    }
    
    func AlertBox (){
        
    }
    @IBAction func alertButtonAction(_ sender: Any) {
          // let btn = sender as! UIButton
           
          
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

