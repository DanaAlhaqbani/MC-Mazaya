//
//  WhoWeAreView.swift
//  MC Mazaya
//
//  Created by Ajwan Alshaye on 24/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class WhoWeAreView: UIViewController {

    @IBOutlet weak var Traddes: UILabel!
    @IBOutlet weak var Tradenum: UILabel!
    @IBOutlet weak var Trademail: UILabel!
    @IBOutlet weak var TraddesURl: UILabel!
    
    var Trade : Trademark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Traddes.text = Trade.description
        Tradenum.text = Trade.contactNum
        Trademail.text = Trade.email
        TraddesURl.text = Trade.webUrl
        
        
            }
    

   

}
