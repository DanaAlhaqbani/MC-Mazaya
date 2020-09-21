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
    var key: String?
    var trademarks : [Trademark]?
    
    public init(Name : String?, key : String?, trademarks: [Trademark]?) {
        self.Name = Name
        self.key = key
        self.trademarks = trademarks
    }
    
}

    



