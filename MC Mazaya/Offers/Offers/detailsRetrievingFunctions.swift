//
//  retrieveOffers.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 08/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import Firebase

extension detailsViewController {
    
    //MARK: - Retrieve offers
    func getOffers(){
        ref.child("Offers").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                // Create instance of offer model
                let offer = Offer(snap: snap, trademark: self.tradeInfo)
                // Add offer to offers array to show in embedded view
                self.offers.append(offer)
            } // End of itaration over offers
            self.filterOffers()
            if let vc = self.children[0] as? OfferView {
                vc.offers = self.filteredOffers
            } // End of send data to embedded offer view
        }) // End of observation
    } // End of get offers function
    
    //MARK: - Retrieve Branches
    func getBranches(){
        ref.child("Trademarks/\(tradeInfo.trademarkID!)/Branches").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let branch = Branch(snap: snap)
                self.branches.append(branch)
            } // end of itaration over branches
            if let vc = self.children[1] as? BranchView {
                vc.branches = self.branches
            } // End of send data to embedded branches view
        }) // End of obseravtion
    } // End of get branches function
    
    //MARK: - Filter Offers
    func filterOffers(){
        self.filteredOffers = []
        for offer in offers {
            if userData.region == "الكل" && offer.userType == "الكل" && offer.trademarkID == tradeInfo.trademarkID {
                self.filteredOffers.append(offer)
            } else if userData.region == "الكل" && offer.userType == userData.userType && offer.trademarkID == tradeInfo.trademarkID {
                self.filteredOffers.append(offer)
            } else {
                if offer.trademarkID == tradeInfo.trademarkID {
                    let branches = offer.branches!
                    for branch in branches {
                        if branch.region == userData.region && (offer.userType == userData.userType || offer.userType == "الكل") {
                            self.filteredOffers.append(offer)
                        }
                    }
                }
            }
        }
    }
    
    
}
