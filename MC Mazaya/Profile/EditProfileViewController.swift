//
//  EditProfileViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 04/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//
/*
import Foundation
import Firebase
import UIKit
protocol EditProfilePassData {
    func passDataBack(name: String )
}

class EditProfileViewController: UIViewController{
 

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    @IBOutlet weak var saveChanges: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       view.generalGradiantView()
        nameTextField.backgroundUnderlined()
        phoneTextField.backgroundUnderlined()
        passwordTextField.backgroundUnderlined()
        confirmPassTextField.backgroundUnderlined()
        saveChanges.setButton()
        

    }
  
   
    
    
}
  */

import Foundation
import Firebase
import UIKit
import FirebaseDatabase
import FirebaseAuth


protocol EditProfilePassData {
    func passDataBack(name: String , phone: String)

}

class EditProfileViewController: UIViewController , EditProfileDelegate {
    var presenter: EditProfilePresenter!

    var ref: DatabaseReference?
      var handle: DatabaseHandle?
      let user = Auth.auth().currentUser
    
    var confirmed = false

    var delegate : EditProfilePassData?
    
    
    static var img : UIImageView?
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)

        }
        func failure(alert: UIAlertController) {
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
    //        self.performSegue(withIdentifier: "ProfileView", sender: self)
        }
            func performEdit() {
                self.presenter.EditProfile(name: nameTextField.textField.text!, phone: phoneTextField.textField.text!)
                
        }
        func successful() {
            print("is successful work?")

            delegate?.passDataBack(name: nameTextField.textField.text!, phone: phoneTextField.textField.text!)
            print("data coppied")
            navigationController?.popViewController(animated: true)


        }
        
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = true
        ref = Database.database().reference()
        handle = ref?.child("Users").child((user?.uid)!).child("Name").observe(.value, with: { (snapshot) in
            if let currentName = snapshot.value as? String {
                self.nameTextField.textField.text! = currentName
            }
            
        })
        handle = ref?.child("Users").child((user?.uid)!).child("Email").observe(.value, with: { (snapshot) in
            if  let currentEmail = snapshot.value as? String {
                self.emailTextField.textField.placeholder! = currentEmail
            }
        })
        handle = ref?.child("Users").child((user?.uid)!).child("Phone").observe(.value, with: { (snapshot) in
            if  let currentPhone = snapshot.value as? String {
               self.phoneTextField.textField.text! = currentPhone
            }
        })

        
               super.viewDidLoad()
             presenter = EditProfilePresenter()
             presenter.delegate = self
        
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
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
    
    let userIcon : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        if ( userData.gender == "أنثى"){
        $0.image = #imageLiteral(resourceName: "femailEdit")
        }
        else {
        $0.image = #imageLiteral(resourceName: "maleEdit")

        }
        return $0
    }(UIImageView())
    
    let editPageLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "تعديل البيانات"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        let green = UIColor(rgb: 0x38a089)
        $0.textColor = green
        
        return $0
    }(UILabel())
    
    
    let nameLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "الاسم"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont (name: "stc", size: 20)
        let green = UIColor(rgb: 0x38a089)
        $0.textColor = green
        
        return $0
    }(UILabel())
    
    let PasswordLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "كلمة المرور"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        let green = UIColor(rgb: 0x38a089)
        $0.textColor = green
        return $0
    }(UILabel())
    
    let phoneLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "رقم الهاتف"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        let green = UIColor(rgb: 0x38a089)
        $0.textColor = green
        return $0
    }(UILabel())
    
    let emailLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "الايميل"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        let green = UIColor(rgb: 0x38a089)
        $0.textColor = green
        return $0
    }(UILabel())
    
    
    lazy var saveChangesButton : UIButton = {
        $0.addTarget(self, action: #selector(saveChangesAction), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let green = UIColor(rgb: 0x38a089)
        $0.tintColor = green
        $0.setTitle("حفظ التغييرات", for: .normal)
        $0.titleLabel?.font = UIFont(name: "stc", size: 22)
        $0.contentMode = .scaleAspectFit
        $0.setImage(#imageLiteral(resourceName: "Save"), for: .normal)
        $0.setBackgroundImage(#imageLiteral(resourceName: "whitebutton"), for: .normal)
        return $0
    }(UIButton(type: .system))
    
    @objc func saveChangesAction() {
        print("SaveCange work")
        
        self.presenter.ValidateData(name: nameTextField.textField.text!, phone: phoneTextField.textField.text!)
        
        
    }
    
    lazy var passwordButton : UIButton = {
        $0.addTarget(self, action: #selector(passwordAction), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        
        return $0
    }(UIButton(type: .system))
    
    @objc func passwordAction() {
        print(" PASSWOOOORRRDDDDD")
        //check the identifier
        self.performSegue(withIdentifier: "ChangePass", sender: self)
    }
    
    let nameTextField : InputTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholderColor(text: "أسم" ,color: .black)
        
        return $0
    }(InputTextField())
    
    let passwordTextField : InputTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholderColor(text: "******", color: .black)
        $0.isUserInteractionEnabled = false
        return $0
    }(InputTextField())
    
    let phoneTextField : InputTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholderColor(text: "05XXXXXXXX", color: .black)
        return $0
    }(InputTextField())
    
    let emailTextField : InputTextField = {
         $0.translatesAutoresizingMaskIntoConstraints = false
              $0.textField.placeholderColor(text: "Example@Example.com", color: .lightGray)
              $0.isUserInteractionEnabled = false
              return $0
    }(InputTextField())
    
    
    
    func setUpUI()  {
        
        view.addSubview(upperView)
        upperView.addSubview(userIcon)
        upperView.addSubview(editPageLabel)
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        
        view.addSubview(PasswordLabel)
        view.addSubview(passwordTextField)
        
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        
        view.addSubview(saveChangesButton)
        view.addSubview(passwordButton)
        
        NSLayoutConstraint.activate([
            upperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperView.topAnchor.constraint(equalTo: view.topAnchor),
            upperView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            upperView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor , constant: 30),
            
            userIcon.topAnchor.constraint(equalTo: upperView.centerYAnchor, constant: -50),
            
            userIcon.heightAnchor.constraint(equalToConstant: 160),
            userIcon.widthAnchor.constraint(equalToConstant: 160),
            userIcon.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
            
            editPageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editPageLabel.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
            
            
            nameLabel.topAnchor.constraint(equalTo: upperView.bottomAnchor),
            nameLabel.rightAnchor.constraint(equalTo: upperView.rightAnchor , constant: -45),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor , constant: -8),
            nameTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor , constant: 0),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            //            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            PasswordLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            PasswordLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            passwordTextField.topAnchor.constraint(equalTo: PasswordLabel.bottomAnchor , constant: -8),
            passwordTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
            passwordButton.topAnchor.constraint(equalTo: PasswordLabel.bottomAnchor , constant: -8),
            passwordButton.rightAnchor.constraint(equalTo: nameLabel.rightAnchor ),
            passwordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            passwordButton.heightAnchor.constraint(equalToConstant: 70),
            passwordButton.widthAnchor.constraint(equalToConstant: 100),
            
            phoneLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            phoneLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor , constant: -8),
            phoneTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            phoneTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
            emailLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor),
            emailLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor , constant: -8),
            emailTextField.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
            saveChangesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -30),
            saveChangesButton.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
            
            
        ])
        
        
        
    }
 
    
    var isValidname = false
    var isValidnNum = false
  
      
    
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
    func alertConfirm(title: String, message: String){
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
            self.performEdit()
            self.delegate!.passDataBack(name: self.nameTextField.textField.text!, phone: self.phoneTextField.textField.text!)
            self.navigationController?.popToRootViewController(animated: true)

          }))

        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
            self.navigationController?.popToRootViewController(animated: true)

          }))

        present(alertVC, animated: true, completion: nil)
    
}
}
