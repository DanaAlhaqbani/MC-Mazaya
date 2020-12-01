//
//  homePageViewController.swift
//  MC Mazaya
//
//  Created by Alhanouf khalid on 04/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SideMenu
import DropDown

class homePageViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    //MARK: - Constants
    let user = Auth.auth().currentUser
    let green = UIColor(rgb: 0x38a089)
    //    let firstInitailizer = launchViewController()
    var searchBar : UISearchController!
    var searchbar = UISearchBar()
    var isFavourite = false
    //MARK: - Vars
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var SideMenu: SideMenuNavigationController?
    var rightBarButtonItem = UIBarButtonItem()
    var leftBarButtonItem = UIBarButtonItem()
    var leftBtn = UIButton()
    var rightBtn = UIButton()
    var mainViewXConstraint : NSLayoutConstraint!
    var sideMenuWidth = CGFloat()
    var isMenuShow = false
    var Categories = [Category]()
    var Trades = [Trademark]()
    var filteredData = [String]()
    var filteredTradeMarks = [Trademark]()
    //    var resultCollectionViewController : searchResult!
    var resultTableViewController : searchResultTable!
    var filteredCategoriesName = [String]()
    var filterVC = filterViewController()
    var sortByString : String?
    var favDictionary : NSDictionary = [:]
    var favouriteTrades = [Trademark]()
    var categoriesCollection : categoriesCollectionView?
    var regionFilrered : RegionVC?
    var selectedRegion : String?
    var featuredTradeMarks = [Trademark]()
    var banners = [Banner]()
    var bannerView : bannerContainer?
    var trademarksIDs = [String]()
    var filteredTrademarks = [Trademark]()
    let regionDropDownMenu = DropDown()
    var seectedRegion = String()
//    var filteredCategories = [Category]()
    //MARK: - Outlets
    @IBOutlet weak var tbleList: UITableView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupSearchBar()
        handleDelegates()
        dataUser()
        setUpUI()
        self.navigationItem.titleView = searchBar.searchBar
        filterVC.delegate = self
        navigationController?.navigationBar.tintColor = UIColor(rgb: 0x1C9A8A)
        navigationController?.delegate = self
        tbleList.register(UINib(nibName: "CollectionviewTableCell", bundle: nil), forCellReuseIdentifier: "CollectionviewTableCell")
        tbleList.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        setupSearchTextField()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        setupSearchBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        mainViewXConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
                       options: .curveEaseInOut, animations: {
                        self.view.layoutIfNeeded()
                       }, completion: nil)
        isMenuShow = false
        
    }
    
    //MARK: - "Side Menue" Constants and Variables
    let mainView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.zPosition = 100
        $0.isHidden = true
        return $0
    }(UIView())
    
    let sideMenu : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        let green = UIColor(rgb: 0x38a089)
        $0.backgroundColor = green
        return $0
    }(UIView())
    
    let separatorView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        let green = UIColor(rgb: 0x38a089)
        $0.backgroundColor = green
        return $0
    }(UIView())
    
    let sideMenuStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        //$0.distribution = .fillEqually
        let green = UIColor(rgb: 0x38a089)
        $0.spacing = 10
        $0.backgroundColor = green
        return $0
    }(UIStackView())
    
    let MazayaLogoView : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = #imageLiteral(resourceName: "whiteMazaya")
        return $0
    }(UIImageView())
    
    lazy var openRegionVC : UIButton = {
        $0.setTitle("المنطقة", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 10
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var openFamilyVC : UIButton = {
        $0.setTitle("عائلتي", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 11
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var openFavVC : UIButton = {
        $0.setTitle("المفضلة", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 12
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var openNewOffersVC : UIButton = {
        $0.setTitle("جديد العروض", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 13
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var openSuggestVC : UIButton = {
        $0.setTitle("إقترح عرضاً", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 14
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var openVouchersVC : UIButton = {
        $0.setTitle("القسائم الشرائية", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 15
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var openHelpVC : UIButton = {
        $0.setTitle("للمساعدة", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 16
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var logoutVS : UIButton = {
        $0.setTitle("تسجيل الخروج", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.6274509804, blue: 0.537254902, alpha: 1)
        $0.imageView?.image = #imageLiteral(resourceName: "FAQ icon")
        $0.titleLabel?.font = UIFont(name: "STC", size: 20)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 17
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    
    //MARK: - Logout Function
    func logout(){
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK:- Table View delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.Categories.count > 0 && self.featuredTradeMarks.count > 0 {
            return Categories.count + 1
        } else if self.Categories.count > 0 && self.featuredTradeMarks.count == 0 {
            return Categories.count
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionviewTableCell") as! CollectionviewTableCell
        if Categories.count != 0 {
//            let trademarksNumber = self.Categories[indexPath.row].trademarks
            if featuredTradeMarks.count != 0 {
                if indexPath.row == 0 {
                    cell.nameLabel.text = "مميز"
                    let featured = self.featuredTradeMarks
                    cell.Trades = featured
                    cell.delegate = self
                    cell.setUpDataSource()
                } else {
                    self.Categories = self.Categories.sorted {
                        guard let first = $0.Name else {
                            return false
                        }
                        guard let second = $1.Name else {
                            return true
                        }
                        return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
                    } // End of sorting result
                    filterTrademarks(indexPath)
                    cell.nameLabel.text = self.Categories[indexPath.row - 1].Name
                    cell.catId = self.Categories[indexPath.row - 1].Name!
                    cell.category = self.Categories[indexPath.row - 1]
                    cell.Trades = filteredTrademarks
                    cell.delegate = self
                    cell.setUpDataSource()
                    
                }
            } else {
                cell.nameLabel.text = self.Categories[indexPath.row].Name
                cell.catId = self.Categories[indexPath.row].Name!
                cell.category = self.Categories[indexPath.row]
                cell.Trades = filteredTrademarks
                cell.delegate = self
                cell.setUpDataSource()
            }
            self.Categories = self.Categories.sorted {
                guard let first = $0.Name else {
                    return false
                }
                guard let second = $1.Name else {
                    return true
                }
                return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
            } // End of sorting results
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func dataUser () {
        ref = Database.database().reference()
        handle = ref?.child("Users").child((user?.uid)!).child("name").observe(.value, with: { (snapshot) in
            let currentName = snapshot.value as? String
            userData.name = currentName!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("email").observe(.value, with: { (snapshot) in
            let currentEmail = snapshot.value as? String
            userData.email  = currentEmail!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("gender").observe(.value, with: { (snapshot) in
            let currentGender = snapshot.value as? String
            userData.gender  = currentGender!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("phone").observe(.value, with: { (snapshot) in
            let currentPhone = snapshot.value as? String
            userData.phone = currentPhone!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("points").observe(.value, with: { (snapshot) in
            let currentPoints = snapshot.value as? String
            userData.points = currentPoints!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("region").observe(.value, with: { [self] (snapshot) in
            let currentRegion = snapshot.value as? String
            userData.region = currentRegion!
            //            print(currentRegion)
            DispatchQueue.main.async {
                self.getCategories(currentRegion!)
//                self.filterCategories()
                //                self.tbleList.reloadData()
            }
            
        })
        handle = ref?.child("Users").child((user?.uid)!).child("userType").observe(.value, with: { (snapshot) in
            let currentuserType = snapshot.value as? String
            userData.userType = currentuserType!
        })
    }
    
    
    
    //MARK: - Segue preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tradeInfo" {
            let dis = segue.destination as! detailsViewController
            dis.tradeInfo = sender as? Trademark
            //            if self.favouriteTrades.contains(where: {$0.BrandName == dis.tradeInfo.BrandName}){
            //                dis.tradeInfo.isFav = true
            //            } else {
            ////                dis.tradeInfo.isFav = false
            //            }
            print(favDictionary)
        } // Show Description Segue
        if segue.identifier == "trademarks" {
            let dis = segue.destination as! TrademarkTableVC
            dis.trades = sender as? [Trademark] ?? []
            
        } // Show Trademarks Segue
        if segue.identifier == "filter" {
            let dis = segue.destination as! UINavigationController
            let filterVC = dis.viewControllers[0] as! filterViewController
            //            filterVC.Categories = self.categoriesCopy
            filterVC.selectedSortByString = nil
            filterVC.selectedServiceString = nil
            filterVC.dismissHandler = {
                if filterVC.selectedChecker == false {
                    //                    self.Categories = self.categoriesCopy
                    self.Categories = filterVC.passedCategories
                    self.sortByString = filterVC.selectedSortByString
                    //                    self.serviceTypeString = filterVC.selectedServiceString
                    self.tbleList.reloadData()
                } else {
                    //                    self.Categories = self.categoriesCopy
                    self.sortByString = nil
                    //                    self.serviceTypeString = nil
                    self.tbleList.reloadData()
                }
                self.tbleList.reloadData()
            }
        } // Handling Filter Segue
        if segue.identifier == "toNewOffers" {
            let dis = segue.destination as! NewOffersViewController
            dis.Categories = self.Categories
        } // Show new offers Segue
        if segue.identifier == "toFav" {
            let dis = segue.destination as! FavoriteViewController
            //            getFav()
            //            dis.Categories = self.Categories
            dis.favTrademarks = self.favouriteTrades
            //            dis.favDict = sender as! NSDictionary
        } // Show new offers Segue
        if segue.identifier == "toVouchers" {
            let dis = segue.destination as! VouchersViewController
            dis.Categories = self.Categories
            dis.Trades = self.Trades
        } // Show new offers Segue
        if let des = segue.destination as? categoriesCollectionView, segue.identifier == "categoriesCollection" {
            //            des.categories = self.Categories
            //            des.trademarks = Trades
            //            des.cate
            
            //            self.categoriesCollection = des
        }
        if segue.identifier == "toRegion" {
            let des = segue.destination as! RegionVC
            des.selectedRegion = nil
            des.dismissHandler = {
                self.selectedRegion = des.selectedRegion
                print(self.selectedRegion!)
                self.tbleList.reloadData()
            }
            //            self.regionFilrered = des
        }
        if segue.identifier == "toCategory" {
            let des = segue.destination as! TrademarkTableVC
            let sender = sender as! Category
            des.category = sender
            //
        }
        if let des = segue.destination as? bannerContainer , segue.identifier == "bannerContainer" {
            //            retrieveBanners()
            //            bannerView?.data = self.banners
            bannerView = des 
        }
        if segue.identifier == "toSeasonalOffers" {
            let des = segue.destination as! seasonalOffers
            let sender = sender as! String
            des.seasonTitle = sender
        }
        
    }// Prepare Function
    
}



