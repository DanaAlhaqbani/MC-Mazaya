//
//  Voucher.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 16/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation

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
    var branches: [String]?

    init(offerTitle: String?, offerDetails: String?, voucherCode: String?, numberOfCoupons: String?, numberOfPoints: String?, serviceType: String?, startDate: String?, endDate: String?, trademarkID: String?, branches: [String]?) {
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

    }
    
}