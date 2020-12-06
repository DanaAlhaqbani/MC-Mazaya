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
        self.ref.child("Users/\(uid!)/FavoriteTradeMarks").observeSingleEvent(of: .value, with: { (snap) in
            if let dict = snap.value as? [String : Any] {
                for i in dict {
                    let key = i.key
                    self.ref.child("Users/\(self.uid!)/FavoriteTradeMarks/\(key)").removeValue()
                }
            }
        })
        if let delegate = self.delegate {
            delegate.btnTapped(cell: self)
        }
//        for trade in favDict {
//            print(trademarkName.text!)
//            print(trade.value)
//            if trade.value as? String == self.trademarkName.text {
//                self.ref.child("Users/\(uid!)/FavoriteTradeMarks/\(trade.key)").removeValue()
//                self.ref.child("Users/\(uid!)/FavoriteTradeMarks").observeSingleEvent(of: .value, with: {(snap) in
//                    if let dict = snap.value as? NSDictionary {
//                        self.favDict = dict
//                    }
//                })
//                if let delegate = self.delegate {
//                    delegate.btnTapped(cell: self)
//                }
//            }
//        }
    }


}
    
    

