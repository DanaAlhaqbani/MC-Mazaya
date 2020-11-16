//
//  TeeestTableViewCell.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 23/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundViewe: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    var Title = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gradientLoading(view: backgroundViewe)

    }


}
