//
//  seasonalOfferTableViewCell.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 09/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class seasonalOfferTableViewCell: UITableViewCell {

    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var offerDes: UILabel!
    @IBOutlet weak var brandName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
