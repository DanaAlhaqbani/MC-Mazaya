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

class homePageViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    //MARK: - Lets
    let user = Auth.auth().currentUser
    let green = UIColor(rgb: 0x38a089)
    let firstInitailizer = launchViewController()
    var searchBar : UISearchController!
    var categoriesCopy = [Category]()
    
    //MARK: - Vars
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var SideMenu: SideMenuNavigationController?
    var rightBarButtonItem = UIBarButtonItem()
    var leftBarButtonItem = UIBarButtonItem()
    var mainViewXConstraint : NSLayoutConstraint!
    var sideMenuWidth = CGFloat()
    var isMenuShow = false
    var Categories = [Category]()
    var Trades = [Trademark]()
    var filteredData = [String]()
    var filteredTradeMarks = [Trademark]()
    var resultCollectionViewController : searchResult!
    var filteredCategoriesName = [String]()
    var filterVC = filterViewController()
//    var filteredServiceType = [String]()
//    var filteredSortedBy = [String]()
    var sortByString : String?
    var serviceTypeString : String?
    
    //MARK: - Outlets
    @IBOutlet weak var tbleList: UITableView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        handleDelegates()
        dataUser()
        setUpUI()
        filterVC.delegate = self
        tbleList.register(UINib(nibName: "CollectionviewTableCell", bundle: nil), forCellReuseIdentifier: "CollectionviewTableCell")
        tbleList.separatorStyle = .none
    }


    let mainView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        //$0.backgroundColor = .init(white: 0.95, alpha: 1)
        $0.layer.zPosition = 100
        $0.isUserInteractionEnabled = true
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
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
           
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
        return Categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionviewTableCell") as! CollectionviewTableCell
        if searchBar.isActive {
            self.tbleList.isHidden = true
        }
        self.Categories = self.Categories.sorted {
                guard let first = $0.Name else {
                    return false
                }
                guard let second = $1.Name else {
                    return true
                }
                return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
            } // End of sorting result

        if sortByString != nil {
            if sortByString == "الأكثر مشاهدة" {
                cell.sortedBy = self.sortByString!
            } else {
                cell.sortedBy = nil
                cell.delegate = self
            }
            
            cell.setUpDataSource()
            cell.nameLabel.text = self.Categories[indexPath.row].Name
            cell.catId = self.Categories[indexPath.row].key ?? ""
            cell.delegate = self
        }
        if serviceTypeString != nil {
            getFilteredByServiceTypeTradeMarks(index: indexPath)
            cell.Trades = filteredByServiceType
            cell.setUpDataSource()
            cell.nameLabel.text = self.Categories[indexPath.row].Name
            cell.catId = self.Categories[indexPath.row].key ?? ""
            cell.delegate = self
        } else {
        cell.Trades = self.Categories[indexPath.row].trademarks ?? []
        }
        cell.setUpDataSource()
        cell.nameLabel.text = self.Categories[indexPath.row].Name
        cell.catId = self.Categories[indexPath.row].key ?? ""
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func dataUser () {
        ref = Database.database().reference()
        handle = ref?.child("Users").child((user?.uid)!).child("Name").observe(.value, with: { (snapshot) in
            let currentName = snapshot.value as? String
            userData.name = currentName!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("Email").observe(.value, with: { (snapshot) in
            let currentEmail = snapshot.value as? String
            userData.email  = currentEmail!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("Gender").observe(.value, with: { (snapshot) in
            let currentGender = snapshot.value as? String
            userData.gender  = currentGender!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("Phone").observe(.value, with: { (snapshot) in
            let currentPhone = snapshot.value as? String
            userData.phone = currentPhone!
        })
        handle = ref?.child("Users").child((user?.uid)!).child("Points").observe(.value, with: { (snapshot) in
            let currentPoints = snapshot.value as? String
             userData.points = currentPoints!
        })
    }
    
    
    
    //MARK: - Segue preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tradeInfo" {
            let dis = segue.destination as! DscriptionViewController
            dis.tradeInfo = sender as? Trademark
        } // Show Description Segue
        if segue.identifier == "trademarks" {
                let dis = segue.destination as! TrademarkTableVC
                dis.trades = sender as? [Trademark] ?? []
        } // Show Trademarks Segue
        if segue.identifier == "filter" {
            let dis = segue.destination as! UINavigationController
            let filterVC = dis.viewControllers[0] as! filterViewController
            filterVC.Categories = self.categoriesCopy
            filterVC.selectedSortByString = nil
            filterVC.selectedServiceString = nil
            filterVC.dismissHandler = {
                if filterVC.selectedChecker == false {
                    self.Categories = self.categoriesCopy
                    self.Categories = filterVC.passedCategories
                    self.sortByString = filterVC.selectedSortByString
                    self.serviceTypeString = filterVC.selectedServiceString
                    self.tbleList.reloadData()
                } else {
                    self.Categories = self.categoriesCopy
                    self.sortByString = nil
                    self.serviceTypeString = nil
                    self.tbleList.reloadData()
                }
                self.tbleList.reloadData()
            }
        }
        if segue.identifier == "toNewOffers" {
                     let dis = segue.destination as! NewOffersViewController
                  dis.Categories = self.Categories
             } // Show new offers Segue
         if segue.identifier == "toFav" {
                    let dis = segue.destination as! FavoriteViewController
                 dis.Categories = self.Categories
                    } // Show new offers Segue
        if segue.identifier == "toVouchers" {
                let dis = segue.destination as! VouchersViewController
                  dis.Categories = self.Categories
             } // Show new offers Segue
    }// Prepare Function
    
    
    
    var filteredByServiceType = [Trademark]()
    
    func getFilteredByServiceTypeTradeMarks(index : IndexPath) {
        self.filteredByServiceType = []
        let trades = Categories[index.row].trademarks!
        for trade in trades {
            let offers = trade.offers!
            for offer in offers {
                if offer.serviceType == self.serviceTypeString {
                        if !self.filteredByServiceType.contains(where: {$0.BrandName == trade.BrandName}) {
                            self.filteredByServiceType.append(trade)
                        } // Ensure not duplicate trademarks
                    } // Add offer if it's selected
            } // Iterate over offers
        } // iterate over trademarks
    } // Get filtered by service type trademarks function
    
    
    
////    func getSortedTra
//    func getSortedCategories(index: IndexPath){
//    }
    
}



    



//MARK: - Extension "setup userinterface and search bar"

extension homePageViewController {
    //MARK:  Setup User interface
    func setUpUI(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = .white
        sideMenuWidth = view.frame.width / 2
        view.addSubview(mainView)
        view.addSubview(sideMenu)
        sideMenu.addSubview(separatorView)
        sideMenu.addSubview(sideMenuStackView)
        sideMenuStackView.addArrangedSubview(openRegionVC)
        sideMenuStackView.addArrangedSubview(openFamilyVC)
        sideMenuStackView.addArrangedSubview(openFavVC)
        sideMenuStackView.addArrangedSubview(openNewOffersVC)
        sideMenuStackView.addArrangedSubview(openSuggestVC)
        sideMenuStackView.addArrangedSubview(openVouchersVC)
        sideMenuStackView.addArrangedSubview(openHelpVC)
        sideMenuStackView.addArrangedSubview(logoutVS)
        leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterTapped))
        rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(menuTapped))
        rightBarButtonItem.tintColor = green
        leftBarButtonItem.tintColor = green
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.leftBarButtonItem = leftBarButtonItem
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mainView.widthAnchor.constraint(equalTo: view.widthAnchor),
            sideMenu.heightAnchor.constraint(equalTo: mainView.heightAnchor),
            sideMenu.widthAnchor.constraint(equalTo: view.widthAnchor),
            sideMenu.leftAnchor.constraint(equalTo: mainView.rightAnchor),
            sideMenu.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            separatorView.heightAnchor.constraint(equalTo: sideMenu.heightAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 3),
            separatorView.leftAnchor.constraint(equalTo: sideMenu.leftAnchor),
            separatorView.centerYAnchor.constraint(equalTo: sideMenu.centerYAnchor),
            sideMenuStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sideMenuStackView.leftAnchor.constraint(equalTo: separatorView.rightAnchor),
            sideMenuStackView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
            openRegionVC.heightAnchor.constraint(equalToConstant: 50),
        ])
        mainViewXConstraint = mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        mainViewXConstraint.isActive = true
    } // end of setupUI
    
    //MARK: set up Searchbar
    func setupSearchBar(){
        resultCollectionViewController = storyboard!.instantiateViewController(withIdentifier: "searchResults") as? searchResult
        searchBar = UISearchController(searchResultsController: resultCollectionViewController)
        searchBar.searchBar.delegate = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.showsSearchResultsButton = true
//        searchBar.searchBar.showsBookmarkButton = true
//        searchBar.searchBar.setImage(UIImage(named: "filter"), for: .bookmark, state: .normal)
        navigationItem.searchController = self.searchBar
        searchBar.searchBar.searchBarStyle = .default
        searchBar.searchBar.placeholder = "ما الذي تبحث عنه ؟"
        searchBar.searchBar.semanticContentAttribute = .forceRightToLeft
        searchBar.automaticallyShowsScopeBar = false
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "إلغاء"
        searchBar.searchBar.tintColor = UIColor(rgb: 0x38a089)
        searchBar.searchBar.searchTextField.semanticContentAttribute = .forceRightToLeft
        searchBar.definesPresentationContext = true
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.sizeToFit()
    } // end of setup search bae
            
}





//MARK: - Extension "Protocols' functions"

extension homePageViewController : CollectionCellDelegator, handleRetrievedData, reloadResultsCollection, ResultCollectionCellDelegator, sendBackSelectedOptions {
    
    func retrievedcopyCategories(myData dataObject: [Category]) {
        self.categoriesCopy = dataObject
    }
    
    func sendCategories(categories dataobject: [String]) {
        self.filteredCategoriesName = dataobject
        self.tbleList.reloadData()
    }
    
    func callSegueFromCell(myData dataobject: Trademark) {
        self.performSegue(withIdentifier: "tradeInfo", sender:dataobject )
    } // end of 1 protocol function
    func reloadCollection() {
        resultCollectionViewController.collectionView.reloadData()
        resultCollectionViewController.offers = []
    } // end of 2 protocol function
    func retrievedCategories(myData dataObject: [Category]) {
        self.Categories = dataObject
    } // end of 3 protocol function
    func callSegueFromTradeCell(myData dataobject: Trademark) {
        self.performSegue(withIdentifier: "tradeInfo", sender: dataobject)
    } // end of 4 protocol function
    func reloadTable() {
        self.removeSpinner()
        self.tbleList.reloadData()
    } // end of 5 protocol function
    func selectedCategory(myData dataobject: [Trademark]) {
        self.performSegue(withIdentifier: "trademarks", sender: dataobject)
    } // end of 6 protocol function
    
    func handleDelegates(){
        resultCollectionViewController.delegate = self
        resultCollectionViewController.tradeDelegate = self
//        filterVC.delegate = self
//        filterVC.tableDelegate = self
        firstInitailizer.deleagte = self
        tbleList.dataSource = self
        tbleList.delegate = self
    }
    
}


//MARK: - Searchbar handling
extension homePageViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            reload(searchText)
    } // end of delegate function

        
    func reload(_ searchText: String?){
        guard searchBar.isActive else { return }
        guard let searchText = searchText else {
            resultCollectionViewController.trademarks = nil
            return }
        filteredData = []
        filteredTradeMarks = []
        var name = [String]()
        for i in Categories {
            let trades = i.trademarks ?? []
            for t in trades {
                name.append(t.BrandName ?? "")
            }
            filteredData = name.filter({$0.contains(searchText)})
            for i in filteredData {
                for t in trades {
                    if t.BrandName == i {
                        self.filteredTradeMarks.append(t)
                    } // Add filtered trademark to the array
                } // Iterate in filtered trades
            } // Iterate in filtered data
            resultCollectionViewController.trademarks = filteredTradeMarks
            resultCollectionViewController.delegate = self
        } // Iterate in each category
        
    } // end of filtering trademarks function
        
    func updateSearchResults(for searchController: UISearchController) {
        if searchBar.searchBar.searchTextField.isFirstResponder {
        searchBar.showsSearchResultsController = true
        } else {
        searchBar.searchBar.searchTextField.backgroundColor = nil
        }
    } // End of update results function
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resultCollectionViewController.trademarks = nil
        self.searchBar.searchBar.searchTextField.backgroundColor = nil
    } // end of handling cancel button function
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    } // end of search button function
        

}

//MARK: - Extension "Side menu setup"
extension homePageViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isMenuShow = false
        mainViewXConstraint.constant = 0
        rightBarButtonItem.tintColor = green
        UIView.animate(withDuration: 0.5, delay: 0.0,
        usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
        self.view.layoutIfNeeded()
        }, completion: nil)
    }
           
    @objc func menuTapped() {
        if isMenuShow {
            
            mainViewXConstraint.constant = 0
            rightBarButtonItem.tintColor = green
        } else {
            
            mainViewXConstraint.constant = -sideMenuWidth
            rightBarButtonItem.tintColor = green
        }
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
                       options: .curveEaseInOut, animations: {
                        self.view.layoutIfNeeded()
                        }, completion: nil)
               
        isMenuShow.toggle()
    }
    
    @objc func filterTapped() {
        self.performSegue(withIdentifier: "filter", sender: self)
    }
    
    @objc func menuButtonsActions(_ sender : UIButton) {
        if sender.tag == 10 {
            navigationController?.pushViewController(RegionViewController(), animated: true)
        }
        else if sender.tag == 11 {
            performSegue(withIdentifier: "toFamily", sender: self)
            //navigationController?.pushViewController(FamilyViewController(), animated: true)
        }
        else if sender.tag == 12 {
            performSegue(withIdentifier: "toFav", sender: self)
            // navigationController?.pushViewController(FavoriteViewController(), animated: true)
        }
        else if sender.tag == 13 {
            performSegue(withIdentifier: "toNewOffers", sender: self)
            //navigationController?.pushViewController(NewOffersViewController(), animated: true)
        }
        else if sender.tag == 14 {
            performSegue(withIdentifier: "toSuggest", sender: self)
            //navigationController?.pushViewController(SuggestOfferViewController(), animated: true)
        }
        else if sender.tag == 15 {
            performSegue(withIdentifier: "toVouchers", sender: self)
            //navigationController?.pushViewController(VouchersViewController(), animated: true)
        }
        else if sender.tag == 16 {
            performSegue(withIdentifier: "toCom", sender: self)
            //navigationController?.pushViewController(CommunicateUsViewController(), animated: true)
        }
        else if  sender.tag == 17 {
            logout()
        }
        mainViewXConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.0,
            usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
            options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
        isMenuShow = false
        rightBarButtonItem.tintColor = green
        }

}
