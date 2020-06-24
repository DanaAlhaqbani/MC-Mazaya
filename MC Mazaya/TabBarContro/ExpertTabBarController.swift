////
////  ExpertTabBarController.swift
////  Musaned
////
////  Copyright © 2020 ALHANOUF . All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//class ExpertTabBarController: UITabBarController {
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//         
//        
//        if Auth.auth().currentUser == nil {
//            //show if not logged in
//            DispatchQueue.main.async {
//
//                let firstPageController = FirstPageController()
//                UIApplication.shared.windows.first?.rootViewController = firstPageController
//                UIApplication.shared.windows.first?.makeKeyAndVisible()
//                
//
//                
//            }
//            
//            return
//        }
//        
//        
//        setupViewControllers()
//        
//        
//    }
//    
//    func setupExpertViewControllers() {
//        let storyborard = UIStoryboard(name: "Main", bundle: nil)
//               let accountVC = storyborard.instantiateViewController(identifier: "account")
//               let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//               let mainVC = mainStoryBoard.instantiateViewController(identifier: "categoryId")
//               let itemVC = DonationListController()
//               let donationVC = DonationCVController()
//               let messageVC = MessagesTableView()
//               let donationStoryboard = UIStoryboard(name: "Main", bundle: nil)
//               let donationVc = donationStoryboard.instantiateViewController(identifier: "donationId")
//               donationVc.navigationItem.title = "صفحة التبرع"
//
//               
//                
//               viewControllers = [
//                   createNavController(viewController: accountVC, title: "حسابي", imageName: "profile"),createNavController(viewController: messageVC, title: "الاستفسارات", imageName: "icons8-inquiry-48")]
//    }
//    
//    func setupViewControllers() {
//        
//        let storyborard = UIStoryboard(name: "Main", bundle: nil)
//        let accountVC = storyborard.instantiateViewController(identifier: "account")
//        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//        let mainVC = mainStoryBoard.instantiateViewController(identifier: "categoryId")
//        let itemVC = DonationListController()
//        let donationVC = DonationCVController()
//        let messageVC = MessagesTableView()
//        let donationStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let donationVc = donationStoryboard.instantiateViewController(identifier: "donationId")
//        donationVc.navigationItem.title = "صفحة التبرع"
//
//        
//         
//        viewControllers = [
//            createNavController(viewController: CategoryViewController(), title: "الريسية", imageName: "icons8-home-48"),createNavController(viewController: accountVC, title: "حسابي", imageName: "profile"),createNavController(viewController: itemVC, title: "التبرعات", imageName: "basket"),createNavController(viewController: messageVC, title: "الاستفسارات", imageName: "icons8-inquiry-48")]
//    }
//    
//    @objc func handleNext() {
//        
//    }
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
