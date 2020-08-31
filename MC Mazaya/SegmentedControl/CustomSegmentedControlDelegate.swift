//
//  CustomSegmentedControlDelegate.swift
//  MC Mazaya
//
//  Created by ALHANOUF  on 8/30/20.
//  Copyright © 2020 MC. All rights reserved.
//

protocol CustomSegmentedControlDelegate:  class {
    func changeToIndex(index:Int)
    
    
}

weak var delegate: CustomSegmentedControlDelegate?

