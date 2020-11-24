//
//  Trademark.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 06/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//
import Foundation
import UIKit
struct Trademark {

    var trademarkName : String?
    var branches : [Branch]?
    var contactNum : String?
    var description : String?
    var email : String?
    var snapchat : String?
    var instagram : String?
    var twitter : String?
    var website : String?
    var imgURL : String?
    var backgroundImg : String?
    var offers : [String]?
    var views : Int?
    var isFeatured : Bool?
    var category : String?
    var trademarkID : String?
    var serviceType: String?
    init() {
        
    }
    
    public init(trademarkName: String?, contactNum: String?, description: String?, email: String?, snapchat: String?, instagram: String?, twitter: String?, website: String?, imgURL : String?, backgroundImg: String?, branches: [Branch]?, offers : [String]?, views: Int?, isFeatured: Bool?, category : String?, trademarkID : String?, serviceType: String?) {
        self.trademarkName = trademarkName
        self.branches = branches
        self.contactNum = contactNum
        self.description = description
        self.email = email
        self.snapchat = snapchat
        self.instagram = instagram
        self.twitter = twitter
        self.website = website
        self.imgURL = imgURL
        self.backgroundImg = backgroundImg
        self.offers = offers
        self.views = views
        self.isFeatured = isFeatured
        self.category = category
        self.trademarkID = trademarkID
        self.serviceType = serviceType
    }
    
}


