//
//  SignUpViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 01/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    var gender = ""

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
   
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var maleRadioButton: KGRadioButton!
    
    @IBOutlet weak var femaleRadioButton: KGRadioButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.backgroundUnderlined()
        phoneTextField.backgroundUnderlined()
        nameTextField.backgroundUnderlined()

        emailTextField.backgroundUnderlined()
        passwordTextField.backgroundUnderlined()
        passwordConfirmationTextField.backgroundUnderlined()
        signUpButton.setButton()
        
        femaleRadioButton.isSelected = true
        
        gender = "أنثى"
        self.tabBarController?.tabBar.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
