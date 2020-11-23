//
//  RegionTableViewCell.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 01/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class RegionTableViewCell: UITableViewCell {
    @IBOutlet weak var regionImage: UIImageView!
    
    @IBOutlet weak var regionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        regionName.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
