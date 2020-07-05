//
//  homeViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 02/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import SideMenu
import Firebase
import FirebaseAuth

struct userData {
    static var name = ""
    static var email = ""
    static var password = ""
    static var gender = ""
    static var phone = ""
    static var points = ""


}
class homeViewController: UIViewController, MenuListControllerDelegate {
   private let Region = RegionViewController()
    private let ViewFamily = FamilyViewController()
    private let Faviorate = FavoriteViewController()
    private let NewOffers = NewOffersViewController()
    private let UsedOffers = UsedOffersViewController()
    private let SuggestOffer = SuggestOfferViewController()
    private let Vouchers = VouchersViewController()
    private let Communication = CommunicateUsViewController()


    
  let user = Auth.auth().currentUser
     var ref: DatabaseReference?
     var handle: DatabaseHandle?
    var SideMenu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataUser()
        let menu = MenuListController(MeniItems: ["المنطقة","عائلتي","المفضلة","جديد العروض","الصفقات المستخدمة","إقترح عرضاً","القسائم الشرائية","تواصل معنا","تسجيل الخروج"])
        SideMenu = SideMenuNavigationController(rootViewController: menu)
        SideMenu?.leftSide = true
        SideMenu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.rightMenuNavigationController = SideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        SideMenu?.statusBarEndAlpha = 0
        menu.delegate = self

       addChildController()

    }
    func didSelectMenuItem(name: String) {
        self.title = name
        SideMenu?.dismiss(animated: true, completion: {
            if name == "المنطقة" {
                self.Region.view.isHidden = false
                self.ViewFamily.view.isHidden = true
                self.Faviorate.view.isHidden = true
                self.NewOffers.view.isHidden = true
                self.UsedOffers.view.isHidden = true
                self.SuggestOffer.view.isHidden = true
                self.Vouchers.view.isHidden = true
                self.Communication.view.isHidden = true
            }
            else if name == "عائلتي" {
                self.Region.view.isHidden = true
                self.ViewFamily.view.isHidden = false
                self.Faviorate.view.isHidden = true
                self.NewOffers.view.isHidden = true
                self.UsedOffers.view.isHidden = true
                self.SuggestOffer.view.isHidden = true
                self.Vouchers.view.isHidden = true
                self.Communication.view.isHidden = true

            }
            else if name == "المفضلة" {
                self.Region.view.isHidden = true
                self.ViewFamily.view.isHidden = true
                self.Faviorate.view.isHidden = false
                self.NewOffers.view.isHidden = true
                self.UsedOffers.view.isHidden = true
                self.SuggestOffer.view.isHidden = true
                self.Vouchers.view.isHidden = true
                self.Communication.view.isHidden = true
                           
            }
            else if name == "جديد العروض" {
                self.Region.view.isHidden = true
                self.ViewFamily.view.isHidden = true
                self.Faviorate.view.isHidden = true
                self.NewOffers.view.isHidden = false
                self.UsedOffers.view.isHidden = true
                self.SuggestOffer.view.isHidden = true
                self.Vouchers.view.isHidden = true
                self.Communication.view.isHidden = true
                             
              }
            else if name == "الصفقات المستخدمة" {
                self.Region.view.isHidden = true
                self.ViewFamily.view.isHidden = true
                self.Faviorate.view.isHidden = true
                self.NewOffers.view.isHidden = true
                self.UsedOffers.view.isHidden = false
                self.SuggestOffer.view.isHidden = true
                self.Vouchers.view.isHidden = true
                self.Communication.view.isHidden = true
                                    
              }
            else if name ==  "إقترح عرضاً" {
                self.Region.view.isHidden = true
                self.ViewFamily.view.isHidden = true
                self.Faviorate.view.isHidden = true
                self.NewOffers.view.isHidden = true
                self.UsedOffers.view.isHidden = true
                self.SuggestOffer.view.isHidden = false
                self.Vouchers.view.isHidden = true
                self.Communication.view.isHidden = true
                                        
              }
            else if name ==  "القسائم الشرائية" {
                self.Region.view.isHidden = true
                self.ViewFamily.view.isHidden = true
                self.Faviorate.view.isHidden = true
                self.NewOffers.view.isHidden = true
                self.UsedOffers.view.isHidden = true
                self.SuggestOffer.view.isHidden = true
                self.Vouchers.view.isHidden = false
                self.Communication.view.isHidden = true
                                                   
            }
            else if name ==  "تواصل معنا" {
                self.Region.view.isHidden = true
                self.ViewFamily.view.isHidden = true
                self.Faviorate.view.isHidden = true
                self.NewOffers.view.isHidden = true
                self.UsedOffers.view.isHidden = true
                self.SuggestOffer.view.isHidden = true
                self.Vouchers.view.isHidden = true
                self.Communication.view.isHidden = false
                                                   
            }
            else if name ==  "تسجيل الخروج" {
              
                self.logout()
            }
        })
    }
    @IBAction func didTapMenu(){
        present(SideMenu! , animated: true)
    }

    private func addChildController(){
        addChild(Region)
        addChild(ViewFamily)
        addChild(Faviorate)
        addChild(NewOffers)
        addChild(UsedOffers)
        addChild(SuggestOffer)
        addChild(Vouchers)
        addChild(Communication)
        view.addSubview(Region.view)
        view.addSubview(ViewFamily.view)
        view.addSubview(Faviorate.view)
        view.addSubview(NewOffers.view)
        view.addSubview(UsedOffers.view)
        view.addSubview(SuggestOffer.view)
        view.addSubview(Vouchers.view)
        view.addSubview(Communication.view)
        Region.view.frame = view.bounds
        ViewFamily.view.frame = view.bounds
        Faviorate.view.frame = view.bounds
        NewOffers.view.frame = view.bounds
        UsedOffers.view.frame = view.bounds
        SuggestOffer.view.frame = view.bounds
        Vouchers.view.frame = view.bounds
        Communication.view.frame = view.bounds
        Region.didMove(toParent: self)
        ViewFamily.didMove(toParent: self)
        Faviorate.didMove(toParent: self)
        NewOffers.didMove(toParent: self)
        UsedOffers.didMove(toParent: self)
        SuggestOffer.didMove(toParent: self)
        Vouchers.didMove(toParent: self)
        Communication.didMove(toParent: self)
        Region.view.isHidden = true
        ViewFamily.view.isHidden = true
        Faviorate.view.isHidden = true
        NewOffers.view.isHidden = true
        UsedOffers.view.isHidden = true
        SuggestOffer.view.isHidden = true
        Vouchers.view.isHidden = true
        Communication.view.isHidden = true

    }
    func logout() {
    
    try! Auth.auth().signOut()
        
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginViewController")
            self.present(vc, animated: true, completion: nil)
        }

    }
    func dataUser () {
           
           ref = Database.database().reference()
           handle = ref?.child("Users").child((user?.uid)!).child("Name").observe(.value, with: { (snapshot) in
               let currentName = snapshot.value as? String
               userData.name = currentName!
           })
           handle = ref?.child("Users").child((user?.uid)!).child("Email").observe(.value, with: { (snapshot) in
               let currentEmail = snapshot.value as? String
               userData.email  = currentEmail!
           })
           handle = ref?.child("Users").child((user?.uid)!).child("Gender").observe(.value, with: { (snapshot) in
               let currentGender = snapshot.value as? String
               userData.gender  = currentGender!
               
           })
          handle = ref?.child("Users").child((user?.uid)!).child("Phone").observe(.value, with: { (snapshot) in
                  let currentPhone = snapshot.value as? String
                  userData.phone = currentPhone!
              })
        handle = ref?.child("Users").child((user?.uid)!).child("Points").observe(.value, with: { (snapshot) in
                   let currentPoints = snapshot.value as? String
             userData.points = currentPoints!
               })
       }
}
