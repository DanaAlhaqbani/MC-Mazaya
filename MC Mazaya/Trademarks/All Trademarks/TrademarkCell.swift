//
//  TrademarkCell.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 21/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

protocol MyCellDelegate: AnyObject {
    func btnTapped(cell: TrademarkCell)
}

class TrademarkCell: UITableViewCell {

    @IBOutlet weak var trademarkView: UIView!
    @IBOutlet weak var trademarkImage: UIImageView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var trademarkName: UILabel!
    weak var delegate: MyCellDelegate?
    var favDict : NSDictionary = [:]
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var Des: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func starPressed(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.btnTapped(cell: self)
        }
    }


}
    
    

