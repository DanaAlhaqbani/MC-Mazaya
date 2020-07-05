//
//  EditProfilePresenter.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 10/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//


import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol EditProfileDelegate {
    func showAlert(alert: UIAlertController)
    func failure(alert: UIAlertController)
    func performEdit()
    func successful()
    
}
class EditProfilePresenter: NSObject {
    var delegate: EditProfileDelegate!
    

    
    var isValidname = false
      var isValidnNum = false
    
        
      func ValidateData(name: String, phone: String){
    if name != "" && isValidName(testStr: name) == true && phone != "" && isValidNumber(testStr: phone) == true{
                     
                     
                    

                      let alert = self.alertConfirm(title: "سيتم تحديث بيانات حسابك", message: " هل انت متاكد؟")
                     self.delegate.showAlert(alert: alert)

              
              
                 }
                 else if name.isEmpty { //No name
                     print("empty name")
                     
                   let alert = self.alertContent(title: " بياناتك غير مكتملة!", message: "من فضلِك ادخل اسمك ")
                       self.delegate.showAlert(alert: alert)

                     
                 }
              else if phone.isEmpty {
                     
                       let alert = self.alertContent(title: " بياناتك غير مكتملة!", message: "من فضلِك ادخل رقم هاتفك ")
                       self.delegate.showAlert(alert: alert)
                 }
           else if !isValidName(testStr: name) {
                     
                     let alert = self.alertContent(title:   "الاسم غير صحيح", message: "يجب أن يكون الاسم المدخل مكون من حرفين إلى ١٠ أحرف")
                     self.delegate.showAlert(alert: alert)

                 }
           else if !isValidNumber(testStr: phone) {
                         
                        let alert = self.alertContent(title:   "رقم الهاتف غير صحيح", message: "يجب أن يكون الرقم المدخل مكون من ١٠ أرقام")
                             self.delegate.showAlert(alert: alert)

                     }
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
                  let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
                  let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
                 self.isValidnNum = phoneTest.evaluate(with: testStr)

                  return self.isValidnNum
                  }
       func EditProfile (name: String, phone: String) {
           
           guard let uid = Auth.auth().currentUser?.uid else { return }
           
           
           Database.database().reference().child("Users").child(uid).child("Name").observeSingleEvent(of: .value) { (snapshot) in
               guard let newname = snapshot.value as? String else { return }
               Database.database().reference().child("Users").child(uid).updateChildValues(["Name": name])
               guard let newphone = snapshot.value as? String else { return }
                         Database.database().reference().child("Users").child(uid).updateChildValues(["Phone": phone])
                         print("success edit")
                       self.delegate?.successful()

           }
    }
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
               self.delegate.performEdit()
           }))
           alertVC.addAction(UIAlertAction(title: NSLocalizedString("الغاء", comment: "Default action"), style: .cancel, handler: { _ in
               NSLog("The \"cancel\" alert occured.")
            self.delegate.failure(alert: alertVC)
           }))
           return alertVC
       }
}

