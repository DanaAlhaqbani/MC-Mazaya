//
//  Offer.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 03/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation

struct Offer {
    var DiscountCode : String?
    var numberOfCoupons : Int?
    var numberOfPoints : Int?
    var offerType : String?
    var offerDiscription : String?
    var offersDetails : String?
    var offerTitle : String?
    var serviceType : String?
    var endDate : String?
    var startDate : String?
    
    init(discountCode : String?, numberOfCoupons : Int?, numberOfPoints : Int?, offerType : String?, offerDiscription : String?, offersDetails : String?, offerTitle: String?, serviceType : String?, endDate : String?, startDate : String?) {
        self.DiscountCode = discountCode
        self.numberOfCoupons = numberOfCoupons
        self.numberOfPoints = numberOfPoints
        self.offerType = offerType
        self.offerDiscription = offerDiscription
        self.offersDetails = offersDetails
        self.offerTitle = offerTitle
        self.serviceType = serviceType
        self.endDate = endDate
    }
}
