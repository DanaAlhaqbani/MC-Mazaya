//
//  Banner.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 10/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Firebase

class Banner {
    var bannerID: String
    var title: String
    var imageURL: String
    var type: String
    
    convenience init(snapshot: DataSnapshot) {
      self.init(id: snapshot.key, value: snapshot.value as! [String : Any])
    }
    
    init(id : String, value: [String: Any]) {
        self.bannerID = id
//        let value = value
        self.title = value["Title"] as! String
        self.imageURL = value["imageURL"] as? String ?? ""
        self.type = value["Type"] as! String
    }
}

extension Banner : Equatable {
    static func == (lhs: Banner, rhs: Banner) -> Bool {
        return lhs.bannerID == rhs.bannerID
    }
    
    
}
