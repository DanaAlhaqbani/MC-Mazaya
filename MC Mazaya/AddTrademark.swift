//
//  ViewController.swift
//  MC
//
//  Created by Ajwan Alshaye on 05/01/1442 AH.
//  Copyright © 1442 Ajwan Alshaye. All rights reserved.
//

import UIKit




 
 
class AddTrademark: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var BrandName: UITextField!
    
    
    @IBOutlet weak var BrandNameLabel: UILabel!
    
 
    @IBOutlet weak var UploadImage: UIButton!
    
    @IBOutlet weak var UploadBackground: UIButton!

    @IBOutlet weak var Description :UILabel!
    @IBOutlet weak var DescriptionTxt: UITextField!
    
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var Number: UILabel!
    
    
    @IBOutlet weak var NumberTxt: UITextField!
    
    
    @IBOutlet weak var EmailTxt: UITextField!
    
    
    @IBOutlet weak var WebURlTxt: UITextField!
    
     override func viewDidLoad() {
           super.viewDidLoad()
    
           // Do any additional setup after loading the view, typically from a nib.
        setUpElements()
    
        
    

}
    
    
    func setUpElements(){
        
    Utilities.styleTextField(BrandName)
      
    Utilities.styleTextField(DescriptionTxt)
        
    Utilities.styleTextField(NumberTxt)

    Utilities.styleTextField(EmailTxt)
        
    Utilities.styleTextField(WebURlTxt)
        
    Utilities.styleHollowButton(CancelButton)
        
    Utilities.styleFilledButton(NextButton)
        
        
     /*
       let text = "  الأسم التجاري * "
              let range = (text as NSString).range(of: "*")
              let attributedString = NSMutableAttributedString(string:text)
              attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
                  //Apply to the label brandname
                  BrandNameLabel.attributedText = attributedString;
        
      
        */
        
   
        
}//setelments
   
   
    
    @IBAction func NextButtonClicked(_ sender: Any) {
        
    }
    
   
}

    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


