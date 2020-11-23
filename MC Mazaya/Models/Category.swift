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
    // Array of strings
    
    public init(Name : String?, trademarks: [String]?) {
        self.Name = Name
        self.trademarks = trademarks
    }
    
}

    



