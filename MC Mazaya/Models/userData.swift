//
//  userDict.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 04/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

//struct userData {
//    var name: String?
//    var email: String?
//    var gender: String?
//    var phone: String?
//    var points: String?
//    var familyList: [String]?
//    var region = "الكل"
//    var userType = ""
//    var uid : String?
//
//    init(name: String?, email: String?, gender: String?, phone: String?, points: String?, familyList: [String]?, region: String?, userType: String?, uid: String?) {
//        self.name = name
//        self.email = email
//        self.gender = gender
//        self.phone = phone
//        self.points = points
//        self.familyList = familyList
//        self.region = region
//        self.userType = userType
//        self.uid = uid
//    }
//
//}

struct userData {
    static var name = ""
    static var email = ""
    static var password = ""
    static var gender = ""
    static var phone = ""
    static var points = ""
    static var family = [String]()
    static var region = "الكل"
    static var userType = ""
    static var myVouchers = [usedVoucher]()
}

