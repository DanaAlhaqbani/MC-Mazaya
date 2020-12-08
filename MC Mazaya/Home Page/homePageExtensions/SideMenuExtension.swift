//
//  SideMenuExtension.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 27/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extension "Side menu setup"
extension homePageViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isMenuShow = false
        mainViewXConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                        self.view.layoutIfNeeded()
                       }, completion: nil)
        navigationItem.titleView?.endEditing(true)
        tbleList.isUserInteractionEnabled = true
        //        navigationController?.view.endEditing(true)
    }
    
    @objc func menuTapped() {
        if isMenuShow {
            mainViewXConstraint.constant = 0
            tbleList.isUserInteractionEnabled = true
            
        } else {
            mainViewXConstraint.constant = -sideMenuWidth
            tbleList.isUserInteractionEnabled = false
        }
        UIView.animate(withDuration: 0.5, delay: 0.0,
                       usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
                       options: .curveEaseInOut, animations: {
                        self.view.layoutIfNeeded()
                       }, completion: nil)
        
        isMenuShow.toggle()
    }
    
    @objc func filterTapped() {
        self.performSegue(withIdentifier: "filter", sender: self)
    }
    
    @objc func menuButtonsActions(_ sender : UIButton) {
        if sender.tag == 10 {
            //            performSegue(withIdentifier: "toRegion", sender: self)
            // get a reference to the view controller for the popover
            let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "regionPopover") as! RegionVC
            // set the presentation style
            popController.modalPresentationStyle = UIModalPresentationStyle.popover
            // set up the popover presentation controller
            popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
            popController.popoverPresentationController?.delegate = self
            popController.popoverPresentationController?.sourceView = sender // button
            popController.popoverPresentationController?.sourceRect = sender.bounds
            self.regionDropDownMenu.anchorView = sender
            self.setupRegionsDropDownMenu()
            self.regionDropDownMenu.show()
        }
        else if sender.tag == 11 {
            performSegue(withIdentifier: "toFamily", sender: self)
            //navigationController?.pushViewController(FamilyViewController(), animated: true)
        }
        else if sender.tag == 12 {
            performSegue(withIdentifier: "toFav", sender: self)
            // navigationController?.pushViewController(FavoriteViewController(), animated: true)
        }
        else if sender.tag == 13 {
            performSegue(withIdentifier: "toNewOffers", sender: self)
            //navigationController?.pushViewController(NewOffersViewController(), animated: true)
        }
        else if sender.tag == 14 {
            performSegue(withIdentifier: "toSuggest", sender: self)
            //navigationController?.pushViewController(SuggestOfferViewController(), animated: true)
        }
        else if sender.tag == 15 {
            performSegue(withIdentifier: "toVouchers", sender: self)
            //navigationController?.pushViewController(VouchersViewController(), animated: true)
        }
        else if sender.tag == 16 {
            performSegue(withIdentifier: "toCom", sender: self)
            //navigationController?.pushViewController(CommunicateUsViewController(), animated: true)
        }
        else if  sender.tag == 17 {
            logout()
        }
        if sender.tag == 10 {
            isMenuShow = true
        } else {
            mainViewXConstraint.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0.0,
                           usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
                           options: .curveEaseInOut, animations: {
                            self.view.layoutIfNeeded()
                           }, completion: nil)
            
            isMenuShow = false
            
            
        }
    }
    
    func setupRegionsDropDownMenu(){
        self.regionDropDownMenu.dataSource = ["الكل", "الرياض", "مكة المكرمة", "القصيم", "منطقة الشرقية", "الحدود الشمالية", "المدينة المنورة", "نجران", "جازان", "الباحة", "عسير", "حائل",
                                              "تبوك", "الجوف"]
        regionDropDownMenu.selectionAction = { [weak self] (index: Int, item: String) in //8
            guard let _ = self else { return }
            self?.selectedRegion = item
            self?.ref?.child("Users/\((self?.user?.uid)!)/region").setValue(self?.selectedRegion)
            self?.mainViewXConstraint.constant = 0
            UIView.animate(withDuration: 0.5, delay: 0.0,
                           usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
                           options: .curveEaseInOut, animations: {
                            self?.view.layoutIfNeeded()
                           }, completion: nil)
            DispatchQueue.main.async {
                //                self?.Categories = []
                //                self?.Trades = []
                //                self?.filteredTradeMarks = []
                self?.tbleList.reloadData()
            }
            //            self?.getCategories((self?.selectedRegion!)!)
        }
    }
    
}

