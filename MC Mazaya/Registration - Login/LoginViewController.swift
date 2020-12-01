//
//  LoginViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 01/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import IQKeyboardManagerSwift
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var containerView: UIView!
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var userData : userData?
    @IBOutlet weak var showSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
//        emailTextField.backgroundUnderlined()
//               passwordTextField.backgroundUnderlined()
//               loginBtn.setButton()
//        emailTextField.addDoneButtonOnKeyboard()
//        passwordTextField.addDoneButtonOnKeyboard()
        view.setGradientBackground(colorOne: UIColor(rgb: 0x26998a), colorTwo: UIColor(rgb: 0x268985))
//        loginBtn.setGradientBackground(colorOne: UIColor(rgb: 0x26998a), colorTwo: UIColor(rgb: 0x268985))
//        emailTextField.layer.cornerRadius = 10
//        passwordTextField.layer.cornerRadius = 10
//        emailTextField.layer.borderWidth = 0.5
//        passwordTextField.layer.borderWidth = 0.5
//        emailTextField.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
//        passwordTextField.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
//        passwordTextField.
        loginBtn.backgroundColor = UIColor(rgb: 0x26998a)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        topView.backgroundColor = .clear
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true

        emailTextField.label.text = "البريد الإلكتروني"
        emailTextField.placeholder = "مثال mazaya@mci.gov.sa"
        emailTextField.layer.borderColor = UIColor(rgb: 0x26998a).cgColor
        emailTextField.label.tintColor = UIColor(rgb: 0x26998a)
        passwordTextField.label.text = "كلمة المرور"
        passwordTextField.placeholder = ""
        passwordTextField.tintColor = UIColor(rgb: 0x26998a)
        emailTextField.setOutlineColor(UIColor(rgb: 0x26998a), for: .normal)
        passwordTextField.setOutlineColor(UIColor(rgb: 0x26998a), for: .normal)
        emailTextField.setOutlineColor(UIColor(rgb: 0x26998a), for: .editing)
        passwordTextField.setOutlineColor(UIColor(rgb: 0x26998a), for: .editing)
//        topView.setGradientBackground(colorOne: UIColor(rgb: 0x26998a), colorTwo: UIColor(rgb: 0x268985))
        let emailImage = UIImageView(image: UIImage(named: "Email"))
        let passImage = UIImageView(image: UIImage(named: "Password"))
        emailTextField.trailingView?.addSubview(emailImage)
        passwordTextField.trailingView?.addSubview(passImage)
        emailTextField.containerRadius = 10
        
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
           self.validateData(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func validateData(email:String, password:String) {
        
        if email != "" {
            if password != "" {
                self.showSpinner()
                login(email: email, password: password)
            } else { // empty password
               let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  " من فضلِك ادخل كلمة مرور")
                self.present(alert, animated: true, completion: nil)

    
            } // end empty password
        } else if email.isEmpty && password.isEmpty { // empty email
            let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message: "من فضلك ادخل بياناتك")
            self.present(alert, animated: true, completion: nil)

           
        } else {
             let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  " من فضلِك ادخل بريدك الالكتروني")
            self.present(alert, animated: true, completion: nil)

        }
    }

    
    func login(email:String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password , completion: { (user, error) in
        
            if user != nil{
 
                // Check if email is verified
                    let user = user?.user
                    if user!.isEmailVerified {
                        print("success")
                        self.successful()
//                        self.userData = user
                    } else {
                        // email is not verified
                        print("email is not verified")
                        self.removeSpinner()
                        let alert = self.alertContent(title:  "لم تقم بتفعيل حسابك", message: "من فضلِك فعل الحساب عن طريق الرسالة المرسلة الى بريدك الالكتروني")
                       self.present(alert, animated: true, completion: nil)

                }
            } // successful login
                
            else { // user is nil
                if let myError = error?.localizedDescription {
                    print(myError)
                    
                    if myError=="The email address is badly formatted."{ // Incorrect email format
                        self.removeSpinner()
                     let alert = self.alertContent(title:  "بريد إلكتروني خاطئ", message: " من فضلك أدخل صيغة بريد الكتروني صحيحة" )
                        self.present(alert, animated: true, completion: nil)

                        
                    } else if myError=="The password is invalid or the user does not have a password." { // Invalid password
                        self.removeSpinner()
                        let alert = self.alertContent(title: "كلمة المرور غير صحيحة", message: " من فضلِك أدخل كلمة المرور الخاصه بحسابك")
                        self.present(alert, animated: true, completion: nil)

                        
                    } else { // Unregistered email
                        self.removeSpinner()

                        let alert = self.alertContent(title:"البريد الالكتروني غير مسجل!", message:"من فضلِك قُم بإنشاء حساب ")
                        self.present(alert, animated: true, completion: nil)

                    }
                    
                } else {
                    print ("Error")
                }
                
            } // End else ( user is nil )
        }) // End auth signIn
    }
    
  

    func successful(){
        //=====Transfer to home page=====
        self.removeSpinner()
//    if(emailTextField.text != "mazaya@mc.gov.sa"){
//        getCategories()
        self.moveToTheTabBarViewController()

//        }
//    else {
//        self.moveToAdmin()
//
//        }
    }
    func moveToAdmin() {
        /*
        if let storyboard = self.storyboard{
            
            let newViewController = storyboard.instantiateViewController(withIdentifier: "adminPages") as! UINavigationController
           
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        }
 */
        let AdminhomeViewController = storyboard?.instantiateViewController(withIdentifier: "adminHome")
//               let userNavViewController = AdminhomeViewController?.viewControllers![1] as? UINavigationController
//               let userHomeViewController = userNavViewController?.viewControllers[0] as? AdminHomeViewController

             
               self.view.window?.rootViewController = AdminhomeViewController
               self.view.window?.makeKeyAndVisible()
    }
   func moveToTheTabBarViewController () {
          let homeViewController = storyboard?.instantiateViewController(withIdentifier: "VCTabBar") as? UITabBarController
          let userNavViewController = homeViewController?.viewControllers![4] as? UINavigationController
          let lastView = userNavViewController?.viewControllers[0]  as! homePageViewController
          let userNavViewController2 = homeViewController?.viewControllers![3] as? UINavigationController
          let bigOffers = userNavViewController2?.viewControllers[0] as! BigOffersViewController
//          bigOffers.Categories = self.Categories
          lastView.Categories = self.Categories
          lastView.Trades = self.trades2
          self.view.window?.rootViewController = homeViewController
          self.view.window?.makeKeyAndVisible()
      }
        
        
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
//    func showSpinner(){
//           self.showActivityIndicator(uiView: self.view)
//       }
//
//       func removeSpinner(){
//           self.hideActivityIndicator(uiView: self.view)
//       }
       func showActivityIndicator(uiView: UIView) {
             container.frame = uiView.frame
             container.center = uiView.center
             container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
         
          
             loadingView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 80, height: 80))

             loadingView.center = uiView.center
             loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
             loadingView.clipsToBounds = true
             loadingView.layer.cornerRadius = 10
         
             activityIndicator.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40))
        activityIndicator.style = .large
             activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

             loadingView.addSubview(activityIndicator)
             container.addSubview(loadingView)
             uiView.addSubview(container)
             activityIndicator.startAnimating()
         }
        
        func hideActivityIndicator(uiView: UIView) {
               activityIndicator.stopAnimating()
               container.removeFromSuperview()
           }
        
        
        func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
               let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
               let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
               let blue = CGFloat(rgbValue & 0xFF)/256.0
               return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
           }
    var trades2 = [Trademark]()
    
    //MARK: -Variables for category fetching
    var key1 = [Any]()
    var key2 : NSDictionary = [:]
    var cat : NSDictionary = [:]
    var catID : Array<Any> = []
    var Categories = [Category]()
    var category : Category!
    //MARK: - Variables for trademarks fetching
    var trade : Trademark!
    var trades : [String: Any]!
    var deleagte : handleRetrievedData?
    var currentTrade : Trademark!
    var tradeInfo : NSDictionary!
    //MARK: - Variables for offers fetching
    var offer : Offer!
    var offersDict = [String : Any]()
    var offers = [Offer]()
    var offerInfo : NSDictionary!
    var arrayOffers : NSArray!

    //MARK: - Variables for branches fetching
    var branch : Branch!
    var branchInfo : NSDictionary!
    var branches = [Branch]()
    var branchDict = [String : Any]()
    var arrayBranches : NSArray!
    // MARK: - Get Categories & store trademarks info
//    func getCategories(){
//        self.Categories = []
//        self.key1 = [Any]()
//        self.tradeInfo = [:]
//        self.key2 = [:]
//        self.trades = [:]
//        self.trades2 = []
//
//        let catRef = Database.database().reference()
//        catRef.child("Categories").observeSingleEvent(of: .value, with: { (snap) in
//            if let dict = snap.value as? [String : AnyObject] {
//                self.cat = dict as NSDictionary
//                for item in dict {
//                    self.key1.append(item.key)
//                }
//                for c in self.key1 {
//                    self.trades = [:]
//                    self.trades2 = []
//                    self.key2 = self.cat[c] as! NSDictionary
//                    self.catID.append(c)
//                    self.trades = self.key2["TradeMarks"] as? [String: AnyObject]
//                    if self.trades != nil {
//                        self.converTrades()
//                                                    
//                    }
//                    self.category = Category(Name: self.key2["Name"] as? String, key: c as? String, trademarks: self.trades2)
//                    self.Categories.append(self.category)
//                }
//            }
//            self.deleagte?.reloadTable()
//            self.deleagte?.retrievedCategories(myData: self.Categories)
//            self.moveToTheTabBarViewController()
//        })
//    }
    
//    func convertOffers(tradeInfo: NSDictionary){
//        self.arrayOffers = []
//        self.offersDict = [:]
//        self.offers = []
//        self.arrayOffers = tradeInfo["Offers"] as? NSArray
//        if arrayOffers != nil {
//            for i in arrayOffers {
//                offersDict = i as! [String : Any]
//                self.offer = Offer(discountCode: self.offersDict["DiscountCode"] as? String, numberOfCoupons: self.offersDict["NumberOfCoupons"] as? String, numberOfPoints: self.offersDict["NumberOfPoints"] as? String, offerType: self.offersDict["OfferType"] as? String, offerDiscription: self.offersDict["OffersDescription"] as? String, offersDetails: self.offersDict["OffersDetails"] as? String, offerTitle: self.offersDict["OffersTitle"] as? String, serviceType: self.offersDict["ServiceType"] as? String, endDate: self.offersDict["endDate"] as? String, startDate: self.offersDict["startDate"] as? String, offerNum: self.offersDict["offerNum"] as? Int)
//                self.offers.append(self.offer)
//            }
//        }
//    }

//    func convertBranches(tradeInfo: NSDictionary){
//        self.arrayBranches = []
//        self.branchDict = [:]
//        self.branches = []
//        self.arrayBranches = tradeInfo["Branches"] as? NSArray
//        if arrayBranches != nil {
//            for i in arrayBranches {
//                branchDict = i as! [String : Any]
//                self.branch = Branch(BranchLink: self.branchDict["BranchLink"] as? String, BrancheName: self.branchDict["BrancheName"] as? String, DescriptionBranch: self.branchDict["DescriptionBranch"] as? String)
//                self.branches.append(self.branch)
//            }
//        }
//    }
    
//    func converTrades(){
//        for i in self.trades.values {
//            self.tradeInfo = i as? NSDictionary
//            convertBranches(tradeInfo: self.tradeInfo)
//            convertOffers(tradeInfo: self.tradeInfo)
//            self.trade = Trademark(BrandName: self.tradeInfo?["BrandName"] as? String, num: self.tradeInfo?["Contact Number"] as? String, desc: self.tradeInfo?["Description"] as? String, email: self.tradeInfo?["Email"] as? String, fb: self.tradeInfo?["Facebook"] as? String, insta: self.tradeInfo["Instagram"] as? String, twit: self.tradeInfo?["Twitter"] as? String, web: self.tradeInfo?["WebURl"] as? String, image: self.tradeInfo?["BrandImage"] as? String, branches: self.branches, offers: self.offers, views: self.tradeInfo?["Views"] as? Int, isFav: false, regions: tradeInfo?["Regions"] as? [String], isFeatured: tradeInfo?["isFeatured"] as? Bool ?? false, catID: self.tradeInfo?["cateID"] as? String, tradID: self.tradeInfo?["tradeKey"] as? String)
//            self.trades2.append(self.trade)
//        }
//    }
        
}
