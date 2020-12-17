//
//  Voucher.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 16/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import Firebase

struct Voucher {
    var offerTitle: String?
    var offerDetails: String?
    var voucherCode: String?
    var numberOfCoupons: String?
    var numberOfPoints: String?
    var serviceType: String?
    var startDate: String?
    var endDate: String?
    var trademarkID: String?
    var branches: [Branch]?
    var trademark: Trademark?
    var voucherID : String?
    init(offerTitle: String?, offerDetails: String?, voucherCode: String?, numberOfCoupons: String?, numberOfPoints: String?, serviceType: String?, startDate: String?, endDate: String?, trademarkID: String?, branches: [Branch]?, trademark: Trademark?, voucherID: String?) {
        self.offerTitle = offerTitle
        self.offerDetails = offerDetails
        self.voucherCode = voucherCode
        self.numberOfCoupons = numberOfCoupons
        self.numberOfPoints = numberOfPoints
        self.serviceType = serviceType
        self.startDate = startDate
        self.endDate = endDate
        self.trademarkID = trademarkID
        self.branches = branches
        self.trademark = trademark
        self.voucherID = voucherID
    }
    
    init(snap: DataSnapshot, trademark: Trademark){
        let branches = trademark.branches
        self.init(offerTitle: snap.childSnapshot(forPath: "offerTitle").value as? String,
                  offerDetails: snap.childSnapshot(forPath: "offerDetails").value as? String,
                  voucherCode: snap.childSnapshot(forPath: "voucherCode").value as? String,
                  numberOfCoupons: snap.childSnapshot(forPath: "numberOfCoupons").value as? String,
                  numberOfPoints: snap.childSnapshot(forPath: "numberOfPoints").value as? String,
                  serviceType: snap.childSnapshot(forPath: "serviceType").value as? String,
                  startDate: snap.childSnapshot(forPath: "startDate").value as? String,
                  endDate: snap.childSnapshot(forPath: "endDate").value as? String,
                  trademarkID: snap.childSnapshot(forPath: "trademarkID").value as? String,
                  branches: branches, trademark: trademark, voucherID: snap.key)
    }
}
