//
//  Trademark.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 06/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//
import Foundation
struct Trademark {

    var key: String?
    var Name : String?
    var branchLink : String?
    var branchName : String?
    var contactNum : String?
    var description : String?
    var email : String?
    var facebook : String?
    var instagram : String?
    var twitter : String?
    var webUrl : String?
    var brandImage : String?

    public init(key: String?, name: String?, link: String?, branchName: String?, num: String?, desc: String?, email: String?, fb: String?, insta: String?, twit: String?, web: String?, image : String?) {
        self.key = key
        self.Name = name
        self.branchLink = link
        self.branchName = branchName
        self.contactNum = num
        self.description = desc
        self.email = email
        self.facebook = fb
        self.instagram = insta
        self.twitter = twit
        self.webUrl = web
        self.brandImage = image
    }
    
}
