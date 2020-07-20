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
import IQKeyboardManagerSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    

    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var showSignUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ///self.navigationController?.isNavigationBarHidden = true
        emailTextField.backgroundUnderlined()
               passwordTextField.backgroundUnderlined()
               loginBtn.setButton()
        emailTextField.addDoneButtonOnKeyboard()
        passwordTextField.addDoneButtonOnKeyboard()

    }
    
    @IBAction func LoginBtn(_ sender: Any) {
           self.validateData(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func validateData(email:String, password:String) {
        
        if email != "" {
            if password != "" {
                self.showSpinner()
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
                        self.removeSpinner()
                        let alert = self.alertContent(title:  "لم تقم بتفعيل حسابك", message: "من فضلِك فعل الحساب عن طريق الرسالة المرسلة الى بريدك الالكتروني")
                       self.present(alert, animated: true, completion: nil)

                }
            } // successful login
                
            else { // user is nil
                if let myError = error?.localizedDescription {
                    print(myError)
                    
                    if myError=="The email address is badly formatted."{ // Incorrect email format
                        self.removeSpinner()
                     let alert = self.alertContent(title:  "بريد إلكتروني خاطئ", message: " من فضلك أدخل صيغة بريد الكتروني صحيحة" )
                        self.present(alert, animated: true, completion: nil)

                        
                    } else if myError=="The password is invalid or the user does not have a password." { // Invalid password
                        self.removeSpinner()
                        let alert = self.alertContent(title: "كلمة المرور غير صحيحة", message: " من فضلِك أدخل كلمة المرور الخاصه بحسابك")
                        self.present(alert, animated: true, completion: nil)

                        
                    } else { // Unregistered email
                        self.removeSpinner()

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
        self.removeSpinner()
        self.moveToTheTabBarViewController()


    }
   func moveToTheTabBarViewController () {
          
  //        TrophyVC.newUsections = self.UTsections
  //        TrophyVC.newUPsections = self.UPsections
          
          let homeViewController = storyboard?.instantiateViewController(withIdentifier: "VCTabBar") as? UITabBarController
          let userNavViewController = homeViewController?.viewControllers![1] as? UINavigationController
          let userHomeViewController = userNavViewController?.viewControllers[0] as? homeViewController

        
          
          self.view.window?.rootViewController = homeViewController
          self.view.window?.makeKeyAndVisible()
      }
        
        
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
    func showSpinner(){
           self.showActivityIndicator(uiView: self.view)
       }
       
       func removeSpinner(){
           self.hideActivityIndicator(uiView: self.view)
       }
       func showActivityIndicator(uiView: UIView) {
             container.frame = uiView.frame
             container.center = uiView.center
             container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
         
          
             loadingView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 80, height: 80))

             loadingView.center = uiView.center
             loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
             loadingView.clipsToBounds = true
             loadingView.layer.cornerRadius = 10
         
             activityIndicator.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40))
             activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
             activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

             loadingView.addSubview(activityIndicator)
             container.addSubview(loadingView)
             uiView.addSubview(container)
             activityIndicator.startAnimating()
         }
        
        func hideActivityIndicator(uiView: UIView) {
               activityIndicator.stopAnimating()
               container.removeFromSuperview()
           }
        
        
        func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
               let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
               let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
               let blue = CGFloat(rgbValue & 0xFF)/256.0
               return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
           }
        
}
