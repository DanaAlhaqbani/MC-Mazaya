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

    var commodity = ""
    var delegate : CollectionCellDelegator!
    @IBOutlet weak var detailsTextView: UITextView!
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

    @IBAction func allBtn(_ sender: Any) {
            if self.delegate != nil {
               print(self.Trades)
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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 120.00, height: 120.00)
        flowLayout.minimumInteritemSpacing = 1.0
        galleryCollectionView.collectionViewLayout = flowLayout
        galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        
    }
    
    
    
    
    
    
    //MARK:- setUpDataSource
    func setUpDataSource() {
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        getTrades()

    }
    
    
    //MARK:- UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Trades.count
    }
    
    
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        Trades = Trades.sorted {
            guard let first = $0.Name else {
                return false
            }
            guard let second = $1.Name else {
                return true
            }
            return first.localizedCaseInsensitiveCompare(second) == ComparisonResult.orderedAscending }
        cell.imgvAvatar.tag = indexPath.row
        cell.NameLabel.text = Trades[indexPath.row].Name
        let url = URL(string: Trades[indexPath.row].brandImage ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png" )
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
        cell.imgvAvatar.image = UIImage(named: "LogoMaz")
        cell.imgvAvatar.layer.cornerRadius =  20
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
        if (self.delegate != nil) {
            self.delegate.callSegueFromCell(myData: Trades[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                galleryCollectionView.dataSource = self
                galleryCollectionView.delegate = self
    }
    


    var Trades = [Trademark]()
    var currentTrade : Trademark!
    
    
    func getTrades(){
        self.key1 = [Any]()
        self.key2 = [:]
        self.ID = []
        self.Trades = []
        let ref = Database.database().reference()
        ref.child("Categories/\(catId)/TradeMarks").observeSingleEvent(of: .value, with: { (snap) in
            if let dict = snap.value as? [String : AnyObject] {
                self.cat = dict as NSDictionary
                for item in dict {
                    self.key1.append(item.key)
                }
                for i in self.key1 {
                    self.key2 = self.cat[i] as? NSDictionary
                    if (self.key2?["BrandName"] != nil) {
                        self.ID.append(i)
                        self.currentTrade = Trademark(key: i as? String, name: self.key2?["BrandName"] as? String, link: self.key2?["BranchLink"] as? String, branchName: self.key2?["BrancheName"] as? String, num: self.key2?["Contact Number"] as? String, desc: self.key2?["Description"] as? String, email: self.key2?["Email"] as? String, fb: self.key2?["Facebook"] as? String, insta: self.key2?["Instagram"] as? String, twit: self.key2?["Twitter"] as? String, web: self.key2?["WebURl"] as? String, image: self.key2?["BrandImage"] as? String)
                        self.Trades.append(self.currentTrade)
                    }
                }
            }
                self.galleryCollectionView.reloadData()
        })

    }

    
}





