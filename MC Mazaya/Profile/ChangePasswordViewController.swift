//
//  ChangePasswordViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 04/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit


class ChangePassViewController: UIViewController , ChangePassDelegate{
    
    var presenter: ChangePassPresenter!
    
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
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setUpUI()
        
        presenter = ChangePassPresenter()
        presenter.delegate = self
        
    }
    func failure(alert: UIAlertController) {
        alert.dismiss(animated: true, completion: nil)
        
    }
    
    func successful() {
        navigationController?.popViewController(animated: true)
        
    }
    
    func performChange() {
        presenter.changePass(newPass: newPasswordField.textField.text!)
    }
    
    
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    let upperView : UIImageView = {
         $0.translatesAutoresizingMaskIntoConstraints = false
         $0.contentMode = .scaleToFill
         $0.clipsToBounds = true
        // $0.image = #imageLiteral(resourceName: "profileWB")
         return $0
     }(UIImageView())
    let currentPasswordLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "كلمة المرور الحالية"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    let newPasswordLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "كلمة المرور الجديدة"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    let confirmPasswordLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "تأكيد كلمة المرور الجديدة"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    let currentPasswordField : InputTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholderColor(text: "******", color: .black)
        $0.isUserInteractionEnabled = true
        $0.setPass()
        return $0
    }(InputTextField())
    
    let newPasswordField : InputTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholderColor(text: "******", color: .black)
        $0.isUserInteractionEnabled = true
        $0.setPass()
        return $0
    }(InputTextField())
    
    let confirmPasswordField : InputTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textField.placeholderColor(text: "******", color: .black)
        $0.isUserInteractionEnabled = true
        $0.setPass()
        return $0
    }(InputTextField())
    
    lazy var updateButton : UIButton = {
        $0.addTarget(self, action: #selector(updateButtonAction), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let green = UIColor(rgb: 0x38a089)
        $0.tintColor = green
        $0.setTitle("تحديث ", for: .normal)
        $0.titleLabel?.font = UIFont(name: "stc", size: 22)
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: "refresh"), for: .normal)
        $0.setBackgroundImage(UIImage(named: "utBt"), for: .normal)
        return $0
    }(UIButton(type: .system))
    let userIcon : UIImageView = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.contentMode = .scaleAspectFit
           $0.clipsToBounds = true
           $0.image = #imageLiteral(resourceName: "resetPass_icon")
           return $0
       }(UIImageView())
    let passPageLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "تغيير كلمة المرور"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        let green = UIColor(rgb: 0x38a089)
        $0.textColor = green
        
        return $0
    }(UILabel())
    
    @objc func updateButtonAction() {
        print("Update work")
        presenter.validateData(oldPass: currentPasswordField.textField.text!, newPass: newPasswordField.textField.text!, confirmPass: confirmPasswordField.textField.text!)
        
    }
    func setUpUI()  {
        
        view.addSubview(upperView)
        upperView.addSubview(userIcon)
       upperView.addSubview(passPageLabel)
        
               
        
        view.addSubview(currentPasswordLabel)
        view.addSubview(newPasswordLabel)
        
        view.addSubview(confirmPasswordLabel)
        view.addSubview(currentPasswordField)
        
        view.addSubview(newPasswordField)
        view.addSubview(confirmPasswordField)
        
        
        
        view.addSubview(updateButton)
        view.addSubview(passPageLabel)
        
        
        NSLayoutConstraint.activate([
           upperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                       upperView.topAnchor.constraint(equalTo: view.topAnchor),
                       upperView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
                       upperView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor , constant: 30),
                       
                       userIcon.topAnchor.constraint(equalTo: upperView.centerYAnchor, constant: -50),
                       
                       userIcon.heightAnchor.constraint(equalToConstant: 160),
                       userIcon.widthAnchor.constraint(equalToConstant: 160),
                       userIcon.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
                       
                       passPageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                       passPageLabel.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
                       
            currentPasswordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            currentPasswordLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor , constant: -30),
            
            currentPasswordField.topAnchor.constraint(equalTo: currentPasswordLabel.bottomAnchor , constant: 0),
            currentPasswordField.rightAnchor.constraint(equalTo: currentPasswordLabel.rightAnchor),
            currentPasswordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
            newPasswordLabel.topAnchor.constraint(equalTo: currentPasswordField.bottomAnchor, constant: 10),
            newPasswordLabel.rightAnchor.constraint(equalTo: currentPasswordLabel.rightAnchor),
            
            newPasswordField.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor),
            newPasswordField.rightAnchor.constraint(equalTo: currentPasswordLabel.rightAnchor),
            newPasswordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: newPasswordField.bottomAnchor, constant: 10),
            confirmPasswordLabel.rightAnchor.constraint(equalTo: currentPasswordLabel.rightAnchor),
            
            confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor),
            confirmPasswordField.rightAnchor.constraint(equalTo: currentPasswordLabel.rightAnchor),
            confirmPasswordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
         
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -40),
            
        ])
        
        
        
    }
    
}
