//
//  searchResultsCell.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 05/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class searchResultsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    
    var trades : [Trademark]!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resultsCollectionView.register(UINib(nibName: "singleTrademarkResult", bundle: nil), forCellWithReuseIdentifier: "singleTrademarkResult")
        resultsCollectionView.delegate = self
        resultsCollectionView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trades.count
    }
    func reloadCollection(){
        self.resultsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleTrademarkResult", for: indexPath) as! singleTrademarkResult
        let imageURL = self.trades[indexPath.row].brandImage
        cell.tradeLogo.sd_setImage(with: URL(string: imageURL ?? ""))
        cell.offerTitle.text = trades[indexPath.row].BrandName
        
        return cell
    }
    
}
