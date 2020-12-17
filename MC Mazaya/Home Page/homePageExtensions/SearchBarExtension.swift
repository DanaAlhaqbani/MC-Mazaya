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
        trademarksResults = []
        var names = [String]()
            for trade in tradesForRegion {
                names.append(trade.trademarkName ?? "")
            }
        filteredData = names.filter({$0.contains(searchText)}) .sorted { ($0.hasPrefix(searchText) ? 0 : 1) < ($1.hasPrefix(searchText) ? 0 : 1) }
            for i in filteredData {
                for trade in tradesForRegion {
                    if trade.trademarkName == i {
                        self.trademarksResults.append(trade)
                    } // Add filtered trademark to the array
                } // Iterate in filtered trades
            } // Iterate in filtered data
            resultTableViewController.trademarks = []
            resultTableViewController.areThereResults = false
            if trademarksResults.count != 0 {
                resultTableViewController.trademarks = trademarksResults
                resultTableViewController.areThereResults = true
            }
            resultTableViewController.delegate = self
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

