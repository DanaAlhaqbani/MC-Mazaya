//
//  SignUpViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 01/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class SignUpViewController: UIViewController {
    var gender = ""
    
    var isValidname = false
    var isValidemail = false
    var isValidPassword = true
    var isValidConfirmPass = false
    var isFilledData = false
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
    
    // to know what gender option did the user choose
    @IBAction func didPressFemaleButton(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            maleRadioButton.isSelected = false
            gender = "أنثى"
            
        }
    }
    
    @IBAction func didPressMaleButton(_ sender: KGRadioButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            femaleRadioButton.isSelected = false
            gender = "ذكر"
        }
    }
    @IBAction func signUp(_ sender: Any) {
        
        
        
        self.validateData(email: emailTextField.text!, password: passwordTextField.text!, confirmPassword: passwordConfirmationTextField.text ?? "", name: nameTextField.text!, gender: gender, phone: phoneTextField.text!)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func validateData(email:String, password:String, confirmPassword:String, name:String, gender:String, phone:String) {
          
        if name.isEmpty || email.isEmpty  || password.isEmpty  || confirmPassword.isEmpty || phone.isEmpty {
              print("hhhh")
              
              let alert = self.alertContent(title:  "هذه الحقول مطلوبة!", message: "من فضلِك قم بتعبئة بياناتك حتى تتمكن من التسجيل ")
            self.present(alert, animated: true, completion: nil)

              
          } else {
              
    if email != "" {
              
              if password != ""{
                  if confirmPassword != ""{
                      if name != "" {
                          if gender != "" {
                            if phone != "" {
                              isFilledData = true
                              
                              
                              
                            } else {
                                 let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:"مِن فضلك أدخِل رقمك")
                                self.present(alert, animated: true, completion: nil)

                            }
                          } else { //gender
                               let alert = self.alertContent(title:  "مازالت بياناتك غير مكتملة!", message: "من فضلِك حدد جنسك ")
                            self.present(alert, animated: true, completion: nil)

                          }
                      } else {
                          //name
                         let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:"مِن فضلك أدخِل اسمك")
                          self.present(alert, animated: true, completion: nil)

                   
                      }
                  } //confirmPassword
                  else {
                      let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message: "من فضلِك أدخِل تأكيد كلمة المرور")
                    self.present(alert, animated: true, completion: nil)

                                           
                  }
                  
              } else { //empty password
                    let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:"من فضلِك أدخِل كلمة المرور")
                self.present(alert, animated: true, completion: nil)

                  
              }//empty password
          } else  { //empty email
               let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  "من فضلِك أدخِل البريد الإلكتروني" )
        self.present(alert, animated: true, completion: nil)

          }//empty email
          
          
          if !isValidName(testStr: name) {
                      let alert = self.alertContent(title:   "الاسم غير صحيح", message: "يجب أن يكون الاسم المدخل مكون من حرفين إلى ١٠ أحرف")
            self.present(alert, animated: true, completion: nil)

          }
          
          
          else if !isValidEmail(testStr:email) { // Correct Email
             let alert = self.alertContent(title:   "البريد الإلكتروني خاطئ", message: "من فضلك أدخل البريد الإلكتروني بشكل صحيح" )
            self.present(alert, animated: true, completion: nil)

             
          } // Correct Email
          
          
           else if((password.count) < 6){ //Password less than 6 char
               let alert = self.alertContent(title:  "كلمة المرور خاطئة", message: "يجب أن تكون كلمة المرور مكونة من ٦ خانات أو أكثر" )
            self.present(alert, animated: true, completion: nil)

          }
              
          else if ((password) != (confirmPassword)) { // password != confirmPassword
               let alert = self.alertContent(title:  "تأكيد كلمة المرور غير متطابق!", message: " من فضلِك، أدخل كلمة مرور متطابقة" )
            self.present(alert, animated: true, completion: nil)

                              
          } // password != confirmPassword
          
              if isFilledData && self.isValidName(testStr: name) && self.isValidEmail(testStr: email) && password.count >= 6 && password == confirmPassword {
                  self.signUp(email: email, password: password, confirmPassword: confirmPassword, name: name, gender: gender, phone: phone)
              }
          
              
          } // end if fields are not empty
          
      }
      
      func isValidEmail(testStr:String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
          
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          let result = emailTest.evaluate(with: testStr)
          isValidemail = true
          return result
      }
      func isValidName (testStr:String) -> Bool {
          let length = testStr.count
          if length <= 1 || length > 10{
              return false
          }
          isValidname = true
          return true
      }
    func isValidNumber(testStr:String) -> Bool{
        var length = testStr.count
        
        return true
    }
    func signUp(email:String, password:String, confirmPassword:String, name:String, gender:String, phone: String){
          // sign up
        /*  Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
             if let error = error {
               let alert = self.alertContent(title: "البريد الإلكتروني خاطئ", message: "البريد الإلكتروني مسجل مسبقا")
                self.present(alert, animated: true, completion: nil)

                  
                  print("failed to sign user up with error", error.localizedDescription)
                 
                  return }
              
              guard let uid = result?.user.uid else { return }
              
              let values = ["Email": email, "Name": name, "Gender": gender, "Password": password]
              Database.database().reference().child("Users").child(uid).updateChildValues(values, withCompletionBlock: {(error, ref) in
                  if let error = error {
                      print("failed to update database values with error", error.localizedDescription)
                      return }
                  
                        print("successfuly signed user up")
                        
                        
                        
                        
                        // Email verify
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            self.successfulSignUp()
                            print("111111111111111")
                        }
                        
                    })
                } // sign up
                
                */
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                                 if let error = error {
              let alert = self.alertContent(title: "البريد الإلكتروني خاطئ", message: "البريد الإلكتروني مسجل مسبقا")
                          self.present(alert, animated: true, completion: nil)

                                     
                                     print("failed to sign user up with error", error.localizedDescription)
                                    
                                     return }
                                 
                                 guard let uid = result?.user.uid else { return }
                                 
            let values = ["Email": email, "Name": name, "Gender": gender, "Password": password, "Phone": phone]
                                 Database.database().reference().child("Users").child(uid).updateChildValues(values, withCompletionBlock: {(error, ref) in
                                     if let error = error {
                                         print("failed to update database values with error", error.localizedDescription)
                                         return }
                                     
                        
                        print("successfuly signed user up")
                       
                        
                        
                        // Email verify
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            print("111111111111111")
                            let alert = self.alertContent(title: "قم بتفعيل حسابك", message: "من فضلِك فعل الحساب عن طريق الرسالة المرسلة الى بريدك الالكتروني")
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    })
                } // sign up
                
                
            }
            
            
  
        static var successfulSignUp  = false
        
        @objc func successfulSignUpFunction(){
    //        navigationController?.popViewController(animated: true)
            OperationQueue.main.addOperation {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginNV") as! UINavigationController
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        }
        }
        
      func alertContent(title: String, message: String)-> UIAlertController{
          
          let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
              NSLog("The \"OK\" alert occured.")
          }))
          return alertVC
      }
    func handleError(error: Error) {
        
        /// the user is not registered
        /// user not found
        
        let errorAuthStatus = AuthErrorCode.init(rawValue: error._code)!
        switch errorAuthStatus {
        case .tooManyRequests:
            print("tooManyRequests, oooops")
        default: fatalError("error not supported here")
        }
    }
}
