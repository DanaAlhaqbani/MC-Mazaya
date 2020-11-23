//
//  Deals.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 08/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation

struct Deals {
    var discountCode : String?
    var offersDetails : String?
    var offerTitle : String?
    var serviceType : String?
    var endDate : String?
    var startDate : String?
    var trademarkID: String?
    var userType: String?
    var usageType : String?
    var branches : [String]?

    init(discountCode : String?, offersDetails : String?, offerTitle: String?, serviceType : String?, endDate : String?, startDate : String?, trademarkID: String?, userType: String?, usageType: String?, branches: [String]?) {
        self.discountCode = discountCode
        self.offersDetails = offersDetails
        self.offerTitle = offerTitle
        self.serviceType = serviceType
        self.endDate = endDate
        self.startDate = startDate
        self.trademarkID = trademarkID
        self.userType = userType
        self.usageType = usageType
        self.branches = branches
    }
}
