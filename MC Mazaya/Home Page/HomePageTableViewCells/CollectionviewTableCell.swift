//
//  CollectionviewTableCell.swift
//  UICollectionViewInsideUitableViewCell
//
//  Created by Alhanouf khalid on 04/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//


import Firebase
import FirebaseDatabase
import FirebaseAuth
import UIKit
import SDWebImage

protocol CollectionCellDelegator {
    func callSegueFromCell(myData dataobject: Trademark)
    func selectedCategory(myData dataobject: [Trademark])
}


class CollectionviewTableCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate {
    
    var delegate : CollectionCellDelegator!
    var didSelectItemAction: ((IndexPath) -> Void)?
    @IBOutlet weak var nameLabel: UILabel!
    //    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var allBtn : UIButton!
    var catId = String()
    var category : Category!
    var Trades = [Trademark]()
    //    var filteredTrades = [Trademark]()
    
    
    @IBAction func allBtn(_ sender: Any) {
        if self.delegate != nil {
            self.delegate.selectedCategory(myData: self.Trades)
        }
    }
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    lazy var  infoArray = [Any]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        allBtn.layer.cornerRadius = 10
        allBtn.clipsToBounds = true
        //        allBtn.layer.borderWidth = 1.00
        //        allBtn.layer.borderColor = UIColor(rgb: 0x75E5CE).cgColor
        
        // Initialization code
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 65 , height: 65)
        //        flowLayout.minimumInteritemSpacing = 0.4
        galleryCollectionView.collectionViewLayout = flowLayout
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.semanticContentAttribute = .forceRightToLeft
        galleryCollectionView.layer.backgroundColor = UIColor(rgb: 0xFAFAFA).cgColor
        galleryCollectionView.layer.shadowColor = UIColor.systemGray5.cgColor
        galleryCollectionView.layer.cornerRadius = 20
        galleryCollectionView.layer.shadowOpacity = 0.5
        galleryCollectionView.layer.shadowRadius = 2.0
        galleryCollectionView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        galleryCollectionView.layer.masksToBounds = false
        galleryCollectionView.clipsToBounds = true
        //        galleryCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }
    
    
    
    
    //MARK:- setUpDataSource
    func setUpDataSource() {
        DispatchQueue.main.async {
            self.galleryCollectionView.reloadData()
            self.galleryCollectionView.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Trades.count > 0 {
            return Trades.count
        } else {
            return 5
        }
    }
    
    
    var url = URL(string: "")
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        //        if Trades[indexPath.row].category == catId {
        cell.featured.alpha = 0
        cell.imgvAvatar.layer.cornerRadius =  cell.imgvAvatar.frame.size.height / 2
        cell.imgvAvatar.clipsToBounds = true
        DispatchQueue.main.async {
            if self.Trades.count != 0 {
                let imageURL = self.Trades[indexPath.row].imgURL ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"
                cell.imgvAvatar.sd_setImage(with: URL(string: imageURL))
                if self.Trades[indexPath.row].isFeatured == true {
                    cell.featured.alpha = 0.8
                    cell.featured.rotate()
                }
            } 
        }
        //        }
        
        Trades = Trades.sorted {
            guard let first = $0.trademarkName else {
                return false
            }
            guard let second = $1.trademarkName else {
                return true
            }
            return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
        //        self.key2 = [:]
        //        self.key1 = []
        //        if (self.delegate != nil) {
        //            let ref = Database.database().reference()
        //            ref.child("Categories/\(catId)/TradeMarks").observeSingleEvent(of: .value, with: { (snapshot) in
        //                if let dict = snapshot.value as? [String : AnyObject] {
        //                    self.trade = dict as NSDictionary
        //                for i in dict {
        //                    self.key1.append(i.key)
        //                }
        //                for key in self.key1 {
        //                    self.key2 = self.trade[key] as! NSDictionary
        //                    if self.key2["BrandName"] as? String == self.Trades[indexPath.row].trademarkName {
        ////                        (self.key2["Views"]) as! Int += 1
        //                        var views = self.key2["Views"] as? Int ?? 0
        //                        views += 1
        //                        ref.child("Categories/\(self.catId)/TradeMarks/\(key)/Views").setValue(views)
        //                        }
        //                    }
        //                }
        //            })
        if self.delegate != nil {
            self.delegate.callSegueFromCell(myData: Trades[indexPath.row])
        }
        //        }
    }
    
}





