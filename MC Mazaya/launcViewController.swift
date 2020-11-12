//
//  launcViewController.swift
//  MC Mazaya
//
//  Created by Alhanouf khalid on 04/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

protocol handleRetrievedData {
    func reloadTable()
    func retrievedCategories(myData dataObject: [Category])
    func retrievedcopyCategories(myData dataObject: [Category])
//    func retrievedBanners(myData dataObject: [Banner])

}


class launchViewController: UIViewController {
    var timer = Timer()
    var trades2 = [Trademark]()
    
    //MARK: -Variables for category fetching
    var key1 = [Any]()
    var key2 : NSDictionary = [:]
    var cat : NSDictionary = [:]
    var catID : Array<Any> = []
    var Categories = [Category]()
    var categoriesCopy = [Category]()
    var category : Category!
    var banners = [Banner]()
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
    
    //MARK: - Variables of Views
    var aView : UIView?
    var bView = UIView()
    
    //MARK: - Lets
    let ai = UIActivityIndicatorView(style: .large)
    let reloadButton = UIButton()
    let reloadLabel = UILabel()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.generalGradiantView()

        setupUI()
        logoImage.transform = CGAffineTransform(scaleX: 0.0000001, y: 0.0000001)
        titleImage.transform = CGAffineTransform(scaleX: 0.0000001, y: 0.0000001)
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
            self.logoImage.transform = .identity
            self.titleImage.transform = .identity
        }) { (true) in
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.nothing), userInfo: nil, repeats: false)
            }
        DispatchQueue.main.async {
            self.showApp()
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        }
        }
    
    //MARK: - Loading Launch screen & luanch the app
    @objc func nothing() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = .white
        ai.center = aView!.center
        ai.color = .black
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.showReloadButton), userInfo: nil, repeats: false)
        }
    
    @objc func showReloadButton(){
        bView = UIView(frame: self.view.bounds)
        bView.backgroundColor = .white
        reloadButton.setImage(UIImage(named: "reload"), for: .normal)
        reloadButton.setImage(UIImage(named: "pressedReload"), for: .highlighted)
        reloadLabel.text = "تحقق من اتصالك بالإنترنت"
        reloadLabel.textColor = UIColor(rgb: 0x38a089)
        reloadLabel.font = UIFont(name: "stc", size: 20.0)
        reloadButton.frame.size.width = 30
        reloadButton.frame.size.height = 30
        reloadButton.center = self.bView.center
        reloadLabel.center.y = self.bView.center.y - 40
        reloadLabel.sizeToFit()
        reloadLabel.center.x = UIScreen.main.bounds.size.width * 0.5
        reloadLabel.numberOfLines = 0
        bView.addSubview(reloadLabel)
        bView.addSubview(reloadButton)
        reloadButton.addTarget(self, action: #selector(self.reloadCategories), for: .touchUpInside)
        getCategories()
        self.view.addSubview(bView)
    }
    
    @objc func reloadCategories(){
        bView.addSubview(ai)
        reloadButton.setImage(UIImage(named: "whiteBG"), for: .normal)
        reloadLabel.text = " "
        showApp()
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(showReloadButton), userInfo: nil, repeats: false)
    }
       
    @objc func showApp() {
        self.authenticateUserAndConfigureView()
    }
       
    
    //MARK: - UI Constants
    let logoImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "whiteMazaya")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
       
    
    let titleImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = #imageLiteral(resourceName: "utBt")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let bgImage : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "bg")
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    //MARK: -Direct user based on type
    func authenticateUserAndConfigureView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
        if Auth.auth().currentUser?.email == "mazaya@mc.gov.sa" {
            // User logged as Admin
            self.moveToAdminViewController()
        }
        else if Auth.auth().currentUser?.uid != nil {
            // User logged as employee or family member
//            self.retrieveBanners()
            self.getCategories()
        } else {
        //user is not logged in
            self.moveToLoginViewController()
        }
        })
    }
    
    func moveToAdminViewController () {
        if let storyboard = self.storyboard{
            let AdminHomeVC = storyboard.instantiateViewController(withIdentifier: "adminHome")
            // home page
            //let userNavViewController = AdminHomeViewController?.viewControllers![1] as? UINavigationController
            // let userHomeViewController = userNavViewController?.viewControllers[0] as? homeViewController
            self.view.window?.rootViewController = AdminHomeVC
            self.view.window?.makeKeyAndVisible()
        }
    }
    
    
    func moveToTheTabBarViewController () {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "VCTabBar") as? UITabBarController
        // home page
        let userNavViewController = homeViewController?.viewControllers![4] as? UINavigationController
        let lastView = userNavViewController?.viewControllers[0]  as! homePageViewController
        let userNavViewController2 = homeViewController?.viewControllers![3] as? UINavigationController
        let bigOffers = userNavViewController2?.viewControllers[0] as! BigOffersViewController
//        getFeaturedTrademarks()
        bigOffers.Categories = self.Categories
        lastView.Categories = self.Categories
        lastView.categoriesCopy = self.categoriesCopy
        lastView.Trades = self.trades2
//        lastView.banners = self.banners
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func moveToLoginViewController () {
        if let storyboard = self.storyboard{
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
        

    }
    

} // End of the class


//MARK: - Class Extension
extension launchViewController {
    // User interface Setup
    func setupUI() {
        view.addSubview(bgImage)
        view.addSubview(logoImage)
        view.addSubview(titleImage)
        NSLayoutConstraint.activate([
            bgImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bgImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        logoImage.anchor(top: view.topAnchor, paddingTop: 250,width: 150, height: 150)
        titleImage.anchor(top: logoImage.bottomAnchor, paddingTop: 20, width: 100, height: 100)
        bgImage.anchor(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
       
    //Get Categories & store trademarks info
    func getCategories(){
        self.Categories = []
        self.key1 = [Any]()
        self.tradeInfo = [:]
        self.key2 = [:]
        self.trades = [:]
        self.trades2 = []
        let catRef = Database.database().reference()
        catRef.child("Categories").observeSingleEvent(of: .value, with: { (snap) in
            if let dict = snap.value as? [String : AnyObject] {
                self.cat = dict as NSDictionary
                for item in dict {
                    self.key1.append(item.key)
                }
                for c in self.key1 {
                    self.trades = [:]
                    self.trades2 = []
                    self.key2 = self.cat[c] as! NSDictionary
                    self.catID.append(c)
                    self.trades = self.key2["TradeMarks"] as? [String: AnyObject]
                    if self.trades != nil {
                        self.converTrades()
                    }
                self.category = Category(Name: self.key2["Name"] as? String, key: c as? String, trademarks: self.trades2)
                self.Categories.append(self.category)
                self.categoriesCopy.append(self.category)
                }
            }
            self.deleagte?.reloadTable()
            self.deleagte?.retrievedCategories(myData: self.Categories)
            self.deleagte?.retrievedcopyCategories(myData: self.categoriesCopy)
            self.moveToTheTabBarViewController()
        })
    } // End of get Categories
        
    func convertOffers(tradeInfo: NSDictionary){
        self.arrayOffers = []
        self.offersDict = [:]
        self.offers = []
        self.arrayOffers = tradeInfo["Offers"] as? NSArray
        if arrayOffers != nil {
            for i in arrayOffers {
                offersDict = i as! [String : Any]
                self.offer = Offer(discountCode: self.offersDict["DiscountCode"] as? String, numberOfCoupons: self.offersDict["NumberOfCoupons"] as? String, numberOfPoints: self.offersDict["NumberOfPoints"] as? String, offerType: self.offersDict["OfferType"] as? String, offerDiscription: self.offersDict["OffersDescription"] as? String, offersDetails: self.offersDict["OffersDetails"] as? String, offerTitle: self.offersDict["OffersTitle"] as? String, serviceType: self.offersDict["ServiceType"] as? String, endDate: self.offersDict["endDate"] as? String, startDate: self.offersDict["startDate"] as? String, offerNum: self.offersDict["offerNum"] as? Int)
                self.offers.append(self.offer)
            }
        }
    } // End of add Offers

    func convertBranches(tradeInfo: NSDictionary){
        self.arrayBranches = []
        self.branchDict = [:]
        self.branches = []
        self.arrayBranches = tradeInfo["Branches"] as? NSArray
        if arrayBranches != nil {
            for i in arrayBranches {
                branchDict = i as! [String : Any]
                self.branch = Branch(BranchLink: self.branchDict["BranchLink"] as? String, BrancheName: self.branchDict["BrancheName"] as? String, DescriptionBranch: self.branchDict["DescriptionBranch"] as? String)
                    self.branches.append(self.branch)
            }
        }
    } // End of Add Branches
        
    func converTrades(){
        for i in self.trades.values {
            self.tradeInfo = i as? NSDictionary
            convertBranches(tradeInfo: self.tradeInfo)
            convertOffers(tradeInfo: self.tradeInfo)
       self.trade = Trademark(BrandName: self.tradeInfo?["BrandName"] as? String, num: self.tradeInfo?["Contact Number"] as? String, desc: self.tradeInfo?["Description"] as? String, email: self.tradeInfo?["Email"] as? String, fb: self.tradeInfo?["Facebook"] as? String, insta: self.tradeInfo["Instagram"] as? String, twit: self.tradeInfo?["Twitter"] as? String, web: self.tradeInfo?["WebURl"] as? String, image: self.tradeInfo?["BrandImage"] as? String, branches: self.branches, offers: self.offers, views: self.tradeInfo?["Views"] as? Int, isFav: false, regions: tradeInfo?["Regions"] as? [String], isFeatured: tradeInfo?["isFeatured"] as? Bool ?? false, catID: self.tradeInfo?["cateID"] as? String, tradID: self.tradeInfo?["tradeKey"] as? String)
                self.trades2.append(self.trade)
        }
    } // End of Add Trademarks

//    func retrieveBanners(){
//        self.banners = []
//        let bannerRef = Database.database().reference()
//        bannerRef.child("Banners").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dict = snapshot.value as? [String : Any] {
//                for bannerKey in dict.keys {
//                    let bannerDict = dict[bannerKey] as! NSDictionary
//                    self.banners.append(Banner(title: bannerDict["Title"] as! String, imageURL: bannerDict["imageURL"] as! String, type: bannerDict["Type"] as! String))
//                }
//            }
//            self.deleagte?.retrievedBanners(myData: self.banners)
//         })
//
//    }
    
} // End of class

