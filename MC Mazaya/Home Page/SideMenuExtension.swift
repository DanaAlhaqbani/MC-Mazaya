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
        leftBarButtonItem.tintColor = green
        UIView.animate(withDuration: 0.5, delay: 0.0,
        usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
        self.view.layoutIfNeeded()
        }, completion: nil)
        tbleList.isUserInteractionEnabled = true
    }
           
    @objc func menuTapped() {
        if isMenuShow {
            mainViewXConstraint.constant = 0
            leftBarButtonItem.tintColor = green
            tbleList.isUserInteractionEnabled = true
        
        } else {
            mainViewXConstraint.constant = -sideMenuWidth
            leftBarButtonItem.tintColor = .white
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
            performSegue(withIdentifier: "toRegion", sender: self)
//            navigationController?.pushViewController(RegionViewController(), animated: true)
        }
        else if sender.tag == 11 {
            performSegue(withIdentifier: "toFamily", sender: self)
            //navigationController?.pushViewController(FamilyViewController(), animated: true)
        }
        else if sender.tag == 12 {
            performSegue(withIdentifier: "toFav", sender: self.favDictionary)
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
        mainViewXConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.0,
        usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
            options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
        }, completion: nil)
        isMenuShow = false
        leftBarButtonItem.tintColor = green
        }
}
