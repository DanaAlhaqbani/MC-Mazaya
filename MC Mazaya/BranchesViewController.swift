//
//  BranchesViewController.swift
//  MC
//
//  Created by Ajwan Alshaye on 07/01/1442 AH.
//  Copyright © 1442 Ajwan Alshaye. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class BranchesViewController: UIViewController {

  
   
    var   Branches = [String:String]()
   
    
    @IBOutlet weak var BrancheName: UITextField!
    
    @IBOutlet weak var BranchNameLabel: UILabel!
    
    @IBOutlet weak var DescriptionBranchTxt: UITextField!
    
    @IBOutlet weak var DescriptionBranchLabel: UILabel!
    
    @IBOutlet weak var BranchLinkTxt: UITextField!
    
    @IBOutlet weak var BranchLinkLabel: UILabel!
    
    @IBOutlet weak var CancelButtton: UIButton!
    
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var InformUser: UILabel!
    
    
     var ref : DatabaseReference?
      var myindex = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 ref = Database.database().reference()
        setUpElements()
       
        print("BranchesViewController key : ", AddTrademark.key)
         
    }
    
    
    func setUpElements(){
        // 
        
    Utilities.styleTextField(BrancheName)
      
    Utilities.styleTextField(DescriptionBranchTxt)
        
    Utilities.styleTextField(BranchLinkTxt)
        
    Utilities.styleFilledButton(NextButton)
        
    Utilities.styleHollowButton(CancelButtton)
        
        
        
        
    }
  
   
    
    func AddBranches()  {
        
        
              Branches = ["BrancheName":BrancheName.text! ,"DescriptionBranch": DescriptionBranchTxt.text! ,"BranchLink":BranchLinkTxt.text! ]
         
               
//        ref?.child("Categories").child(AddTrademark.categoryName).child("TradeMarks").child(AddTrademark.key).child("Branches").child("\(self.index+1)").updateChildValues(Branches)
        
       
        ref?.child("Categories").child(AddTrademark.categoryName).child("TradeMarks").child(AddTrademark.key).child("Branches").child("\(myindex)").setValue(Branches)
        
        
             }
 
    
    
    
    @IBAction func ListOfBranches(_ sender: Any) {
        
        AddBranches()
        myindex += 1
        
    BrancheName.text! = ""
    DescriptionBranchTxt.text! = ""
    BranchLinkTxt.text! = ""
        
        InformUser.text="تم اضافة من الفروع \(myindex)"
        
     //let MoreBranches = ["BrancheName":BrancheName.text! ,"DescriptionBranch": DescriptionBranchTxt.text! ,"BranchLink":BranchLinkTxt.text! ]
        
      //  ref?.child("Categories").child(AddTrademark.categoryName).child("TradeMarks").child(AddTrademark.key).child("Branches").child("\(myindex)").updateChildValues(MoreBranches)
        
       // ref?.child("Categories").child(AddTrademark.categoryName).child("TradeMarks").child(AddTrademark.key).child("Branches").child("\(index+1)").setValue(MoreBranches)
        
        
       
        
        
        
    }
    
    @IBAction func Next(_ sender: Any  ) {
//AddBranches()
        
    

}
    
    
 
}
