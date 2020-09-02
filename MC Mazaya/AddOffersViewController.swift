//
//  AddOffersViewController.swift
//  MC
//
//  Created by Ajwan Alshaye on 08/01/1442 AH.
//  Copyright © 1442 Ajwan Alshaye. All rights reserved.
//

import UIKit

class AddOffersViewController: UIViewController {

    @IBOutlet weak var fromStackView: UIStackView!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//from line 20 to 31 it's only constraints for StackView a long with scrollview
        self.scrollview.addSubview(fromStackView)
       
        
        self.fromStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.fromStackView.leadingAnchor.constraint(equalTo: self.scrollview.leadingAnchor).isActive = true
        
        self.fromStackView.trailingAnchor.constraint(equalTo: self.scrollview.trailingAnchor).isActive = true
        
        self.fromStackView.topAnchor.constraint(equalTo: self.scrollview.topAnchor).isActive = true
        
        self.fromStackView.bottomAnchor.constraint(equalTo:self.scrollview.bottomAnchor).isActive = true
        
        self.fromStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        
        
        
    }
    


}
