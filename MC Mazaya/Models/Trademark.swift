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
    var tradmarkID : String?
    init() {
        
    }
    
    public init(BrandName: String?, num: String?, desc: String?, email: String?, snapchat: String?, insta: String?, twit: String?, web: String?, imgURL : String?, backgroundImg: String?, branches: [Branch]?, offers : [String]?, views: Int?, isFeatured: Bool?, catID : String?, tradID : String? ) {
        self.trademarkName = BrandName
        self.branches = branches
        self.contactNum = num
        self.description = desc
        self.email = email
        self.snapchat = snapchat
        self.instagram = insta
        self.twitter = twit
        self.website = web
        self.imgURL = imgURL
        self.backgroundImg = backgroundImg
        self.offers = offers
        self.views = views
        self.isFeatured = isFeatured
        self.category = catID
        self.tradmarkID = tradID
    }
    
}


