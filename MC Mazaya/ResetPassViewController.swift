//
//  ResetPassViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 01/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class ResetPassViewController: UIViewController {
  var resetFlag = false
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.backgroundUnderlined()
        resetBtn.setButton()
    }
    

    @IBAction func resetPassPressed(_ sender: UIButton) {
        if emailTextField.text! == "" {
                       //empty email
                         let alert = self.alertContent(title:   "بياناتك غير مكتملة!", message: " من فضلِك ادخل بريدك الالكتروني" )
                       self.present(alert, animated: true, completion: nil)


                          }
                   else {
            let auth = Auth.auth()
                       
            auth.sendPasswordReset(withEmail: emailTextField.text!) { (error) in
                           if let error = error {
                             let alert = self.alertContent(title:   "البريد المدخل غير صحيح!", message: " من فضلِك ادخل  بريدك الالكتروني المسجل في حسابك" )
                               self.present(alert, animated: true, completion: nil)
                               return
                           }
                           
                            let alert = self.alertContent(title:   "تم بنجاح!", message: " تم إرسال اليك بريد إلكتروني لإستعادة كلمة مرورك")
                           self.present(alert, animated: true, completion: nil)
                       }
            
        }
 
    }
                                               
       
func alertContent(title: String, message: String)-> UIAlertController{
    
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
    }))
    return alertVC
}
}
