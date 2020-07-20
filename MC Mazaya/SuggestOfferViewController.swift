//
//  SuggestOfferViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
class SuggestOfferViewController: UIViewController {
    @IBOutlet weak var tradeMarkName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var shopping: KGRadioButton!
    @IBOutlet weak var cars: KGRadioButton!
    @IBOutlet weak var Travel: KGRadioButton!
    
    @IBOutlet weak var Notes: UITextField!
    @IBOutlet weak var others: UITextField!
    @IBOutlet weak var resturants: KGRadioButton!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var phone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        tradeMarkName?.backgroundUnderlined()
        email?.backgroundUnderlined()
        Notes?.backgroundUnderlined()
        others?.backgroundUnderlined()
        phone?.backgroundUnderlined()
        sendBtn?.setButton()*/
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    // pass >> activity
       let upperView : UIImageView = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.contentMode = .scaleToFill
           $0.clipsToBounds = true
          // $0.image = #imageLiteral(resourceName: "profileWB")
           return $0
       }(UIImageView())
       
       
       let editPageLabel : UILabel = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.text = "اقترح عرضاً"
           $0.textAlignment = .right
           $0.font = .boldSystemFont(ofSize: 20)
           $0.font = UIFont(name: "stc", size: 35)
           $0.textColor = .darkGray
           
           return $0
       }(UILabel())
       
       
       let nameLabel : UILabel = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.text = "الاسم التجاري"
           $0.textAlignment = .right
           $0.font = .boldSystemFont(ofSize: 20)
           $0.font = UIFont (name: "stc", size: 20)
           $0.textColor = .darkGray
           
           return $0
       }(UILabel())
       
       let ActivityLabel : UILabel = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.text = "نوع النشاط"
           $0.textAlignment = .right
           $0.font = .boldSystemFont(ofSize: 30)
           $0.font = UIFont(name: "stc", size: 20)
           $0.textColor = .darkGray
           return $0
       }(UILabel())
       
       let phoneLabel : UILabel = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.text = "رقم التواصل"
           $0.textAlignment = .right
           $0.font = .boldSystemFont(ofSize: 20)
           $0.font = UIFont(name: "stc", size: 20)
           $0.textColor = .darkGray
           
           return $0
       }(UILabel())
       
       let emailLabel : UILabel = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.text = "البريد الإلكتروني"
           $0.textAlignment = .right
           $0.font = .boldSystemFont(ofSize: 30)
           $0.font = UIFont(name: "stc", size: 20)
           $0.textColor = .darkGray
           return $0
       }(UILabel())
       
       let notesLabel : UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "ملاحظات"
            $0.textAlignment = .right
            $0.font = .boldSystemFont(ofSize: 30)
            $0.font = UIFont(name: "stc", size: 20)
            $0.textColor = .darkGray
            return $0
        }(UILabel())
    
       lazy var saveChangesButton : UIButton = {
           $0.addTarget(self, action: #selector(saveChangesAction), for: .touchUpInside)
               $0.translatesAutoresizingMaskIntoConstraints = false
               let green = UIColor(rgb: 0x38a089)
               $0.tintColor = green
               $0.setTitle("إرسال", for: .normal)
               $0.titleLabel?.font = UIFont(name: "stc", size: 22)
               $0.contentMode = .scaleAspectFit
               $0.setImage(#imageLiteral(resourceName: "Save"), for: .normal)
               $0.setBackgroundImage(#imageLiteral(resourceName: "whitebutton"), for: .normal)
               return $0
           }(UIButton(type: .system))
       
       @objc func saveChangesAction() {
           print("SaveCange work")
           
        self.validateData(name: nameTextField.textField.text!, activity: ActivityTextField.textField.text!, phone: phoneTextField.textField.text!, email: emailTextField.textField.text!, notes: notesTextField.textField.text! )
           
           
       }
       
       
       let nameTextField : InputTextField = {
           $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholderColor(text: "اسم العلامة التجارية" ,color: .lightGray)
       
           return $0
       }(InputTextField())
       
       let ActivityTextField : InputTextField = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.textField.placeholderColor(text: "(تسوق، سيارات، مطاعم ..)", color: .lightGray)
           $0.isUserInteractionEnabled = true
           return $0
       }(InputTextField())
       
       let phoneTextField : InputTextField = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.textField.placeholderColor(text: "05XXXXXXXX", color: .lightGray)
           return $0
       }(InputTextField())
       
       let emailTextField : InputTextField = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textField.placeholderColor(text: "Example@Example.com", color: .lightGray)
                 $0.isUserInteractionEnabled = true
                 return $0
       }(InputTextField())
       let notesTextField : InputTextField = {
               $0.translatesAutoresizingMaskIntoConstraints = false
             $0.textField.placeholderColor(text: "ضع ملاحظاتك هنا", color: .lightGray)
                    $0.isUserInteractionEnabled = true
                    return $0
          }(InputTextField())
    
          func setUpUI()  {
              
              view.addSubview(upperView)
              //upperView.addSubview(userIcon)
              upperView.addSubview(editPageLabel)
              
              view.addSubview(nameLabel)
              view.addSubview(nameTextField)
              
              view.addSubview(ActivityLabel)
              view.addSubview(ActivityTextField)
              
              view.addSubview(phoneLabel)
              view.addSubview(phoneTextField)
              
              view.addSubview(emailLabel)
              view.addSubview(emailTextField)
              view.addSubview(notesLabel)
               view.addSubview(notesTextField)
                          
              view.addSubview(saveChangesButton)
              //view.addSubview(passwordButton)
              
              NSLayoutConstraint.activate([
                       upperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                       upperView.topAnchor.constraint(equalTo: view.topAnchor),
                       upperView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.150),
                       upperView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor , constant: 5),
              
                  nameLabel.topAnchor.constraint(equalTo: upperView.bottomAnchor),
                nameLabel.rightAnchor.constraint(equalTo: upperView.rightAnchor , constant: -45),
                  nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor , constant: -8),
                  nameTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor , constant: 0),
                  nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
                  //            nameTextField.heightAnchor.constraint(equalToConstant: 40),
                  
                  ActivityLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
                  ActivityLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                  ActivityTextField.topAnchor.constraint(equalTo: ActivityLabel.bottomAnchor , constant: -8),
                  ActivityTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                  ActivityTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
                  
                
                  
                  phoneLabel.topAnchor.constraint(equalTo: ActivityTextField.bottomAnchor),
                  phoneLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                  
                  phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor , constant: -8),
                  phoneTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                  phoneTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
                  
                  emailLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor),
                  emailLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                  
                  emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor , constant: -8),
                  emailTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                  emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
                  
                  notesLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
                  notesLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                              
                notesTextField.topAnchor.constraint(equalTo: notesLabel.bottomAnchor , constant: -8),
                notesTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
                notesTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
                  
                  saveChangesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -220),
                  saveChangesButton.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
                  
                  
              ])
              
              
              
          }
    func validateData(name: String, activity: String, phone: String, email: String, notes: String){
        if name != "" {
            if activity != "" {
                sendSuggestion(name: name, activity: activity, phone: phone, email: email, notes: notes)
                let alert = self.alertContent(title: "شكراً لك!", message: "تم ارسال اقتراحك بنجاح")
                self.present(alert, animated: true, completion: nil)
                
                self.nameTextField.textField.text = ""
                self.ActivityTextField.textField.text = ""
                self.emailTextField.textField.text = ""
                self.phoneTextField.textField.text = ""
                self.notesTextField.textField.text = ""
        
        } else {
                        let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  " من فضلِك ادخل نوع النشاط")
             self.present(alert, animated: true, completion: nil)
        }
        } else {
            let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:  " من فضلِك ادخل أسم العلامة التجارية")
                self.present(alert, animated: true, completion: nil)
        }
    }
    func sendSuggestion(name: String, activity: String, phone: String, email: String, notes: String){
                              
                        let userID = Auth.auth().currentUser!.uid

                                        
                   let values = ["Trade Mark Name": name, "Activity Type": activity, "Contact Phone": phone, "Cpntact Email": email, "Employee Notes": notes] as [String : Any]
        Database.database().reference().child("Suggestion").child(userID).updateChildValues(values, withCompletionBlock: {(error, ref) in
                                            if let error = error {
                                                print("failed to update database values with error", error.localizedDescription)
                                                return }
              
                               print("successfuly send suggestion ")
                              
                               
    }
)}
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }

}
