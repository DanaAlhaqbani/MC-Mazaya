//
//  LoginViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 01/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var showSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.backgroundUnderlined()
               passwordTextField.backgroundUnderlined()
               loginBtn.setButton()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
           self.validateData(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func validateData(email:String, password:String) {
        
        if email != "" {
            if password != "" {
                login(email: email, password: password)
            } else { // empty password
               let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  " من فضلِك ادخل كلمة مرور")
                self.present(alert, animated: true, completion: nil)

    
            } // end empty password
        } else if email.isEmpty && password.isEmpty { // empty email
            let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message: "من فضلك ادخل بياناتك")
            self.present(alert, animated: true, completion: nil)

           
        } else {
             let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  " من فضلِك ادخل بريدك الالكتروني")
            self.present(alert, animated: true, completion: nil)

        }
    }

    
    func login(email:String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password , completion: { (user, error) in
        
            if user != nil{
 
                // Check if email is verified
                    let user = user?.user
                    if user!.isEmailVerified {
                        print("success")
                        self.successful()
                    } else {
                        // email is not verified
                        print("email is not verified")
                        let alert = self.alertContent(title:  "لم تقم بتفعيل حسابك", message: "من فضلِك فعل الحساب عن طريق الرسالة المرسلة الى بريدك الالكتروني")
                       self.present(alert, animated: true, completion: nil)

                }
            } // successful login
                
            else { // user is nil
                if let myError = error?.localizedDescription {
                    print(myError)
                    
                    if myError=="The email address is badly formatted."{ // Incorrect email format
                     let alert = self.alertContent(title:  "بريد إلكتروني خاطئ", message: " من فضلك أدخل صيغة بريد الكتروني صحيحة" )
                        self.present(alert, animated: true, completion: nil)

                        
                    } else if myError=="The password is invalid or the user does not have a password." { // Invalid password
                        
                        let alert = self.alertContent(title: "كلمة المرور غير صحيحة", message: " من فضلِك أدخل كلمة المرور الخاصه بحسابك")
                        self.present(alert, animated: true, completion: nil)

                        
                    } else { // Unregistered email

                        let alert = self.alertContent(title:"البريد الالكتروني غير مسجل!", message:"من فضلِك قُم بإنشاء حساب ")
                        self.present(alert, animated: true, completion: nil)

                    }
                    
                } else {
                    print ("Error")
                }
                
            } // End else ( user is nil )
        }) // End auth signIn
    }
    
  
 
    func successful(){
        //=====Transfer to home page=====
        self.performSegue(withIdentifier: "toHome", sender: nil)

    }
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
}
