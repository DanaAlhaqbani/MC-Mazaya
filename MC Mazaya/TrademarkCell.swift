//
//  TrademarkCell.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 21/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class TrademarkCell: UITableViewCell {

    @IBOutlet weak var trademarkView: UIView!
    @IBOutlet weak var trademarkImage: UIImageView!
    @IBOutlet weak var trademarkName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        print(nam)

        // Configure the view for the selected state
    }

}
