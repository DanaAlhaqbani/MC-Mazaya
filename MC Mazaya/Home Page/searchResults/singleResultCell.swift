//
//  singleResultCell.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 04/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class singleResultCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var tradeName: UILabel!
    @IBOutlet weak var tradeDes: UILabel!
    @IBOutlet weak var trademarkView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
