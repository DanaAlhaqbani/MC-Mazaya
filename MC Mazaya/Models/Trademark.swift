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

    var BrandName : String?
    var branches : [Branch]?
    var contactNum : String?
    var description : String?
    var email : String?
    var facebook : String?
    var instagram : String?
    var twitter : String?
    var webUrl : String?
    var brandImage : String?
    var offers : [Offer]?

    init() {
        
    }
    public init(BrandName: String?, num: String?, desc: String?, email: String?, fb: String?, insta: String?, twit: String?, web: String?, image : String?, branches: [Branch]?, offers : [Offer]?) {
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
        self.offers = offers
    }
    
}


