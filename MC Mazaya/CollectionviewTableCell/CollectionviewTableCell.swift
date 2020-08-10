//
//  CollectionviewTableCell.swift
//  UICollectionViewInsideUitableViewCell
//
//  Created by Aman Aggarwal on 27/09/19.
//  Copyright © 2019 Aman Aggarwal. All rights reserved.
//

import UIKit

class CollectionviewTableCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var galleryCollectionView: UICollectionView!
    lazy var  infoArray = [Dictionary<String, Any>]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 200.0, height: 200.0)
        flowLayout.minimumInteritemSpacing = 1.0
        galleryCollectionView.collectionViewLayout = flowLayout
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        
        galleryCollectionView.dataSource = self
    }
    
    //MARK:- setUpDataSource
    func setUpDataSource() {
        self.galleryCollectionView.reloadData()
    }
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        let dict = infoArray[indexPath.item]
         cell.imgvAvatar.backgroundColor = UIColor.blue
        if let color = dict["color"] as? UIColor {
            cell.imgvAvatar.backgroundColor = color
        }
        return cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
