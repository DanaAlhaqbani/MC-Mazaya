//
//  CustomCells.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 25/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//
import UIKit
class CustomCellS: UICollectionViewCell {
    
    
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var scoreBackView: UIView!

    @IBOutlet weak var sectionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 15
        scoreBackView.layer.cornerRadius = 15
    }
    
}
