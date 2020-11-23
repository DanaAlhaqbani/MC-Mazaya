//
//  region.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 08/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation

struct region {
    var latitude: String?
    var longitude: String?
    var trademarks: [String]?
    init(latitude: String?, longitude: String?, trademarks: [String]?) {
        self.latitude = latitude
        self.longitude = longitude
        self.trademarks = trademarks
    }
}
