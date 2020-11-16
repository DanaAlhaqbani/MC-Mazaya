//
//  WhoWeAreView.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 24/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class VoucherInfo: UIViewController {
    
    @IBOutlet weak var Traddes: UILabel!
    @IBOutlet weak var Tradenum: UILabel!
    @IBOutlet weak var Trademail: UILabel!
    @IBOutlet weak var TraddesURl: UILabel!
    @IBOutlet weak var instagram: UIButton!
    @IBOutlet weak var Twitter: UIButton!
    @IBOutlet weak var facebook: UIButton!
    
    var Trade : Trademark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Traddes.text = Trade.description
        Tradenum.text = Trade.contactNum
        Trademail.text = Trade.email
        TraddesURl.text = Trade.webUrl
        TraddesURl.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelClicked(_:)))
        TraddesURl.addGestureRecognizer(guestureRecognizer)
        
    }
    
    @objc func labelClicked(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: Trade.webUrl ?? "")! as URL ,options: [:],completionHandler: nil)
        
    }
    @IBAction func instagram(_ sender: Any) {
        
        if Trade.instagram != ""{
            let insta = Trade.instagram
            
            UIApplication.shared.open(URL(string: "https://www.instagram.com/\(Trade.instagram ?? "https://www.instagram.com")/")! as URL ,options: [:],completionHandler: nil)
        }}
    
    @IBAction func Twitter(_ sender: Any) {
        
        if Trade.twitter != ""{
            let insta = Trade.twitter
            
            UIApplication.shared.open(URL(string: "https://twitter.com/\(Trade.twitter ?? "https://twitter.com")/")! as URL ,options: [:],completionHandler: nil)
        }}
    
    
    @IBAction func FaceBook(_ sender: Any) {
        if Trade.facebook != ""{
            let insta = Trade.twitter
            
            UIApplication.shared.open(URL(string: "https://www.snapchat.com/add/\(Trade.facebook ?? "https://www.snapchat.com/add/")/")! as URL ,options: [:],completionHandler: nil)
        }
        
    }
    
    
    
    
}