////
////  MainTabBarController.swift
////  Musaned
////
////  Copyright © 2020 ALHANOUF . All rights reserved.
////
//
//import UIKit
//import Firebase
//class MainTabBarController: UITabBarController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let id = UserDefaults.standard.string(forKey: "id")
//        print("UserDeful STATUS:\(String(describing: id))")
//
//
//        if Auth.auth().currentUser == nil {
//            //show if not logged in
//            DispatchQueue.main.async {
//
//                let loginController = FirstPageController()
//                               let navController = UINavigationController(rootViewController: loginController)
//                               self.present(navController, animated: true, completion: nil)
//
////                let firstPageController = FirstPageController()
//                UIApplication.shared.windows.first?.rootViewController = firstPageController
////                UIApplication.shared.windows.first?.makeKeyAndVisible()
//            }
//
//            return
//
//
//        } else if Auth.auth().currentUser?.uid == "Rrq7OgG4j2QiBg1GYHXehSFPtHg2" {
//            print("entering as Admin")
//            self.adminSetupViews()
//            return
//        } else {
//            switch UserDefaults.standard.string(forKey: "id") {
//             case Experts.exId:
//                 print("entering as Expert")
//                 self.setupExpertViewControllers()
//             case "owner":
//                 print("entering as Owner")
//                 self.setupOwnerViewControllers()
//             case "admin":
//                 print("entering as Admin")
//                 self.adminSetupViews()
//                 case "unapproved":
//                 print("exsting as upapproved")
//                let expertSingupLoginPresneter = ExpertSingupLoginPresneter()
//                 UIApplication.shared.windows.first?.rootViewController = expertSingupLoginPresneter
//                 UIApplication.shared.windows.first?.makeKeyAndVisible()
//
//                 case "user":
//                 self.setupViewControllers()
//             default:
//                 let firstPageController = FirstPageController()
//                 UIApplication.shared.windows.first?.rootViewController = firstPageController
//                 UIApplication.shared.windows.first?.makeKeyAndVisible()
//             }
//
//        }
//
//
////        switch UserDefaults.standard.string(forKey: "id") {
////        case Experts.exId:
////            print("entering as Expert")
////            self.setupExpertViewControllers()
////        case "owner":
////            print("entering as Owner")
////            self.setupOwnerViewControllers()
////        case "admin":
////            print("entering as Admin")
////            self.adminSetupViews()
////            case "unapproved":
////            print("exsting as upapproved")
////           let expertSingupLoginPresneter = ExpertSingupLoginPresneter()
////            UIApplication.shared.windows.first?.rootViewController = expertSingupLoginPresneter
////            UIApplication.shared.windows.first?.makeKeyAndVisible()
////
////            case "user":
////            self.setupViewControllers()
////        default:
////            let firstPageController = FirstPageController()
////            UIApplication.shared.windows.first?.rootViewController = firstPageController
////            UIApplication.shared.windows.first?.makeKeyAndVisible()
////        }
////
//
//    }
//
//
//    func checkStatus() {
//        switch UserDefaults.standard.string(forKey: "id") {
//         case Experts.exId:
//             print("entering as Expert")
//             self.setupExpertViewControllers()
//         case "owner":
//             print("entering as Owner")
//             self.setupOwnerViewControllers()
//         case "admin":
//             print("entering as Admin")
//             self.adminSetupViews()
//             case "unapproved":
//             print("exsting as upapproved")
//            let expertSingupLoginPresneter = ExpertSingupLoginPresneter()
//             UIApplication.shared.windows.first?.rootViewController = expertSingupLoginPresneter
//             UIApplication.shared.windows.first?.makeKeyAndVisible()
//
//             case "user":
//             self.setupViewControllers()
//         default:
//             let firstPageController = FirstPageController()
//             UIApplication.shared.windows.first?.rootViewController = firstPageController
//             UIApplication.shared.windows.first?.makeKeyAndVisible()
//         }
//
//    }
//
//
//    func setupOwnerViewControllers() {
//
//        let accountVC = OwnerProfileController()
//        let itemVC = DonationListController()
//        let itemCVC = AddItemCVController()
//
//
//
//        viewControllers = [
//            createNavController(viewController: CategoryViewController(), title: "الريسية", imageName: "icons8-home-48"), createNavController(viewController: itemCVC, title: "اضف منتجات", imageName: "icons8-electric-wheelchair-60"),createNavController(viewController: itemVC, title: "التبرعات", imageName: "basket"), createNavController(viewController: accountVC, title: "حسابي", imageName: "profile")]
//    }
//
//    func setupExpertViewControllers() {
//
//        let expertProfile = ExpertProfileController()
//        let messageVC = ExpertMessageTableController()
//
//        viewControllers = [
//            createNavController(viewController: messageVC, title: "الاستفسارات", imageName: "icons8-inquiry-48"),createNavController(viewController: expertProfile, title: "حسابي", imageName: "profile")]
//    }
//
//    func setupViewControllers() {
//        let itemVC = DonationListController()
//        let profileVC = UserProfileViewController()
//        let messageVC = MessagesTableView()
//        //        let SearchController = SearchItemsController()
//        let donationStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let donationVc = donationStoryboard.instantiateViewController(identifier: "donationId")
//        donationVc.navigationItem.title = "صفحة التبرع"
//
//
//        viewControllers = [
//            createNavController(viewController: CategoryViewController(), title: "الريسية", imageName: "icons8-home-48"),createNavController(viewController: profileVC, title: "حسابي", imageName: "profile"),createNavController(viewController: itemVC, title: "التبرعات", imageName: "basket"),createNavController(viewController: messageVC, title: "الاستفسارات", imageName: "icons8-inquiry-48")]
//    }
//
//
//    func adminSetupViews() {
//
//        let itemVC = DonationListController()
//        let profileVC = UserProfileViewController()
//        let adminPage = AcceptExpertViewController()
//        let donationStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let donationVc = donationStoryboard.instantiateViewController(identifier: "donationId")
//        donationVc.navigationItem.title = "صفحة التبرع"
//
//
//
//        viewControllers = [
//            createNavController(viewController: CategoryViewController(), title: "الريسية", imageName: "icons8-home-48"),createNavController(viewController: profileVC, title: "حسابي", imageName: "profile"),createNavController(viewController: itemVC, title: "التبرعات", imageName: "basket"), createNavController(viewController: adminPage, title: "قبول", imageName: "icons8-inquiry-48")]
//    }
//
//
//
//
//    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
//        let navController = UINavigationController(rootViewController: viewController)
//        navController.tabBarItem.title = title
//        navController.tabBarItem.image = UIImage(named: imageName)
//        return navController
//
//    }
//}
//
