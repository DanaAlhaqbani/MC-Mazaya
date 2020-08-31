//
//  CollectionviewTableCell.swift
//  UICollectionViewInsideUitableViewCell
//
//  Created by Aman Aggarwal on 27/09/19.
//  Copyright © 2019 Aman Aggarwal. All rights reserved.
//



import UIKit

class CollectionviewTableCell: UITableViewCell, UICollectionViewDataSource , UICollectionViewDelegate{

  var commodity = ""
    
    @IBOutlet weak var detailsTextView: UITextView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!

    
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    lazy var  infoArray = [Dictionary<String, Any>]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // commodity = Department5
        //detailsLabel.text = commodity
       // imageView2.image = UIImage(named: commodity)
       // imageView2.layer.cornerRadius = 10
       
        
      

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
//        cell.commodityLabel.text = imageNames[indexPath.row]
//        cell.commodityButton.tag = indexPath.row
//        cell.commodityButton.addTarget(self, action: #selector(btnSendQutation(sender:)), for: .touchUpInside)
        
        //cell.imgvAvatar = imageNames[indexPath.row]
        cell.imgvAvatar.tag = indexPath.row
       // cell.galleryCollectionView.addTarget(self, action: #selector(btnSendQutation(sender:)), for: .touchUpInside)
        
//
        let dict = infoArray[indexPath.item]
         cell.imgvAvatar.backgroundColor = UIColor.blue
        if let color = dict["color"] as? UIColor {
            cell.imgvAvatar.backgroundColor = color
        }
        return cell
    }
    
//    @objc private func btnSendQutation(sender:UIButton){
//        let sender = sender as! UIButton?
//        Department5 = imageNames[sender!.tag]
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let vc = UIStoryboard.instantiateViewController( withIdentifier : "DscriptionViewController") as? DscriptionViewController
//    }
    
}
