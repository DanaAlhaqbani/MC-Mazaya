//
//  FamilyViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

class FamilyViewController: UIViewController {

 
        override func viewDidLoad() {
            super.viewDidLoad()

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
           print("=========Pressed FAQ=========")
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let secondVC = storyboard.instantiateViewController(identifier: "enter")
           
            navigationController?.pushViewController(secondVC, animated: true)

            
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
                    let secondVC = storyboard.instantiateViewController(identifier: "FamilyList")
                    
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
                   FAQ.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
                   FAQ.topAnchor.constraint(equalTo: upperView.centerYAnchor, constant: -10),
                                
                    Email.heightAnchor.constraint(equalToConstant: 160),
                    Email.widthAnchor.constraint(equalToConstant: 160),
                    Email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    Email.topAnchor.constraint(equalTo: view.topAnchor , constant: 360),

                   CommunicationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,  constant: 20),
                   CommunicationLabel.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
                   
                      ])
                     
                   
    }
    }
