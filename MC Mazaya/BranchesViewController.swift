//
//  BranchesViewController.swift
//  MC
//
//  Created by Ajwan Alshaye on 07/01/1442 AH.
//  Copyright © 1442 Ajwan Alshaye. All rights reserved.
//

import UIKit

class BranchesViewController: UIViewController {

    
    
    @IBOutlet weak var BrancheName: UITextField!
    
    @IBOutlet weak var BranchNameLabel: UILabel!
    
    @IBOutlet weak var DescriptionBranchTxt: UITextField!
    
    @IBOutlet weak var DescriptionBranchLabel: UILabel!
    
    
    @IBOutlet weak var BranchLinkTxt: UITextField!
    
    @IBOutlet weak var BranchLinkLabel: UILabel!
    
    @IBOutlet weak var CancelButtton: UIButton!
    
    @IBOutlet weak var NextButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    func setUpElements(){
        // 
        
    Utilities.styleTextField(BrancheName)
      
    Utilities.styleTextField(DescriptionBranchTxt)
        
    Utilities.styleTextField(BranchLinkTxt)
        
    Utilities.styleFilledButton(NextButton)
        
    Utilities.styleHollowButton(CancelButtton)
        
        
        
        
    }


}
