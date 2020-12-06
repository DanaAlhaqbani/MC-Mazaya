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
    
    //MARK: -Retrieve Trademarks
    func getTrademarks(_ region: String){
        self.Trades = []
        self.filteredTradeMarks = []
        self.featuredTradeMarks = []
        let tradeRef = Database.database().reference()
        let regionRef = Database.database().reference()
        
        if region == "الكل" {
            tradeRef.child("Trademarks").observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let trademark = Trademark(snap: snap)
                    self.Trades.append(trademark)
                }
                self.filterFeaturedTrademarks()
                self.tbleList.reloadData()
            })
        } else {
            self.Trades = []
            self.filteredTradeMarks = []
            regionRef.child("Regions").queryOrderedByKey().queryEqual(toValue: region).observeSingleEvent(of: .value, with: { snapshot in
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let trademarksIDs = snap.childSnapshot(forPath: "Trademarks")
                    for id in trademarksIDs.children {
                        let tradeSnap = id as! DataSnapshot
                        let tradeID = tradeSnap.key
                        tradeRef.child("Trademarks").observeSingleEvent(of: .value, with: { snapshot in
                            for child in snapshot.children {
                                let snap = child as! DataSnapshot
                                if snap.key ==  tradeID {
                                    let trademark = Trademark(snap: snap)
                                    self.Trades.append(trademark)
                                }
                                self.filterFeaturedTrademarks()
                                self.tbleList.reloadData()
                            }
                        })
                    }
                }
                self.tbleList.reloadData()
            })
        }
        
        
    }
    
    //MARK: - Retrieve Categories
    func getCategories(_ region: String){
        // Cleaning categories array to deny reductions each time the function called
        self.Categories = []
        // Create reference to categories from database
        let categoriesRef = Database.database().reference()
        
        categoriesRef.child("Categories").observeSingleEvent(of: .value, with: { [self] snapshot in
            for child in snapshot.children {
                // Clean trademarks IDs array to deny reductions
                self.trademarksIDs = []
                // Create instance of snapshot child to access its snapshot children
                let snap = child as! DataSnapshot
                let ids = snap.childSnapshot(forPath: "Trademarks")
                for child in ids.children {
                    let val = child as! DataSnapshot
                    self.trademarksIDs.append(val.key)
                } // End of iteration over all trademarks Ids
                // Create instance of each category
                let category = Category(Name: ("\(snap.key)"), trademarks: self.trademarksIDs, containsTrademarksAtUserRegion: false)
                if category.trademarks?.count != 0 {
                    self.Categories.append(category)
                } // End of checking if the category has a trademark, to deny adding empty categories
                
            } // End of iteration over all categories
            self.getTrademarks(region)
            if let vc = self.children[1] as? categoriesCollectionView {
                vc.categories = self.Categories
            }
            self.categoriesCollection?.categories = self.Categories
            self.categoriesCollection?.trademarks = self.Trades
            self.tbleList.reloadData()
        }) // End of observation inside Categories child
    }
    
    // MARK: -Filter trademarks based on category
    func filterTrademarks(_ indexPath: IndexPath){
        // Cleaning the filtered trademarks to deny reductions each time we call the function
        filteredTrademarks = []
        for trade in Trades {
            if self.featuredTradeMarks.count == 0 {
                if trade.category == self.Categories[indexPath.row].Name {
                    self.filteredTrademarks.append(trade)
                    self.Categories[indexPath.row].containsTrademarksAtUserRegion = true
                } // Add categories to tableview at the top without "Featured Trademarks" cell
            } else {
                if trade.category == self.Categories[indexPath.row - 1].Name {
                    self.filteredTrademarks.append(trade)
                    self.Categories[indexPath.row - 1].containsTrademarksAtUserRegion = true
                }
            } // Add categories to table view cells after "Featured Trademarks" cell
        } // End of iteration over all trademarks
    } // End of filtering Trademarks based on their category
    
    //MARK: - Filter featured trademarks
    func filterFeaturedTrademarks(){
        // Cleaning the featured trademarks to deny reductions each time we call the function
        featuredTradeMarks = []
        for trade in Trades {
            if trade.isFeatured == true {
                // Add trademark to featured trademarks
                self.featuredTradeMarks.append(trade)
            } // End of checking if the trademark is featured
        } // End of iteration over all trademarks
    } // End of filtering Featured Trademarks
    
//    func filterCategories(){
//        self.filteredCategories = []
//        for category in Categories {
//            if category.containsTrademarksAtUserRegion == true {
//                self.filteredCategories.append(category)
//            }
//        }
//        print(filteredCategories)
//    }
    
}
