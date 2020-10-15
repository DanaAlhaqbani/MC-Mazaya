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
        sideMenuStackView.addArrangedSubview(openFamilyVC)
        sideMenuStackView.addArrangedSubview(openFavVC)
        sideMenuStackView.addArrangedSubview(openNewOffersVC)
        sideMenuStackView.addArrangedSubview(openSuggestVC)
        sideMenuStackView.addArrangedSubview(openVouchersVC)
        sideMenuStackView.addArrangedSubview(openHelpVC)
        sideMenuStackView.addArrangedSubview(logoutVS)
        leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(filterTapped))
        rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu"), style: .plain, target: self, action: #selector(menuTapped))
        rightBarButtonItem.tintColor = .white
        leftBarButtonItem.tintColor = .white
        rightBarButtonItem.width = 35
        leftBarButtonItem.width = 35
        navigationItem.rightBarButtonItem = leftBarButtonItem
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
            sideMenuStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            sideMenuStackView.leftAnchor.constraint(equalTo: separatorView.rightAnchor),
            sideMenuStackView.widthAnchor.constraint(equalToConstant: sideMenuWidth),
            openRegionVC.heightAnchor.constraint(equalToConstant: 40),
            MazayaLogoView.heightAnchor.constraint(equalToConstant: 110),
        ])
        mainViewXConstraint = mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        mainViewXConstraint.isActive = true
    } // end of setupUI
    
    //MARK: set up Searchbar
    func setupSearchBar(){
//        resultCollectionViewController = storyboard!.instantiateViewController(withIdentifier: "searchResults") as? searchResult
//        searchBar = UISearchController(searchResultsController: resultCollectionViewController)
        
        searchbar.delegate = self
        navigationItem.searchController = self.searchBar
        searchbar.searchBarStyle = .default
        searchbar.placeholder = "ما الذي تبحث عنه ؟"
        searchbar.semanticContentAttribute = .forceRightToLeft
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "إلغاء"
        searchbar.searchTextField.semanticContentAttribute = .forceRightToLeft
//        searchBar.definesPresentationContext = true
//        searchBar.searchResultsUpdater = self
//        searchBar.searchBar.searchTextField.tintColor = .white
//        searchBar.searchBar.searchTextField.textColor = .white


    } // end of setup search bae
    
//
//        func setupSearchBar(){
//            resultCollectionViewController = storyboard!.instantiateViewController(withIdentifier: "searchResults") as? searchResult
//            searchBar = UISearchController(searchResultsController: resultCollectionViewController)
//
//            searchBar.searchBar.delegate = self
//            searchBar.obscuresBackgroundDuringPresentation = false
//    //        searchBar.searchBar.showsSearchResultsButton = true
//    //        searchBar.searchBar.showsBookmarkButton = true
//    //        searchBar.searchBar.setImage(UIImage(named: "filter"), for: .bookmark, state: .normal)
//            navigationItem.searchController = self.searchBar
//    //        searchBar.searchBar.searchBarStyle = .minimal
//            searchBar.searchBar.frame.size.width = 50
//    //        searchBar.searchBar.but
//    //        searchBar.searchBar.searchBarStyle = .default
//            searchBar.searchBar.placeholder = "ما الذي تبحث عنه ؟"
//            searchBar.searchBar.semanticContentAttribute = .forceRightToLeft
//    //        searchBar.automaticallyShowsScopeBar = false
//            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "إلغاء"
//            searchBar.searchBar.tintColor = UIColor.white
//            searchBar.searchBar.searchTextField.semanticContentAttribute = .forceRightToLeft
//            searchBar.definesPresentationContext = true
//            searchBar.searchResultsUpdater = self
//    //        searchBar.searchBar.searchTextField.tintColor = .white
//    //        searchBar.searchBar.searchTextField.textColor = .white
//
//
//        } // end of setup search bae
}
