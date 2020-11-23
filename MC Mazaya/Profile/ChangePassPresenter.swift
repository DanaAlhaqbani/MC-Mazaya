//
//  ChangePassPresenter.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 07/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol ChangePassDelegate {
    func showAlert(alert: UIAlertController)
    func failure(alert: UIAlertController)
    func successful()
    func performChange()
}

class ChangePassPresenter: NSObject {
    
    

    var delegate: ChangePassDelegate!
    //    var passCheck: String!
    func validateData(oldPass: String, newPass: String, confirmPass: String){
        var passCheck: String!
        
        
       
        
        // to check current password i think it should be stored in the database
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("Users").child(uid).child("Password").observeSingleEvent(of: .value) { (snapshot) in
            guard let pass = snapshot.value as? String else { return }
            passCheck = pass
            
            
            if oldPass != ""{
                if oldPass == passCheck {
                    if newPass != ""{
                        if newPass.count >= 6 {
                            if confirmPass != ""{
                                if newPass == confirmPass{
                                    
                                  
                                        let alert = self.alertConfirm(title: "سيتم تحديث كلمة المرور الخاصة بك", message: " هل انت متاكد؟")
                                    self.delegate.showAlert(alert: alert)
                                        
                                        
                                 
                                    
                                    
                                } else { // incorrct password confirmation
                                    //
                                    
                                     let alert = self.alertContent(title: "تأكيد كلمة المرور غير متطابق", message: "من فضلِك أدخل كلمة مرور متطابقة")
                                    self.delegate.showAlert(alert: alert)

                                }
                            } else {// empty confirm pass
                                //
                                
                                    let alert = self.alertContent(title: "بياناتك غير مكتملة!", message: " من فضلِك ادخل تأكيد كلمة المرور الجديدة")
                                self.delegate.showAlert(alert: alert)

                            }
                            
                        } else {
                            
                             let alert = self.alertContent(title: "كلمة المرور قصيرة!", message: " من فضلِك ادخل كلمة مرور مكونه من ٦ خانات أو أكثر")
                            self.delegate.showAlert(alert: alert)

                        }
                        
                    } else {// empty new pass
                        //
                        
                      let alert = self.alertContent(title: "بياناتك غير مكتملة!", message: " من فضلِك ادخل كلمة المرور الجديدة")
                        self.delegate.showAlert(alert: alert)

                    }
                    
                    
                } else {// incorrect current password
                    //
                    
                    let alert = self.alertContent(title: "بياناتك غير صحيحة!", message: " من فضلِك ادخل كلمة المرور الحالية بشكل صحيح")
                    self.delegate.showAlert(alert: alert)

                }
                
            } else {// empty old pass
                //
                let alert = self.alertContent(title: "بياناتك غير مكتملة!", message: " من فضلِك ادخل كلمة المرور الحالية")
                self.delegate.showAlert(alert: alert)

            }
            
        }
        
    }
    
    
    func changePass(newPass: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let user = Auth.auth().currentUser
        user?.updatePassword(to: newPass, completion: { (error) in
            
            if let myError = error?.localizedDescription {
                print(myError)
//                let alert = self.alertContent(title: "خطأ في النظام!", message: "سجل دخولك مرة أخرى وأعد المحاولة")
//                self.delegate?.showAlert(alert: alert)
                
              let alert = self.alertContent(title: "خطأ في النظام!", message: "سجل دخولك مرة أخرى وأعد المحاولة" )
                self.delegate.showAlert(alert: alert)

            }
            else {
                Database.database().reference().child("Users").child(uid).updateChildValues(["Password": newPass])
                print("success")
                self.delegate.successful()
            }
        }) // end update pass
    }
    
    
    
//    func alertContent(title: String, message: String)-> UIAlertController{
//
//        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
//            NSLog("The \"OK\" alert occured.")
//        }))
//        return alertVC
//    }
    
    
    
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
    func alertConfirm(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("نعم", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            self.delegate.performChange()
        }))
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("الغاء", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("The \"cancel\" alert occured.")
            self.delegate.failure(alert: alertVC)
        }))
        return alertVC
    }
    
}

