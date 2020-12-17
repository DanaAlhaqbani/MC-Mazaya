//
//  UISetupExtension.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 27/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extension "setup userinterface"
extension homePageViewController {
    //MARK:  Setup User interface
    func setUpUI(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.navigationController?.navigationBar.barTintColor = .white
        sideMenuWidth = view.frame.width / 2
        view.addSubview(mainView)
        view.addSubview(sideMenu)
        sideMenu.addSubview(separatorView)
        sideMenu.addSubview(sideMenuStackView)
        sideMenuStackView.addArrangedSubview(MazayaLogoView)
        sideMenuStackView.addArrangedSubview(openRegionVC)
        sideMenuStackView.addArrangedSubview(openFavVC)
        sideMenuStackView.addArrangedSubview(openNewOffersVC)
        sideMenuStackView.addArrangedSubview(openSuggestVC)
        sideMenuStackView.addArrangedSubview(openHelpVC)
        sideMenuStackView.addArrangedSubview(openAboutVC)
        sideMenuStackView.addArrangedSubview(logoutVS)
//        leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterTapped))
        rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(menuTapped))
        rightBarButtonItem.tintColor = .white
//        leftBarButtonItem.tintColor = .white
//        navigationItem.rightBarButtonItem = leftBarButtonItem
        navigationItem.leftBarButtonItem = rightBarButtonItem
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
//            sideMenuStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            sideMenuStackView.leftAnchor.constraint(equalTo: separatorView.rightAnchor),
            sideMenuStackView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
//            sideMenuStackView.centerXAnchor.constraint(equalTo: sideMenu.centerXAnchor),
            sideMenuStackView.centerYAnchor.constraint(equalTo: sideMenu.centerYAnchor),
            openRegionVC.heightAnchor.constraint(equalToConstant: 40),
            MazayaLogoView.heightAnchor.constraint(equalToConstant: 110),
        ])
        mainViewXConstraint = mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        mainViewXConstraint.isActive = true
    } // end of setupUI
    
    //MARK: set up Searchbar
//    func setupSearchBar(){
//        
//        searchbar.delegate = self
////        navigationItem.searchController = self.searchBar
////        searchbar.searchBarStyle = .default
//        searchbar.placeholder = "ما الذي تبحث عنه ؟"
//        searchbar.semanticContentAttribute = .forceRightToLeft
//        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "إلغاء"
//        searchbar.searchTextField.semanticContentAttribute = .forceRightToLeft
//        searchbar.frame.size.height = 30
//        searchbar.searchTextField.addDoneButtonOnKeyboard()
//        searchbar.searchBarStyle = .minimal
//        searchbar.searchTextField.backgroundColor = UIColor(rgb: 0x218785)
//        searchbar.searchTextField.textColor = .white
//        searchbar.tintColor = .white
//        searchbar.searchTextField.tintColor = .white
//    } // end of setup search bae
    
//
        //MARK: set up Searchbar
        func setupSearchBar(){
            resultTableViewController = storyboard!.instantiateViewController(withIdentifier: "searchResults") as? searchResultTable
            searchBar = UISearchController(searchResultsController: resultTableViewController)
            searchBar.searchBar.delegate = self
            searchBar.obscuresBackgroundDuringPresentation = false
            searchBar.hideKeyboardWhenTappedAround()
            searchBar.hidesNavigationBarDuringPresentation = false
            searchBar.searchBar.frame.size.width = 50
            searchBar.searchBar.setImage(UIImage(named: "filter"), for: .bookmark, state: .normal)
            searchBar.searchBar.searchBarStyle = .default
            searchBar.searchBar.placeholder = "ما الذي تبحث عنه ؟"
            searchBar.searchBar.semanticContentAttribute = .forceRightToLeft
            searchBar.automaticallyShowsScopeBar = true
            searchBar.searchBar.tintColor = UIColor(rgb: 0x38a089)
            searchBar.automaticallyShowsCancelButton = false
            searchBar.searchBar.searchTextField.semanticContentAttribute = .forceRightToLeft
            searchBar.definesPresentationContext = true
            searchBar.searchResultsUpdater = self
            searchBar.searchBar.searchTextField.semanticContentAttribute = .forceRightToLeft
            searchBar.searchBar.searchTextField.backgroundColor = UIColor(rgb: 0x228986)
            searchBar.searchBar.setPlaceholder(textColor: .white)
           } // end of setup search bae

    func adjustSidemenue(_ userType: String){
        if userType == "موظف" {
            sideMenuStackView.insertArrangedSubview(openFamilyVC, at: 2)
            sideMenuStackView.insertArrangedSubview(openVouchersVC, at: 5)
        }
    }
}
