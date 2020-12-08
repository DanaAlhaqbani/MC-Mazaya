//
//  retrieveFunctions.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 07/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import FirebaseDatabase
import UIKit

extension homePageViewController {
    
    // MARK: -Filter trademarks based on category
    func filterTrademarks(_ indexPath: IndexPath){
        // Cleaning the filtered trademarks to deny reductions each time we call the function
        filteredTrademarks = []
        for trade in Trades {
            if self.featuredTradeMarks.count == 0 {
                if trade.category == self.filteredCategories[indexPath.row] {
                    self.filteredTrademarks.append(trade)
                    //                    self.Categories[indexPath.row].containsTrademarksAtUserRegion = true
                } // Add categories to tableview at the top without "Featured Trademarks" cell
            } else {
                if trade.category == self.filteredCategories[indexPath.row - 1] {
                    self.filteredTrademarks.append(trade)
                    //                    self.Categories[indexPath.row - 1].containsTrademarksAtUserRegion = true
                }
            } // Add categories to table view cells after "Featured Trademarks" cell
        } // End of iteration over all trademarks
    } // End of filtering Trademarks based on their category
    
    //MARK: - Filter featured trademarks
    func filterFeaturedTrademarks(){
        // Cleaning the featured trademarks to deny reductions each time we call the function
        featuredTradeMarks = []
        for trade in tradesForRegion {
            if trade.isFeatured == true {
                // Add trademark to featured trademarks
                self.featuredTradeMarks.append(trade)
            } // End of checking if the trademark is featured
        } // End of iteration over all trademarks
    } // End of filtering Featured Trademarks
    
    // MARK: - Retrieve all trademarks and filtering them
    func retrieveTrades(_ region: String){
        // Clean arrays to prevent reduction
        self.Trades = []
        self.tradesForRegion = []
        self.filteredTrademarks = []
        self.filteredCategories = []
        // Create references to roots
        let tradeRef = Database.database().reference().child("Trademarks")
        let regionRef = Database.database().reference().child("Regions")
        // Observe all children inside Trademarks root
        tradeRef.observeSingleEvent(of: .value, with: { snapshot in
            // Iterate over all children and create instance of each child
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                // Create object of each trademark and append it to Trademarks Array
                let trademark = Trademark(snap: snap)
                self.Trades.append(trademark)
                // Check user region - If it's ALL, display all trademarks, otherwise filter trademarks based on the region
                if region == "الكل" {
                    self.tradesForRegion = self.Trades
                } else {
                    // Observe all children inside Regions root
                    regionRef.observeSingleEvent(of: .value, with: { snapshot in
                        // Clean filtered Trademarks based on region
                        self.tradesForRegion = []
                        for child in snapshot.children {
                            self.tradesForRegion = []
                            let regionSnap = child as! DataSnapshot
                            let regionTrademarks = regionSnap.childSnapshot(forPath: "Trademarks")
                            // Iterate over all Trademarks IDs stored under each region
                            for id in regionTrademarks.children {
                                let snapID = id as! DataSnapshot
                                let tradeKey = snapID.key
                                // Iterate over all trademarks
                                for trade in self.Trades {
                                    // Check if the trademark ID exist under region and add it to the filtered trademarks
                                    if trade.trademarkID == tradeKey {
                                        self.tradesForRegion.append(trade)
                                    } // End of checking
                                } // End of iterate over all trademarks
                            } // End of iterate over all Trademark IDs
                        } // End of iterate over all regions
                        // Filter featured trademark
                        self.filterFeaturedTrademarks()
                        self.tbleList.reloadData()
                    }) // End of observation
                    self.tbleList.reloadData()
                } // End of handling trademarks if the region not ALL
            } // End of iterate over all Trademarks root children
            self.filterCategories()
            self.filterFeaturedTrademarks()
            self.tbleList.reloadData()
        }) // End of observation for Trademarks root
    } // End of retrieve Trademarks function
    

    
    //MARK: - Filter categories based on user region
    func filterCategories(){
        // Clean categories to prevent reduction
        self.filteredTrademarks = []
        // Creat reference to categories root
        let catRef = Database.database().reference().child("Categories")
        // Observe children inside categories root
        catRef.observeSingleEvent(of: .value, with: { snapshot in
            // Iterate over all children
            for child in snapshot.children {
                // Create instance of single child to access its children
                let snap = child as! DataSnapshot
                // Assign key of category "which is its name" to a variable
                let catName = snap.key
                // Iterate over all region trademarks to add only the categories with trademarks in this region
                for trade in self.tradesForRegion {
                    if catName == trade.category {
                        self.filteredCategories.append(catName)
                    } // End of check category name
                } // End of iteration over trademarks
            } // End of iteration over all children
            // Send the filtered categories to the bar of categories existing in home page "as a container view"
            if let vc = self.children[1] as? categoriesCollectionView {
                vc.categories = self.filteredCategories
                vc.trademarks = self.Trades
            }
            // Pass categories and filtered Trademarks to the categories class
            self.categoriesCollection?.categories = self.filteredCategories
            self.categoriesCollection?.trademarks = self.Trades
            self.tbleList.reloadData()
        }) // End of observation over categories root
    } // End of filtering Categories function
    
    
    
} // End of the class
