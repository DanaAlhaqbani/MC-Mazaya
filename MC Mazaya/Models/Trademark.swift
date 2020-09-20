//
//  Trademark.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 06/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//
import Foundation
struct Trademark {

    var BrandName : String?
//    var branchLink : String?
    var branches : [String: Any]?
    var contactNum : String?
    var description : String?
    var email : String?
    var facebook : String?
    var instagram : String?
    var twitter : String?
    var webUrl : String?
    var brandImage : String?
    var offerTitle : String?
    var offerType : String?
    var offersDetails : String?
    var numberOfCoupons : Int?
    var numberOfPoints : Int?
    var serviceType : String?
    var endDate : String?
    var startDate : String?
    
    public init(BrandName: String?, num: String?, desc: String?, email: String?, fb: String?, insta: String?, twit: String?, web: String?, image : String?, branches: [String: Any]?, offerTitle : String?, offerType : String?, offerDetails : String?, numberOfCoupons: Int?, numberOfPoints : Int?, serviceType : String?, endDate : String?, startDate : String?) {
        self.BrandName = BrandName
        self.branches = branches
        self.contactNum = num
        self.description = desc
        self.email = email
        self.facebook = fb
        self.instagram = insta
        self.twitter = twit
        self.webUrl = web
        self.brandImage = image
        self.offerTitle = offerTitle
        self.offerType = offerType
        self.offersDetails = offerDetails
        self.numberOfCoupons = numberOfCoupons
        self.numberOfPoints = numberOfPoints
        self.serviceType = serviceType
        self.endDate = endDate
        self.startDate = startDate
    }
    
}
