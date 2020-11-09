//
//  categoriesCollectionView.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 28/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class categoriesCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var categories = [Category]()
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
        if categories.count != 0 {
                    cell.name.text = categories[indexPath.row].Name
                    if cell.name.text == "الأغذية" {
                        cell.icon.image = UIImage(named: "Restaurants")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color: UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "السفر" {
                        cell.icon.image = UIImage(named: "Travel")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color:  UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "الرياضة" {
                        cell.icon.image = UIImage(named: "sports")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color:  UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "المنزل" {
                        cell.icon.image = UIImage(named: "Home-1")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color:  UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "الكترونيات" {
                        cell.icon.image = UIImage(named: "Electronics")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color:  UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "خدمات" {
                        cell.icon.image = UIImage(named: "Services")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color:  UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "السيارات" {
                        cell.icon.image = UIImage(named: "Cars")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color: UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "التسوق" {
                        cell.icon.image = UIImage(named: "Clothes")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color: UIColor(rgb: 0x38A089))
                    }
                    if cell.name.text == "المدارس" {
                        cell.icon.image = UIImage(named: "Schools")
//                        cell.icon.image = cell.icon.image?.imageWithColor(color: UIColor(rgb: 0x38A089))
                    }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.parent?.performSegue(withIdentifier: "toCategory", sender: categories[indexPath.row])
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
//        print("-----------------------------")
//        print(categories.count)
    }
    
}
