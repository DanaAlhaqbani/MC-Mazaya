//
//  CollectionviewTableCell.swift
//  UICollectionViewInsideUitableViewCell
//
//  Created by Alhanouf khalid on 04/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//


import Firebase
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
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var allBtn : UIButton!
    var database: Database!
    var key1 = [Any]()
    var key2 : NSDictionary = [:]
    var Name : Array<Any>!
    var ID : Array<Any>=[]
    var catId = String()
    var cat : NSDictionary = [:]
    var category : Category!
    var Trades = [Trademark]()
    var Offers = [Offer]()
    var branches = [Branch]()
    var filteredServiceType = [String]()
    var sortedBy : String?
    var filteredTrades = [Trademark]()
    var trade : NSDictionary = [:]
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
        self.sortedBy = nil
        // Initialization code
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 98, height: 98)
        flowLayout.minimumInteritemSpacing = 1.0
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
        return Trades.count
    }
    
    
    var url = URL(string: "")
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        
        Trades = Trades.sorted {
            guard let first = $0.BrandName else {
                return false
            }
            guard let second = $1.BrandName else {
                return true
            }
            return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending
        }
        
        if self.sortedBy != nil {
            if self.sortedBy == "الأكثر مشاهدة" {
                self.Trades = self.Trades.sorted(by: {$1.views ?? 0 < $0.views ?? 0 })
            } else if self.sortedBy == "مميز" {
//                self.Trades = self.Trades.sorted(by: {})
            } else if self.sortedBy == "قريب مني" {
                
            }
        }
        DispatchQueue.main.async {
            let imageURL = self.Trades[indexPath.row].brandImage
            cell.imgvAvatar.sd_setImage(with: URL(string: imageURL ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
            cell.imgvAvatar.clipsToBounds = true
//            cell.imgvAvatar.layer.borderColor = UIColor.systemGray3.cgColor
//            cell.imgvAvatar.layer.borderWidth = 0.3
            cell.imgvAvatar.layer.cornerRadius =  20
//            cell.offerTitle.text = self.Trades[indexPath.row].BrandName
//            cell.offerDetails.text = ""
            if let o = self.Trades[indexPath.row].offers {
                self.Offers = o
                if self.Offers.count != 0 {
//                    cell.offerDetails.text = self.Offers[0].offerTitle
                }
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
        self.key2 = [:]
        self.key1 = []
        if (self.delegate != nil) {
            let ref = Database.database().reference()
            ref.child("Categories/\(catId)/TradeMarks").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String : AnyObject] {
                    self.trade = dict as NSDictionary
                for i in dict {
                    self.key1.append(i.key)
                }
                for key in self.key1 {
                    self.key2 = self.trade[key] as! NSDictionary
                    if self.key2["BrandName"] as? String == self.Trades[indexPath.row].BrandName {
//                        (self.key2["Views"]) as! Int += 1
                        var views = self.key2["Views"] as? Int ?? 0
                        views += 1
                        ref.child("Categories/\(self.catId)/TradeMarks/\(key)/Views").setValue(views)
                        }
                    }
                }
            })
            self.delegate.callSegueFromCell(myData: Trades[indexPath.row])
            
        }
    }

}





