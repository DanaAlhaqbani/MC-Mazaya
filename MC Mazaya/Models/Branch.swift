//
//  Branch.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 03/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation


struct Branch {
    var branchName: String?
    var description: String?
    var latitude : String?
    var longitude : String?
    var region: String?
    
    init(branchName : String? , description : String?, latitude : String?, longitude: String?, region: String?) {
        self.branchName = branchName
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.region = region
    }
    
}
