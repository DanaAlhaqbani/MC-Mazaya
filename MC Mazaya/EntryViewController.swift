//
//  EntryViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 24/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import RealmSwift
import UIKit
import Firebase

class EntryViewController: UIViewController, UITextFieldDelegate {
   /* var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
       // datePicker.setDate(Date(), animated: true)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "إرسال", style: .done, target: self, action: #selector(didTapSaveButton))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func didTapSaveButton() {
        if let text = textField.text, !text.isEmpty {
            if text != ""{
            //let date = datePicker.date

            realm.beginWrite()
            let newItem = ToDoListItem()
           // newItem.date = date
            newItem.item = text
            realm.add(newItem)
            try! realm.commitWrite()

            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
            let key = ref.childByAutoId().key
            ref.child("Users").child(userID!).child("Family Members").child(key!).child("Phone").setValue(text)
        
            } else {
                let alert = self.alertContent(title:  "نعتذر منك لقد تجاوزت العدد المسموح!", message:  " عدد أفراد العائلة الذين يمكنك دعوتهم هو ٦ أفراد فقط")
                            self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  "من فضلِك ادخل رقم الهاتف")
                        self.present(alert, animated: true, completion: nil)        }
    }
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }

*/
}
