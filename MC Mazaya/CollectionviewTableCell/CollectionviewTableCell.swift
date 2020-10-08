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
//    func convertrdTrades(myData dataObject: [Trademark]) {
//        self.Trades = dataObject
//    }
//
//
//    func reloadCollection() {
//        self.galleryCollectionView.reloadData()
//        self.galleryCollectionView.semanticContentAttribute = .forceRightToLeft
//    }
    
    var delegate : CollectionCellDelegator!
    var didSelectItemAction: ((IndexPath) -> Void)?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var allBtn : UIButton!
    var database: Database!
    var key1 = [Any]()
    var key2 : NSDictionary? = [:]
    var Name : Array<Any>!
    var ID : Array<Any>=[]
    var catId = String()
    var cat : NSDictionary = [:]
    var category : Category!
    var Trades = [Trademark]()
    var Offers = [Offer]()
    var branches = [Branch]()
    @IBAction func allBtn(_ sender: Any) {
            if self.delegate != nil {
                self.delegate.selectedCategory(myData: self.Trades)
        }
    }
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    lazy var  infoArray = [Any]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        allBtn.layer.cornerRadius = 5
        allBtn.clipsToBounds = true
//      self.firstInitializer.tradeMArksDelegate = self
//      galleryCollectionView.delegate = self
//      galleryCollectionView.dataSource = self
        // Initialization code
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 155.00, height: 155.00)
        flowLayout.minimumInteritemSpacing = 1.0
        galleryCollectionView.collectionViewLayout = flowLayout
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.semanticContentAttribute = .forceRightToLeft

    }
    
    

    
    //MARK:- setUpDataSource
    func setUpDataSource() {
        DispatchQueue.main.async {
            self.Offers = []
            self.galleryCollectionView.reloadData()
            self.galleryCollectionView.semanticContentAttribute = .forceRightToLeft
//            self.galleryCollectionView.scrollsToTop = true

        }
    }
    

    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Trades.count
    }
    
    
    var url = URL(string: "")
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
//        cell.imgvAvatar.image = UIImage()
        
        Trades = Trades.sorted {
        guard let first = $0.BrandName else {
            return false
        }
        guard let second = $1.BrandName else {
            return true
        }
        return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending }
        DispatchQueue.main.async {
            let imageURL = self.Trades[indexPath.row].brandImage
            cell.imgvAvatar.sd_setImage(with: URL(string: imageURL ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
            print()
            cell.imgvAvatar.clipsToBounds = true
            cell.imgvAvatar.layer.borderColor = UIColor.systemGray3.cgColor
            cell.imgvAvatar.layer.borderWidth = 0.3
            cell.imgvAvatar.layer.cornerRadius =  20
            cell.offerTitle.text = self.Trades[indexPath.row].BrandName
            self.Offers = self.Trades[indexPath.row].offers ?? []
            if self.Offers.count != 0 {
                cell.offerDetails.text = self.Offers[0].offerTitle
                
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
        
        if (self.delegate != nil) {
            self.delegate.callSegueFromCell(myData: Trades[indexPath.row])
            
        }
        
        
    }
    
    func getBigOffer(){
        
    }
    
}





