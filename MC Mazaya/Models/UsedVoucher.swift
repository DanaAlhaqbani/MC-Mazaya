//
//  MyVoucher.swift
//  MC Mazaya
//
//  Created by Alhanouf alabdullah on 28/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct usedVoucher {
    var offerTitle: String?
    var voucherCode: String?
    var serviceType: String?
    var trademarkID: String?
    var voucherID : String?
    
    init(offerTitle: String?, voucherCode: String?, serviceType: String?, trademarkID: String?, voucherID: String?) {
        self.offerTitle = offerTitle
        self.voucherCode = voucherCode
        self.serviceType = serviceType
        self.trademarkID = trademarkID
        self.voucherID = voucherID
    }
    
    init(snap: DataSnapshot){
        self.init(offerTitle: snap.childSnapshot(forPath: "offerTitle").value as? String,
                  voucherCode: snap.childSnapshot(forPath: "voucherCode").value as? String,
                  serviceType: snap.childSnapshot(forPath: "serviceType").value as? String,
                  trademarkID: snap.childSnapshot(forPath: "trademarkID").value as? String,
                  voucherID: snap.key)
    }
}
