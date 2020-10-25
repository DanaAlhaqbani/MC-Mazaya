//
//  ProtocolsExtension.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 27/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extension "Protocols' functions"
extension homePageViewController : CollectionCellDelegator, handleRetrievedData, sendBackSelectedOptions, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, ResultCellDelegator, reloadResultsTable, sendSelectedRegionDelegate {
    func selectedRegion(myData dataObject: String) {
        self.selectedRegion = dataObject
    }
    
    
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
    func reloadResultTable() {
        resultTableViewController.tableView.reloadData()
        resultTableViewController.offers = []
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
//        resultCollectionViewController.delegate = self
//        resultCollectionViewController.tradeDelegate = self
//        filterVC.delegate = self
//        filterVC.tableDelegate = self
        firstInitailizer.deleagte = self
        tbleList.dataSource = self
        tbleList.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        getFav()
        let des = viewController as? DscriptionViewController
        if favouriteTrades.contains(where: {$0.BrandName == des?.tradeInfo.BrandName }) {
            des?.tradeInfo.isFav = true
            
        } else {
            des?.tradeInfo.isFav = false
        }
//        (viewController as? DscriptionViewController)?.isFavourite = isFavourite // Here you pass the to your original view controller
    }
    // UIPopoverPresentationControllerDelegate method
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Force popover style
        return UIModalPresentationStyle.currentContext
    }
    
}



