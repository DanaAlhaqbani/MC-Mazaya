//
//  Category.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 14/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import Firebase

struct Category {
    
    
    var Name : String?
    var trademarks : [String]?
    var containsTrademarksAtUserRegion: Bool?
    // Array of strings
    
    public init(Name : String?, trademarks: [String]?, containsTrademarksAtUserRegion: Bool?) {
        self.Name = Name
        self.trademarks = trademarks
        self.containsTrademarksAtUserRegion = containsTrademarksAtUserRegion
    }
    
}

    



