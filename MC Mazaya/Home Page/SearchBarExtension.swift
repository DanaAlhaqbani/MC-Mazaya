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
//            reload(searchText)
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
