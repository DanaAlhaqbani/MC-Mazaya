//
//  OffersView.swift
//  Segmented views
//
//  Created by Ajwan Alshaye on 19/02/1442 AH.



import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import MessageUI

class OfferView: UIViewController ,UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var UseAnoffer : UIButton!
    var Trades = [Trademark]()
    var offers = [Offer]()
    {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    var OffersTitles = [String]()
    var OffersNames = [String]()
    var ref: DatabaseReference?
    var Trade : Trademark!
    var selectedOffer: Offer?
    
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
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "trademarkCell") as! CustomTableViewCell
        cell.nameLabel.text = offers[indexPath.row].offerTitle
        cell.addressLabel.text = offers[indexPath.row].offersDetails
        cell.servicetype.text = ("نوع الخدمة:" + (offers[indexPath.row].serviceType!))
        //action for selectedOffer
        //  cell.selectedOFfer.addTarget(self, action: #selector(OfferView.onClickedButton(_:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        //        cell.isSelected = !cell.isSelected
        self.selectedOffer = offers[indexPath.row]
        cell.selectedrow!.image = UIImage.init(named: "selected")
        //        print(selectedOffer?.usageType)
        //        print()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        //        cell.isSelected = !cell.isSelected
        cell.selectedrow?.image = UIImage.init(named: "unselected")
        self.selectedOffer = nil
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    @IBAction func UseAnOffer(_ sender: Any) {
        let usageType = self.selectedOffer?.usageType
        if usageType == "إيميل" {
            let action : [String: () -> Void] = [ "إرسال بريد" : { (
                self.EmailAction()
            )}]
            self.showCustomAlertWith(message: "خطوات الحصول على العرض", descMsg: "قم بالضغط على الإيقونة في الاسفل لنقلك للبريد الإلكتروني", itemimage: UIImage(named: "email"), actions: [action])
        } else if usageType == "QR" {
            let actionYes : [String: () -> Void] = [ "امسح الرمز" : { (
                self.MoveTOScaner()
            )}]
            let actionNo : [String: () -> Void] = [ "" : { (
                print("tapped NO")
            ) }]
            let arrayActions = [actionYes, actionNo]
            //            self.showCustomAlertWithScaner(
            //                message: "قم بمسح العرض",
            //                descMsg: "لاستخدام العرض قم بالضغط على الإيقونة في الاسفل" ,
            //                itemimage: #imageLiteral(resourceName: "gift-card-2"),
            //                actions: arrayActions)
            self.showCustomAlertWith(message: "خطوات استخدام العرض", descMsg: "اذهب للمتجر، ثم امسح الرمز عند الدفع", itemimage: nil, actions: [actionYes])
        } else if usageType == "بطاقة العمل" {
            let action : [String: () -> Void] = [ "حسناً" : { (
                print("tapped YES")
            )}]
            self.showCustomAlertWith(message: "خطوات الحصول على العرض", descMsg: "للحصول على العرض قم بزيارة الفرع، وأبرز بطاقة العمل للموظف", itemimage: UIImage.init(named: ""), actions: [action])
        } else if usageType == "كود خصم" {
            let discountCode = self.selectedOffer?.discountCode! ?? ""
            let action : [String: () -> Void] = [ discountCode : { (
                UIPasteboard.general.string = discountCode
            )}]
            self.showCustomAlertWith(message: "خطوات الحصول على العرض", descMsg: "قم بزيارة الموقع الإلكتروني أو التطبيق، ثم ادخل رمز الخصم أدناه، أو قم بالضغط عليه لنسخه", itemimage: UIImage.init(named: ""), actions: [action])
        }
    }
    
    func toEmail() {
        
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
    
    func EmailAction() {
        // Modify following variables with your text / recipient
        let recipientEmail = "alhanoufkhalid.m@gmail.com"
        let subject = "طلب استخدام عرض من \(self.Trade.trademarkName!)"
        let offerTitle = self.selectedOffer?.offerTitle! ?? ""
        let body = """
السلام عليكم ورحمة الله وبركاته ..
  أرغب في طلب استخدام العرض : \(offerTitle)
من العلامة التجارية \(self.Trade.trademarkName!)
 بريد العمل الخاص بي : \(userData.email)
شكرًا ..
"""
        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            present(mail, animated: true)
            // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        return defaultUrl
    }
    
    
}

