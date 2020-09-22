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

class homePageViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, CollectionCellDelegator, handleRetrievedData, UISearchBarDelegate {

     //MARK: - Protocols' functions
    func callSegueFromCell(myData dataobject: Trademark) {
        self.performSegue(withIdentifier: "disc", sender:dataobject )
    }
    func retrievedCategories(myData dataObject: [Category]) {
        self.Categories = dataObject
    }
    func reloadTable() {
        self.removeSpinner()
        self.tbleList.reloadData()
    }
    func selectedCategory(myData dataobject: [Trademark]) {
        self.performSegue(withIdentifier: "trademarks", sender: dataobject)
    }
    
    //MARK: - Lets
    let searchBar = UISearchController(searchResultsController: nil)
    let user = Auth.auth().currentUser
    let green = UIColor(rgb: 0x38a089)
    let firstInitailizer = launchViewController()

    //MARK: - Vars
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var SideMenu: SideMenuNavigationController?
    var rightBarButtonItem = UIBarButtonItem()
    var mainViewXConstraint : NSLayoutConstraint!
    var sideMenuWidth = CGFloat()
    var isMenuShow = false
    var Categories = [Category]()
    var Trades = [Trademark]()
    var filteredData = [Category]()
    //MARK: - Outlets
    @IBOutlet weak var tbleList: UITableView!
    
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        firstInitailizer.deleagte = self
        self.searchBar.searchBar.delegate = self
        self.navigationItem.searchController = self.searchBar
        self.searchBar.searchBar.searchBarStyle = .prominent
        self.searchBar.searchBar.placeholder = "ما الذي تبحث عنه ؟"
        self.searchBar.searchBar.semanticContentAttribute = .forceRightToLeft
        dataUser()
        setUpUI()
        tbleList.register(UINib(nibName: "CollectionviewTableCell", bundle: nil), forCellReuseIdentifier: "CollectionviewTableCell")
        tbleList.dataSource = self
        tbleList.delegate = self
        tbleList.separatorStyle = .none
        if let cell = tbleList.dequeueReusableCell(withIdentifier: "CollectionviewTableCell") as? CollectionviewTableCell {
            cell.setUpDataSource()
        }
    }
    
    
    //MARK: - Side Menu Code
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
            // navigationController?.pushViewController(CommunicateUsViewController(), animated: true)
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
        if searchBar.isActive == true && searchBar.searchBar.text != "" {
            return filteredData.count
        }
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionviewTableCell", for: indexPath) as! CollectionviewTableCell
        if searchBar.isActive == true && searchBar.searchBar.text != "" {

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
        cell.Trades = self.Categories[indexPath.row].trademarks ?? []
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
        
        if segue.identifier == "disc" {
            let dis = segue.destination as! DscriptionViewController
            dis.tradeInfo = sender as? Trademark
        } // Show Description Segue
        
        if segue.identifier == "trademarks" {
                let dis = segue.destination as! TrademarkTableVC
                dis.trades = sender as? [Trademark] ?? []
            
        } // Show Trademarks Segue
    } // Prepare Function
    
    
    
    
    //MARK: - Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = Categories
//        for c in Categories {
//
//        }
        self.tbleList.reloadData()
    }
    
    
} // Class end




extension homePageViewController {
       
      
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

                                 
                                 rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(menuTapped))
                                 rightBarButtonItem.tintColor = green
                                 navigationItem.rightBarButtonItem = rightBarButtonItem
                               
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
                    
                    }
    
    
    
   }

extension UITableView {

    func indicatorView() -> UIActivityIndicatorView{
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 40)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.isHidden = false
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            activityIndicatorView.isHidden = true
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        } else {
            return activityIndicatorView
        }
    }

    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }

        indicatorView().isHidden = false
    }

    func stopLoading(){
        indicatorView().stopAnimating()
        indicatorView().isHidden = true
    }


}

