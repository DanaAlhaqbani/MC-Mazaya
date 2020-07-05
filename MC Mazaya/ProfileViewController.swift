//
//  ProfileViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 04/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//


import UIKit
import FirebaseDatabase


class ProfileViewController: UIViewController, ProfileDelegate, EditProfilePassData {

    func passDataBack(name: String, phone: String) {
        userData.name = name
        userData.phone = phone
    }
    
    
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var presenter: profilePresenter!
    
    func profileData(){
        self.NameLabel.text = userData.name
        self.EmailLabel.text = userData.email
        self.GenderLabel.text = userData.gender
        self.PhoneLabel.text = userData.phone
        self.PointsLabel.text = userData.points
        
        if ( self.GenderLabel.text == "أنثى"){
            UserIcon.image = #imageLiteral(resourceName: "femalee")
            GenderIcon.image = #imageLiteral(resourceName: "femaleGender")
            
        }else{
            UserIcon.image = #imageLiteral(resourceName: "male")
            GenderIcon.image = #imageLiteral(resourceName: "genderMale")
        }
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       view.generalGradiantView()
        setUpUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        profileData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    let profileImageUpper : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
      //  $0.image = #imageLiteral(resourceName: "profileWB")
        return $0
    }(UIImageView())
    
    let UserIcon : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = #imageLiteral(resourceName: "femalee")
        return $0
    }(UIImageView())
    
    let NameLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "دانة"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 40)
        $0.textColor = .darkGray
        
        return $0
    }(UILabel())
    
    let EmailLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Dana@gmail.com"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    let PointsLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "0"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 20)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    let PointsWord : UILabel = {
         $0.translatesAutoresizingMaskIntoConstraints = false
         $0.text = "نقاط"
         $0.textAlignment = .right
         $0.font = .boldSystemFont(ofSize: 20)
         $0.font = UIFont(name: "stc", size: 20)
         $0.textColor = .darkGray
         return $0
     }(UILabel())
    let GenderIcon : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = #imageLiteral(resourceName: "femaleGender")
        return $0
    }(UIImageView())
    let pointsIcon : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = #imageLiteral(resourceName: "femaleGender")
        return $0
    }(UIImageView())
    let passwordIcon : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = #imageLiteral(resourceName: "profile_phone")
        return $0
    }(UIImageView())
    
    lazy var EditButton : UIButton = {
        $0.addTarget(self, action: #selector(EditProfileAction), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        let green = UIColor(rgb: 0x38a089)
        $0.tintColor = green
        $0.setTitle("تعديل", for: .normal)
        $0.setImage(#imageLiteral(resourceName: "resizedEdit"), for: .normal)
        $0.setBackgroundImage(#imageLiteral(resourceName: "editButtonWhite"), for: .normal)
        $0.titleLabel?.font = UIFont(name: "stc", size: 22)
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIButton(type: .system))
    
   
    let GenderLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "أنثى"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 20)
        $0.font = UIFont(name: "stc", size: 30)
        $0.textColor = .darkGray
        
        return $0
    }(UILabel())
    
    let PhoneLabel : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "********"
        $0.textAlignment = .right
        $0.font = .boldSystemFont(ofSize: 30)
        $0.font = UIFont(name: "stc", size: 30)
        $0.textColor = .darkGray
        return $0
    }(UILabel())
    
    
    
    @objc func EditProfileAction() {
        //EditProfileViewController.img = UserIcon
        self.performSegue(withIdentifier: "goToEdit", sender: self)
    }
    

    
    
    
    
    func setUpUI()  {
        
        
        view.addSubview(profileImageUpper)
        profileImageUpper.addSubview(UserIcon)
        profileImageUpper.addSubview(NameLabel)
        profileImageUpper.addSubview(EmailLabel)
        profileImageUpper.addSubview(PointsLabel)

        
        view.addSubview(GenderIcon)
        view.addSubview(passwordIcon)
        view.addSubview(EditButton)
        view.addSubview(GenderLabel)
        view.addSubview(PhoneLabel)
        view.addSubview(PointsWord)

        
        NSLayoutConstraint.activate([
            profileImageUpper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageUpper.topAnchor.constraint(equalTo: view.topAnchor),
            profileImageUpper.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            profileImageUpper.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor , constant: 30),
            
            UserIcon.rightAnchor.constraint(equalTo: profileImageUpper.rightAnchor , constant: -40),
            UserIcon.topAnchor.constraint(equalTo: profileImageUpper.centerYAnchor, constant: -60),
            UserIcon.heightAnchor.constraint(equalToConstant: 130),
            UserIcon.widthAnchor.constraint(equalToConstant: 130),
            
            
            NameLabel.rightAnchor.constraint(equalTo: UserIcon.leftAnchor , constant: -8),
            NameLabel.topAnchor.constraint(equalTo: profileImageUpper.centerYAnchor, constant: -30),
            EmailLabel.rightAnchor.constraint(equalTo: UserIcon.leftAnchor , constant: -8),
            EmailLabel.topAnchor.constraint(equalTo: profileImageUpper.centerYAnchor, constant: 17),
            
            PointsLabel.rightAnchor.constraint(equalTo: UserIcon.leftAnchor , constant: -8),
            PointsLabel.topAnchor.constraint(equalTo: profileImageUpper.centerYAnchor, constant: 48),
            
            PointsWord.rightAnchor.constraint(equalTo: UserIcon.leftAnchor , constant: -25),
            PointsWord.topAnchor.constraint(equalTo: profileImageUpper.centerYAnchor, constant: 48),
                       
            GenderIcon.topAnchor.constraint(equalTo: profileImageUpper.bottomAnchor, constant: 70),
            GenderIcon.rightAnchor.constraint(equalTo: profileImageUpper.rightAnchor , constant: -40),
            passwordIcon.topAnchor.constraint(equalTo: profileImageUpper.bottomAnchor, constant: 170),
            passwordIcon.rightAnchor.constraint(equalTo: profileImageUpper.rightAnchor , constant: -40),
            
            EditButton.topAnchor.constraint(equalTo: profileImageUpper.bottomAnchor, constant: 0),
            EditButton.leftAnchor.constraint(equalTo: profileImageUpper.leftAnchor, constant: 30),
            
            
            GenderLabel.topAnchor.constraint(equalTo: profileImageUpper.bottomAnchor, constant: 70),
            GenderLabel.rightAnchor.constraint(equalTo: profileImageUpper.rightAnchor , constant: -100),
            PhoneLabel.topAnchor.constraint(equalTo: profileImageUpper.bottomAnchor, constant: 170),
            PhoneLabel.rightAnchor.constraint(equalTo: profileImageUpper.rightAnchor , constant: -90),
        ])
        
    }
    
}
