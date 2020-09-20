//
//  CollectionviewTableCell.swift
//  UICollectionViewInsideUitableViewCell
//
//  Created by Aman Aggarwal on 27/09/19.
//  Copyright © 2019 Aman Aggarwal. All rights reserved.
//


import Firebase
import UIKit


protocol CollectionCellDelegator {
    func callSegueFromCell(myData dataobject: Trademark)
    func selectedCategory(myData dataobject: [Trademark])
}


class CollectionviewTableCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate{

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
            self.convertToTrades()
        }
    }
    

    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Trades.count
    }
    
    
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        Trades = Trades.sorted {
        guard let first = $0.BrandName else {
            return false
        }
        guard let second = $1.BrandName else {
            return true
        }
        return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending }
        DispatchQueue.main.async {
            

        cell.imgvAvatar.tag = indexPath.row
            cell.percent.text = self.Trades[indexPath.row].offerTitle ?? ""
            let url = URL(string: self.Trades[indexPath.row].brandImage ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png" )
            if url != nil {
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error != nil {
                        print("Error: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    DispatchQueue.main.async {
                        cell.imgvAvatar.image = UIImage(data: data!)
                    }
                }).resume()
            }
        cell.imgvAvatar.clipsToBounds = true
        cell.imgvAvatar.image = UIImage(named: "whiteBG")
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
    

    


    var Trades = [Trademark]()
    var currentTrade : Trademark!
    var tradeDict : [String : Any]!
    var tradeInfo : NSDictionary!
    
    func convertToTrades(){
        self.tradeInfo = [:]
        self.Trades = []
        if tradeDict != nil {
            for i in tradeDict.values {
                self.tradeInfo = i as? NSDictionary
                self.currentTrade = Trademark(BrandName: self.tradeInfo?["BrandName"] as? String, num: self.tradeInfo?["Contact Number"] as? String, desc: self.tradeInfo?["Description"] as? String, email: self.tradeInfo?["Email"] as? String, fb: self.tradeInfo?["Facebook"] as? String, insta: self.tradeInfo?["Instagram"] as? String, twit: self.tradeInfo?["Twitter"] as? String, web: self.tradeInfo?["WebURl"] as? String, image: self.tradeInfo?["BrandImage"] as? String, branches: self.tradeInfo?["Branches"] as? [String : Any], offerTitle: self.tradeInfo?["OffersDescription"] as? String, offerType: self.tradeInfo?["offerType"] as? String, offerDetails: self.tradeInfo?["offerDetails"] as? String,numberOfCoupons: self.tradeInfo?["numberOfCoupons"] as? Int, numberOfPoints: self.tradeInfo?["numberOfPoints"] as? Int, serviceType: self.tradeInfo?["serviceType"] as? String, endDate: self.tradeInfo?["endDate"] as? String, startDate: self.tradeInfo?["startDate"] as? String)
                self.Trades.append(self.currentTrade)
            }
        }
        self.galleryCollectionView.reloadData()
    }
    
    
}





