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
    func getTrademarks(){
        let tradeRef = Database.database().reference()
        tradeRef.child("Trademarks").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let trademark = Trademark(BrandName: snap.childSnapshot(forPath: "trademarkName").value as? String, num: snap.childSnapshot(forPath: "contactNum").value as? String, desc: snap.childSnapshot(forPath: "description").value as? String, email: snap.childSnapshot(forPath: "email").value as? String, snapchat: snap.childSnapshot(forPath: "snapchat").value as? String, insta: snap.childSnapshot(forPath: "instagram").value as? String, twit: snap.childSnapshot(forPath: "twitter").value as? String, web: snap.childSnapshot(forPath: "website").value as? String, imgURL: snap.childSnapshot(forPath: "imgURL").value as? String, backgroundImg: snap.childSnapshot(forPath: "backgroundImg").value as? String, branches: [], offers: [], views: 0, isFeatured: snap.childSnapshot(forPath: "isFeatured").value as? Bool , catID: snap.childSnapshot(forPath: "category").value as? String, tradID: snap.key)
                self.Trades.append(trademark)
            }
            self.tbleList.reloadData()
        })
    }
    
    //MARK: - Retrieve Categories
    func getCategories(){
        let categoriesRef = Database.database().reference()
        categoriesRef.child("Categories").observeSingleEvent(of: .value, with: { [self] snapshot in
            for child in snapshot.children {
                self.trademarksIDs = []
                let snap = child as! DataSnapshot
                let ids = snap.childSnapshot(forPath: "Trademarks")
                for child in ids.children {
                    let val = child as! DataSnapshot
                    self.trademarksIDs.append(val.key)
                }
                print(self.trademarksIDs)
                let category = Category(Name: ("\(snap.key)"), trademarks: self.trademarksIDs)
                self.Categories.append(category)
            }
            self.getTrademarks()
            if let vc = self.children[1] as? categoriesCollectionView {
                vc.categories = self.Categories
                
            }
            self.categoriesCollection?.categories = self.Categories
            self.categoriesCollection?.trademarks = self.Trades
            self.tbleList.reloadData()
        })
    }
    
    // MARK: -Filter trademarks based on category
    func filterTrademarks(_ indexPath: IndexPath){
        filteredTrademarks = []
        for trade in Trades {
            if trade.category == self.Categories[indexPath.row - 1].Name {
                self.filteredTrademarks.append(trade)
            }
        }
    }
    
    //MARK: - Filter featured trademarks
    func filterFeaturedTrademarks(){
        featuredTradeMarks = []
        for trade in Trades {
            if trade.isFeatured == true {
                self.featuredTradeMarks.append(trade)
            }
        }
    }
}
