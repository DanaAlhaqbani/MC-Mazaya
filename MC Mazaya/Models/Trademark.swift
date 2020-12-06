//
//  Trademark.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 06/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//
import Firebase
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
    
    init(snap: DataSnapshot){
        self.init(trademarkName: snap.childSnapshot(forPath: "trademarkName").value as? String,
                  contactNum: snap.childSnapshot(forPath: "contactNum").value as? String,
                  description: snap.childSnapshot(forPath: "description").value as? String,
                  email: snap.childSnapshot(forPath: "email").value as? String,
                  snapchat: snap.childSnapshot(forPath: "snapchat").value as? String,
                  instagram: snap.childSnapshot(forPath: "instagram").value as? String,
                  twitter: snap.childSnapshot(forPath: "twitter").value as? String,
                  website: snap.childSnapshot(forPath: "website").value as? String,
                  imgURL: snap.childSnapshot(forPath: "imgURL").value as? String,
                  backgroundImg: snap.childSnapshot(forPath: "backgroundImg").value as? String,
                  branches: [], offers: [], views: 0,
                  isFeatured: snap.childSnapshot(forPath: "isFeatured").value as? Bool ,
                  category: snap.childSnapshot(forPath: "category").value as? String,
                  trademarkID: snap.key,
                  serviceType: snap.childSnapshot(forPath: "serviceType").value as? String)
    }
    
}


