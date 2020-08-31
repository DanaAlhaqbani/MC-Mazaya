//
//  FamilyViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import FirebaseDatabase
import FirebaseAuth

protocol familyPassData {
func passDataBack(numbers: [String])

}
class FamilyViewController: UIViewController, MFMessageComposeViewControllerDelegate {
   
 
    var projectsRef: DatabaseReference!
       let userID = Auth.auth().currentUser?.uid
       var Phones = [String]()

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setUpUI()

          
         
        }
        let upperView : UIImageView = {
             $0.translatesAutoresizingMaskIntoConstraints = false
             $0.contentMode = .scaleToFill
             $0.clipsToBounds = true
            // $0.image = #imageLiteral(resourceName: "profileWB")
             return $0
         }(UIImageView())
        let CommunicationLabel : UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "قم بدعوة أفراد عائلتك لإستخدام تطبيق مزايا"
            $0.textAlignment = .right
            $0.font = .boldSystemFont(ofSize: 10)
            $0.font = UIFont(name: "stc", size: 15)
            let green = UIColor(rgb: 0x38a089)
            $0.textColor = green
            
            return $0
        }(UILabel())
      
        lazy var FAQ : UIButton = {
            $0.addTarget(self, action: #selector(FAQAction), for: .touchUpInside)
                $0.translatesAutoresizingMaskIntoConstraints = false
                let green = UIColor(rgb: 0x38a089)
                 $0.tintColor = .white
                $0.contentMode = .scaleAspectFit
                $0.clipsToBounds = true
                $0.setTitle("إضافة عضو", for: .normal)

                $0.titleLabel?.font = UIFont(name: "stc", size: 20)
                $0.contentMode = .scaleAspectFit
               //$0.setImage(#imageLiteral(resourceName: "FAQ icon"), for: .normal)
                $0.setBackgroundImage(#imageLiteral(resourceName: "green btn"), for: .normal)
                return $0
            }(UIButton(type: .system))
        @objc func FAQAction() {
          let alertController = UIAlertController(title: "إضافة عضو", message: "أدخل رقم هاتف العضو الذي ترغب بدعوته", preferredStyle: .alert)
           
                   //the confirm action taking the inputs
                   let confirmAction = UIAlertAction(title: "إرسال الدعوة", style: .default) { (_) in
                       //getting id
                       //let id = task1.id
                       //getting new values
                       let Family_Phone = alertController.textFields?[0].text
                       //let assignedMember = alertController.textFields?[1].text
           
                       //calling the update method to update artist
                    self.AddFamilyMember(Family_Phone: Family_Phone!)
                   }
           
            let cancelAction = UIAlertAction(title: "الغاء", style: .cancel) { (_) in }

           //adding two textfields to alert
            alertController.addTextField { (textField) in
                            textField.placeholder = "05XXXXXXXX"
                        }
                           //adding action
                        alertController.addAction(confirmAction)
                        alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)

        }
    
    func AddFamilyMember(Family_Phone: String!){
        self.sendInvitation(Family_Phone: Family_Phone)
        if Family_Phone != "" {
            if isValidNumber(Family_Phone: Family_Phone) == true {
                  let alert = self.alertContent(title:  "تم بنجاح!", message: "شكرا لك تم إرسال الدعوة" )
                self.present(alert, animated: true, completion: nil)

                 let member = ["Name" : Family_Phone , "Status" : "Pending"]
                let ref = Database.database().reference().child("Users").child(userID!).child("FamilyList")
                let key = ref.childByAutoId().key
                ref.child(key!).setValue(member)
                print("Success Add family Member")
            }
            else {
                let alert = self.alertContent(title:  "رقم الهاتف غير صالح!", message: " من فضلِك، أدخل رقم الهاتف بشكل صحيح" )
                self.present(alert, animated: true, completion: nil)
            }
        }
          let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:"مِن فضلك أدخِل رقمك")
          self.present(alert, animated: true, completion: nil)
    }
    func sendInvitation(Family_Phone: String){
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = [Family_Phone]
        composeVC.body = "قم بتحميل تطبيق مزايا"
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
    func isValidNumber(Family_Phone:String) -> Bool{
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: Family_Phone)
        }

        lazy var Email : UIButton = {
            $0.addTarget(self, action: #selector(EmailAction), for: .touchUpInside)
                $0.translatesAutoresizingMaskIntoConstraints = false
                let green = UIColor(rgb: 0x38a089)
                 $0.tintColor = .white
                $0.contentMode = .scaleAspectFit
                $0.clipsToBounds = true
                $0.setTitle("قائمة عائلتي", for: .normal)

                $0.titleLabel?.font = UIFont(name: "stc", size: 20)
                $0.contentMode = .scaleAspectFit
               //$0.setImage(#imageLiteral(resourceName: "FAQ icon"), for: .normal)
                $0.setBackgroundImage(#imageLiteral(resourceName: "green btn"), for: .normal)
                return $0
            }(UIButton(type: .system))
        @objc func EmailAction() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let secondVC = storyboard.instantiateViewController(identifier: "FList")
                    
                     navigationController?.pushViewController(secondVC, animated: true)
        }
          
              
        func setUpUI()  {
               
               view.addSubview(upperView)
               view.addSubview(FAQ)
               view.addSubview(Email)

               upperView.addSubview(CommunicationLabel)
           
               
               NSLayoutConstraint.activate([
                   upperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   upperView.topAnchor.constraint(equalTo: view.topAnchor),
                   upperView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
                   upperView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor , constant: 30),
                   
                   FAQ.topAnchor.constraint(equalTo: upperView.centerYAnchor, constant: -10),
                                
                   FAQ.heightAnchor.constraint(equalToConstant: 160),
                    FAQ.widthAnchor.constraint(equalToConstant: 160),
                    FAQ.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                //FAQ.topAnchor.constraint(equalTo: upperView.centerYAnchor, constant: -10),
                    FAQ.topAnchor.constraint(equalTo: view.topAnchor , constant: 240),

                                 Email.heightAnchor.constraint(equalToConstant: 160),
                                 Email.widthAnchor.constraint(equalToConstant: 160),
                                 Email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                 Email.topAnchor.constraint(equalTo: view.topAnchor , constant: 420),
                   CommunicationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,  constant: 20),
                   CommunicationLabel.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
                   
                      ])
                     
                   
    }
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
    }
