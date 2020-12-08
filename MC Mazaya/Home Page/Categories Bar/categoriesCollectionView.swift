//
//  categoriesCollectionView.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 28/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit



class categoriesCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var categories = [String]()
    {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
//    var filtered
    
    var trademarks = [Trademark]()
    var filteredTrademarks = [Trademark]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories.count > 0 {
            return categories.count
        } else {
            return 6
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! categoryCollectionViewCell
        self.filterCategoryTrades(indexPath)
        if categories.count != 0 {
            cell.name.textColor = UIColor(rgb: 0x00524D)
            cell.name.text = categories[indexPath.row]
            if cell.name.text == "الاغذية" {
                cell.icon.image = UIImage(named: "Restaurants")
            }
            if cell.name.text == "السفر" {
                cell.icon.image = UIImage(named: "Travel")
            }
            if cell.name.text == "الصحة واللياقة" {
                cell.icon.image = UIImage(named: "sports")
            }
            if cell.name.text == "المنزل" {
                cell.icon.image = UIImage(named: "Home-1")
            }
            if cell.name.text == "الإلكترونيات" {
                cell.icon.image = UIImage(named: "Electronics")
            }
            if cell.name.text == "الخدمات" {
                cell.icon.image = UIImage(named: "Services")
            }
            if cell.name.text == "السيارات" {
                cell.icon.image = UIImage(named: "Cars")
            }
            if cell.name.text == "التسوق" {
                cell.icon.image = UIImage(named: "Clothes")
            }
            if cell.name.text == "المدارس" {
                cell.icon.image = UIImage(named: "Schools")
            }
        } else {
            cell.name.textColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.filterCategoryTrades(indexPath)
        print(filteredTrademarks)
        self.parent?.performSegue(withIdentifier: "toCategory", sender: filteredTrademarks)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "categoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 60, height: 65)
        flowLayout.minimumInteritemSpacing = 1.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func filterCategoryTrades(_ index: IndexPath){
        self.filteredTrademarks = []
        for trade in trademarks {
            if trade.category == categories[index.row] {
                self.filteredTrademarks.append(trade)
            }
        }
    }

    
}
