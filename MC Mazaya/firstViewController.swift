//
//  firstViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 08/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class firstViewController: UIViewController {
    var timer = Timer()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.generalGradiantView()
        DispatchQueue.main.async {
                self.showApp()
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                }

                //UI
                setupUI()
                
                logoImage.transform = CGAffineTransform(scaleX: 0.0000001, y: 0.0000001)
                titleImage.transform = CGAffineTransform(scaleX: 0.0000001, y: 0.0000001)
                
                UIView.animate(withDuration: 1.5, delay: 2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.4, options: .curveEaseInOut, animations: {
                    self.logoImage.transform = .identity
                    self.titleImage.transform = .identity
                }) { (true) in
        //            self.timer = Timer.scheduledTimer(timeInterval: 12, target: self, selector: #selector(self.showApp), userInfo: nil, repeats: false)
                    self.timer = Timer.scheduledTimer(timeInterval: 12, target: self, selector: #selector(self.nothing), userInfo: nil, repeats: false)
                }
                
                
                    }
    
    @objc func nothing() {
           }
       
       @objc func showApp() {
        self.authenticateUserAndConfigureView()

    }
       
       
       let logoImage : UIImageView = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.image = #imageLiteral(resourceName: "LogoMaz")
           $0.clipsToBounds = true
           $0.contentMode = .scaleAspectFit
           return $0
       }(UIImageView())
       
       let titleImage : UIImageView = {
           $0.translatesAutoresizingMaskIntoConstraints = false
           $0.image = #imageLiteral(resourceName: "utBt")
           $0.clipsToBounds = true
           $0.contentMode = .scaleAspectFit
           return $0
       }(UIImageView())
    func authenticateUserAndConfigureView(){
       
            if Auth.auth().currentUser?.email == "mazaya@mc.gov.sa" {
                       moveToAdminViewController()
                   }
                   else if Auth.auth().currentUser?.uid != nil {
                       
                       //user is logged in
                       moveToTheTabBarViewController()
                       print("444444444444444444444444444///")
                   }else{
                       //user is not logged in
                       moveToLoginViewController()
                       print("/////////////////////")
                   }
       }
        func moveToAdminViewController () {
            
            if let storyboard = self.storyboard{
                
                let navigationController = storyboard.instantiateViewController(withIdentifier: "adminPages") as! UINavigationController
                if let adminHomeViewController = navigationController.viewControllers.first as? AdminHomeViewController {

                }
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
                
                
            }
        }
    func moveToTheTabBarViewController () {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "VCTabBar") as? UITabBarController

        
        // home page
        let userNavViewController = homeViewController?.viewControllers![1] as? UINavigationController
        let userHomeViewController = userNavViewController?.viewControllers[0] as? homeViewController

        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
       func moveToLoginViewController () {
           
           if let storyboard = self.storyboard{
               
               let newViewController = storyboard.instantiateViewController(withIdentifier: "loginNV") as! UINavigationController
           
               newViewController.modalPresentationStyle = .fullScreen
               self.present(newViewController, animated: true, completion: nil)
           }
       }
    

}
    extension firstViewController {
        
        func setupUI() {
            view.addSubview( logoImage)
            view.addSubview(titleImage)
            
            
            NSLayoutConstraint.activate([
                
                titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                titleImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
                titleImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
                titleImage.heightAnchor.constraint(equalTo: titleImage.widthAnchor, multiplier: 0.7),
                
                logoImage.bottomAnchor.constraint(equalTo: titleImage.topAnchor, constant: -10),
                logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImage.heightAnchor.constraint(equalToConstant: 250),
                logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor)
                
            ])
        }
    }

