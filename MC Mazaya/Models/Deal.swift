//
//  Deals.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 08/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import Firebase

struct Deal {
    var discountCode : String?
    var offerDetails : String?
    var offerTitle : String?
    var serviceType : String?
    var endDate : String?
    var startDate : String?
    var trademarkID: String?
    var userType: String?
    var usageType : String?
    var branches : [String]?
    var trademark: Trademark?
    
     init(discountCode : String?, offerDetails : String?, offerTitle: String?, serviceType : String?, endDate : String?, startDate : String?, trademarkID: String?, userType: String?, usageType: String?, branches: [String]?, trademark: Trademark?) {
        self.discountCode = discountCode
        self.offerDetails = offerDetails
        self.offerTitle = offerTitle
        self.serviceType = serviceType
        self.endDate = endDate
        self.startDate = startDate
        self.trademarkID = trademarkID
        self.userType = userType
        self.usageType = usageType
        self.branches = branches
        self.trademark = trademark
    }
    
    init(snapshot: DataSnapshot, trademark: Trademark) {
        self.init(discountCode: snapshot.childSnapshot(forPath: "discountCode").value as? String, offerDetails: snapshot.childSnapshot(forPath: "offerDetails").value as? String, offerTitle: snapshot.childSnapshot(forPath: "offerTitle").value as? String, serviceType: snapshot.childSnapshot(forPath: "serviceType").value as? String, endDate: snapshot.childSnapshot(forPath: "endDate").value as? String, startDate: snapshot.childSnapshot(forPath: "startDate").value as? String, trademarkID: snapshot.childSnapshot(forPath: "trademarkID").value as? String, userType: snapshot.childSnapshot(forPath: "userType").value as? String, usageType: snapshot.childSnapshot(forPath: "usageType").value as? String, branches: snapshot.childSnapshot(forPath: "branches").value as? [String], trademark: trademark)
    }
    
}
