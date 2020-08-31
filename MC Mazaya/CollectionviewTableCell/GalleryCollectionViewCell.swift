//
//  GalleryCollectionViewCell.swift
//  UICollectionViewInsideUitableViewCell
//
//  Created by Aman Aggarwal on 27/09/19.
//  Copyright © 2019 Aman Aggarwal. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgvAvatar: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var percent: UILabel!
    
//    @objc private func btnSendQutation(sender:UIButton){
//        let sender = sender as! UIButton?
//        imgvAvatar = imageNames[sender!.tag]
//    }

   

    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        
       
        
    }

}


////////

//extension GalleryCollectionViewCell: UICollectionViewDelegate , UICollectionViewDataSource {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let vc = storyboard.instantiateViewController( withIdentifier : "DscriptionViewController") as? DscriptionViewController
//    }
//
//
//
//
//}
