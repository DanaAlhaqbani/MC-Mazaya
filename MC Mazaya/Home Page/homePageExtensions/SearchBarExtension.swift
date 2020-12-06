//
//  SearchBarExtension.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 27/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Searchbar handling
extension homePageViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        reload(searchText)
    } // end of delegate function

        
    func reload(_ searchText: String?){
        guard searchBar.isActive else { return }
        guard let searchText = searchText else {
            resultTableViewController.trademarks = nil
            return }
        filteredData = []
        filteredTradeMarks = []
        let name = [String]()
        for i in Categories {
            let trades = i.trademarks ?? []
            for _ in trades {
//                name.append(t.trademarkName ?? "")
            }
            filteredData = name.filter({$0.contains(searchText)})
            for _ in filteredData {
                for _ in trades {
//                    if t.trademarkName == i {
//                        self.filteredTradeMarks.append(t)
//                    } // Add filtered trademark to the array
                } // Iterate in filtered trades
            } // Iterate in filtered data
            resultTableViewController.trademarks = []
            resultTableViewController.areThereResults = false
            if filteredTradeMarks.count != 0 {
                resultTableViewController.trademarks = filteredTradeMarks
                resultTableViewController.areThereResults = true
            }
            resultTableViewController.delegate = self
        } // Iterate in each category

    } // end of filtering trademarks function
    
        
    func updateSearchResults(for searchController: UISearchController) {
        if searchBar.searchBar.searchTextField.isFirstResponder && searchBar.searchBar.searchTextField.text != "" {
        searchBar.showsSearchResultsController = true
        } else {
        searchBar.showsSearchResultsController = false
        }
    } // End of update results function
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        resultCollectionViewController.trademarks = nil
        searchBar.resignFirstResponder()
    } // end of handling cancel button function
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    } // end of search button function
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.tbleList.isUserInteractionEnabled = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tbleList.isUserInteractionEnabled = true
        self.searchBar.dismissKeyboard()
    }
//    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//        navigationItem.titleView?.endEditing(true)
//        navigationItem.titleView?.resignFirstResponder()
//    }
    


}

