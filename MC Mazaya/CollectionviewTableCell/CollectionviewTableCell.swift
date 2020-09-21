//
//  CollectionviewTableCell.swift
//  UICollectionViewInsideUitableViewCell
//
//  Created by Alhanouf Khalid on 21/09/20.
//  Copyright © 2020 Alhanouf Khalid. All rights reserved.
//


import Firebase
import UIKit
import SDWebImage

protocol CollectionCellDelegator {
    func callSegueFromCell(myData dataobject: Trademark)
    func selectedCategory(myData dataobject: [Trademark])
}


class CollectionviewTableCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate {
    func convertrdTrades(myData dataObject: [Trademark]) {
        self.Trades = dataObject
    }
    
    
    func reloadCollection() {
        self.galleryCollectionView.reloadData()
    }
    
    let firstInitializer = firstViewController()
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
//        self.firstInitializer.tradeMArksDelegate = self
//        galleryCollectionView.delegate = self
//        galleryCollectionView.dataSource = self
        // Initialization code
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150.00, height: 150.00)
        flowLayout.minimumInteritemSpacing = 1.0
        galleryCollectionView.collectionViewLayout = flowLayout
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
    }
    
    

    
    //MARK:- setUpDataSource
    func setUpDataSource() {
        DispatchQueue.main.async {
            self.galleryCollectionView.reloadData()
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
            cell.percent.text = self.Trades[indexPath.row].BrandName ?? ""
            let imageURL = self.Trades[indexPath.row].brandImage
            cell.imgvAvatar.sd_setImage(with: URL(string: imageURL ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
            cell.imgvAvatar.clipsToBounds = true
            cell.imgvAvatar.layer.cornerRadius =  20
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
        
        if (self.delegate != nil) {
            self.delegate.callSegueFromCell(myData: Trades[indexPath.row])
        }
        
    }

    // function to convert image url into UIImage
    
    
    
}





