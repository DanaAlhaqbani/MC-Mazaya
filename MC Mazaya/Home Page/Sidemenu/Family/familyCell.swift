//
//  familyCell.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 03/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class familyCell: UITableViewCell {

    @IBOutlet weak var familyView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
