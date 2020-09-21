//
//  Branch.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 03/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation


struct Branch {
    var BranchLink : String?
    var BrancheName : String?
    var DescriptionBranch : String?
    
    init(BranchLink : String? , BrancheName : String?, DescriptionBranch : String? ) {
        self.BranchLink = BranchLink
        self.BrancheName = BrancheName
        self.DescriptionBranch = DescriptionBranch
    }
    
}
