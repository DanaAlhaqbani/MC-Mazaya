//
//  categoryCollectionViewCell.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 28/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class categoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.textColor = UIColor(rgb: 0x38A089)
        icon.image = icon.image?.withTintColor(UIColor(rgb: 0x5AC5BE))
    }

}
