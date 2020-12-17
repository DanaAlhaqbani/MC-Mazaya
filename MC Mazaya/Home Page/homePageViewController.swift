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

    //MARK: - Vars
    // Variables for database reference handling
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    // Variables for Side menu
    var SideMenu: SideMenuNavigationController?
    var rightBarButtonItem = UIBarButtonItem()
    var rightBtn = UIButton()
    var mainViewXConstraint : NSLayoutConstraint!
    var sideMenuWidth = CGFloat()
    var isMenuShow = false
    
    // Variables for retrieving functions
    var Trades = [Trademark]()
    var featuredTradeMarks = [Trademark]()
    var filteredTrademarks = [Trademark]()
    var filteredCategories = [String]()
    var tradesForRegion = [Trademark]()

    // Variables for search bar
    var searchBar : UISearchController!
    var searchbar = UISearchBar()
    var filteredData = [String]()
    var resultTableViewController : searchResultTable!
    
    // Variables for "Categories Bar" Container
    var categoriesCollection : categoriesCollectionView?
    
    // Variables for Banners Container
    var banners = [Banner]()
    var bannerView : bannerContainer?
    
    // Variables for handling region
    var regionFilrered : RegionVC?
    let regionDropDownMenu = DropDown()
    var seectedRegion = String()
    var selectedRegion : String?
    var trademarksResults = [Trademark]()
    //MARK: - Outlets
    @IBOutlet weak var tbleList: UITableView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup and handling data functions
        setupSearchBar()
        handleDelegates()
        dataUser()
        setUpUI()
        // Assign search bar at title of navigation bar and customize it
        self.navigationItem.titleView = searchBar.searchBar
        navigationController?.navigationBar.tintColor = UIColor(rgb: 0x1C9A8A)
        navigationController?.delegate = self
        navigationController?.navigationBar.isTranslucent = true
        // Setup table view
        tbleList.register(UINib(nibName: "CollectionviewTableCell", bundle: nil), forCellReuseIdentifier: "CollectionviewTableCell")
        tbleList.separatorStyle = .none
        definesPresentationContext = true

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        window
    }
    // Setup view when did disappear
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
    }(UIView()) // End of customize main view
    
    let sideMenu : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        let green = UIColor(rgb: 0x26998a)
        $0.backgroundColor = green
        return $0
    }(UIView()) // End of customize side menu
    
    let separatorView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        let green = UIColor(rgb: 0x26998a)
        $0.backgroundColor = green
        return $0
    }(UIView()) // End of customize sperator view
    
    let sideMenuStackView : UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        let green = UIColor(rgb: 0x26998a)
        $0.spacing = 10
        $0.backgroundColor = green
        return $0
    }(UIStackView()) // End of customize stack view
    
    let MazayaLogoView : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = #imageLiteral(resourceName: "whiteMazaya")
        return $0
    }(UIImageView()) // End of customize mazaya logo
    
    lazy var openRegionVC : UIButton = {
        $0.setTitle("المنطقة", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 10
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize region
    
    lazy var openFamilyVC : UIButton = {
        $0.setTitle("عائلتي", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 11
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize Family members
    
    lazy var openFavVC : UIButton = {
        $0.setTitle("المفضلة", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 12
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize Favourite
    
    lazy var openNewOffersVC : UIButton = {
        $0.setTitle("جديد العروض", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 13
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize New offers
    
    lazy var openSuggestVC : UIButton = {
        $0.setTitle("إقترح عرضاً", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 14
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of cistomize Suggestions
    
    lazy var openVouchersVC : UIButton = {
        $0.setTitle("القسائم الشرائية", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 15
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize Vouchers
    
    lazy var openHelpVC : UIButton = {
        $0.setTitle("للمساعدة", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 16
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize Help page
    
    lazy var openAboutVC : UIButton = {
        $0.setTitle("من نحن", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 18
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize Help page
    
    lazy var logoutVS : UIButton = {
        $0.setTitle("تسجيل الخروج", for: .normal)
        $0.backgroundColor = UIColor(rgb: 0x26998a)
        $0.imageView?.image = #imageLiteral(resourceName: "FAQ icon")
        $0.titleLabel?.font = UIFont(name: "STC", size: 17)
        $0.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.tag = 17
        $0.addTarget(self, action: #selector(menuButtonsActions(_:)), for: .touchUpInside)
        return $0
    }(UIButton(type: .system)) // End of customize logout button
    
    
    
    //MARK: - Logout Function
    func logout(){
        try! Auth.auth().signOut() // Logout method
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController")
            self.present(vc, animated: true, completion: nil) // Move to login page
        }
    } // End of logout function
    
    //MARK:- Table View delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check if there is a featured trademarks, if There, the number of rows will be the number of categories plus one for Featured, otherwise will be just the number of categories
        if self.filteredCategories.count > 0 && self.featuredTradeMarks.count > 0 {
            return filteredCategories.count + 1
        } else if self.filteredCategories.count > 0 && self.featuredTradeMarks.count == 0 {
            return filteredCategories.count
        } else {
            // To handle empty view while fetching data
            return 3
        } // End of if-else statements
    } // End of handlign row numbers function
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionviewTableCell") as! CollectionviewTableCell
        // Check the number of categories not equal 0 to prevent errors
        if filteredCategories.count != 0 {
            // Check if there's featured trademarks to setup table view based on that
            if featuredTradeMarks.count != 0 {
                // Set up Featured section
                if indexPath.row == 0 {
                    cell.nameLabel.text = "مميز"
                    let featured = self.featuredTradeMarks
                    cell.Trades = featured
                    cell.delegate = self
                    cell.setUpDataSource()
                } else {
                    // Sort trademarks alphabetically
                    self.filteredCategories = self.filteredCategories.sorted {
                        guard let first = $0 as? String else {
                            return false
                        }
                        guard let second = $1 as? String else {
                            return true
                        }
                        return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
                    } // End of sorting result
                    filterTrademarks(indexPath)
                    cell.nameLabel.text = self.filteredCategories[indexPath.row - 1]
                    cell.catId = self.filteredCategories[indexPath.row - 1]
//                    cell.category = self.filteredCategories[indexPath.row - 1]
                    cell.Trades = filteredTrademarks
                    cell.delegate = self
                    cell.setUpDataSource()
                } // End of setting up other sections
            } else {
                // Deal with trademarks without featured
                filterTrademarks(indexPath)
                cell.nameLabel.text = self.filteredCategories[indexPath.row]
                cell.catId = self.filteredCategories[indexPath.row]
//                cell.category = self.regionCategories[indexPath.row]
                cell.Trades = filteredTrademarks
                cell.delegate = self
                cell.setUpDataSource()
//                cell.setUpEmptyCategory()
            } // End of setting up trademarks
            
            self.filteredCategories = self.filteredCategories.sorted {
                guard let first = $0 as? String else {
                    return false
                }
                guard let second = $1 as? String else {
                    return true
                }
                return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
            } // End of sorting results
        }
        return cell
    } // End of Cell At Row function
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    } // End of cell height functio
    
    //MARK: - Retrieve user data
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
//                self.getCategories(currentRegion!)
                self.retrieveTrades(currentRegion!)
//                self.filterCategories()
                //                self.tbleList.reloadData()
            }
            
        })
        handle = ref?.child("Users").child((user?.uid)!).child("userType").observe(.value, with: { (snapshot) in
            let currentuserType = snapshot.value as? String
            userData.userType = currentuserType!
            DispatchQueue.main.async {
                // Change the content of side menu based on user type; if it's employee show "Family members - Vouchers"
                self.adjustSidemenue(currentuserType!)
            }
        })
        let voucherRef = ref?.child("Users").child((user?.uid)!).child("MyVouchers").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let voucher = usedVoucher(snap: snap)
                userData.myVouchers.append(voucher)
//                self.userVouchers.append(voucher)
            }
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
//            print(favDictionary)
        } // Show Description Segue
        if segue.identifier == "trademarks" {
            let dis = segue.destination as! TrademarkTableVC
            dis.trades = sender as? [Trademark] ?? []
            
        } // Show Trademarks Segue
        if segue.identifier == "toNewOffers" {
            _ = segue.destination as! NewOffersViewController
//            dis.Trades = self.Trades
        } // Show new offers Segue
        if segue.identifier == "toFav" {
            let dis = segue.destination as! FavoriteViewController
            //            getFav()
            //            dis.Categories = self.Categories
//            dis.favTrademarks = self.favouriteTrades
            dis.Trademarks = self.Trades
            //            dis.favDict = sender as! NSDictionary
        } // Show new offers Segue
        if segue.identifier == "toVouchers" {
            let dis = segue.destination as! VouchersViewController
//            dis.Categories = self.Categories
//            dis.Trades = self.Trades
        } // Show new offers Segue
        if let _ = segue.destination as? categoriesCollectionView, segue.identifier == "categoriesCollection" {
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
//            let sender = sender as! Category
//            des.category = sender
            des.trades = sender as! [Trademark]
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



