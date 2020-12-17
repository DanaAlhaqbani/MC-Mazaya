//
//  Offer.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 03/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import Firebase

struct Offer {
    var discountCode : String?
    var offersDetails : String?
    var offerTitle : String?
    var serviceType : String?
    var endDate : String?
    var startDate : String?
    var trademarkID: String?
    var userType: String?
    var usageType : String?
    var branches : [Branch]?
    var trademark: Trademark?

    public init(discountCode : String?, offersDetails : String?, offerTitle: String?, serviceType : String?, endDate : String?, startDate : String?, trademarkID: String?, userType: String?, usageType: String?, branches: [Branch]?) {
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
    
    public init(discountCode : String?, offersDetails : String?, offerTitle: String?, serviceType : String?, endDate : String?, startDate : String?, trademarkID: String?, userType: String?, usageType: String?, branches: [Branch]?, trademark: Trademark?) {
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
        self.trademark = trademark
    }
    
    public init(snap: DataSnapshot, trademark: Trademark){
        let branches = trademark.branches
        self.init(discountCode: snap.childSnapshot(forPath: "discountCode").value as? String,
                  offersDetails: snap.childSnapshot(forPath: "offerDetails").value as? String,
                  offerTitle: snap.childSnapshot(forPath: "offerTitle").value as? String,
                  serviceType: snap.childSnapshot(forPath: "serviceType").value as? String,
                  endDate: snap.childSnapshot(forPath: "endDate").value as? String,
                  startDate: snap.childSnapshot(forPath: "startDate").value as? String,
                  trademarkID: snap.childSnapshot(forPath: "trademarkID").value as? String,
                  userType: snap.childSnapshot(forPath: "userType").value as? String,
                  usageType: snap.childSnapshot(forPath: "usageType").value as? String,
                  branches: branches, trademark: trademark)
    }
    
    public init(snap: DataSnapshot){
        self.init(discountCode: snap.childSnapshot(forPath: "discountCode").value as? String,
                  offersDetails: snap.childSnapshot(forPath: "offerDetails").value as? String,
                  offerTitle: snap.childSnapshot(forPath: "offerTitle").value as? String,
                  serviceType: snap.childSnapshot(forPath: "serviceType").value as? String,
                  endDate: snap.childSnapshot(forPath: "endDate").value as? String,
                  startDate: snap.childSnapshot(forPath: "startDate").value as? String,
                  trademarkID: snap.childSnapshot(forPath: "trademarkID").value as? String,
                  userType: snap.childSnapshot(forPath: "userType").value as? String,
                  usageType: snap.childSnapshot(forPath: "usageType").value as? String,
                  branches: snap.childSnapshot(forPath: "branches").value as? [Branch])
    }
    
    
    
}
