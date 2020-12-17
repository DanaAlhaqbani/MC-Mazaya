//
//  Branch.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 03/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import Firebase

struct Branch {
    var branchName: String?
    var description: String?
    var latitude : String?
    var longitude : String?
    var region: String?
//    var tradeMArks
    init(branchName : String? , description : String?, latitude : String?, longitude: String?, region: String?) {
        self.branchName = branchName
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.region = region
    }
    
    init(snap: DataSnapshot){
        self.init(branchName : snap.childSnapshot(forPath: "branchName").value as? String,
                  description : snap.childSnapshot(forPath: "description").value as? String,
                  latitude : snap.childSnapshot(forPath: "latitude").value as? String,
                  longitude: snap.childSnapshot(forPath: "longitude").value as? String,
                  region:snap.childSnapshot(forPath: "region").value as? String)
    }
    
    
}
