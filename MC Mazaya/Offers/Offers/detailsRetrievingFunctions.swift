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
                let key = snap.key
                let offersIds = self.tradeInfo.offers! as [String]
                for id in offersIds {
                    if id == key {
                        let offer = Offer(discountCode: snap.childSnapshot(forPath: "discountCode").value as? String,
                                          offersDetails: snap.childSnapshot(forPath: "offerDetails").value as? String,
                                          offerTitle: snap.childSnapshot(forPath: "offerTitle").value as? String,
                                          serviceType: snap.childSnapshot(forPath: "serviceType").value as? String,
                                          endDate: snap.childSnapshot(forPath: "endDate").value as? String,
                                          startDate: snap.childSnapshot(forPath: "startDate").value as? String,
                                          trademarkID: snap.childSnapshot(forPath: "trademarkID").value as? String,
                                          userType: snap.childSnapshot(forPath: "userType").value as? String,
                                          usageType: snap.childSnapshot(forPath: "usageType").value as? String,
                                          branches: snap.childSnapshot(forPath: "Branches").value as? [String])
                        // Add offer to offers array to show in embedded view
                        self.offers.append(offer)
                    } // Ensure that offer belongs to this trademark
                } // End of iteration over all offers' Ids

            } // End of itaration over offers
            if let vc = self.children[0] as? OfferView {
                vc.offers = self.offers
            } // End of send data to embedded offer view
        }) // End of observation
    } // End of get offers function
    
    //MARK: - Retrieve Branches
    func getBranches(){
        ref.child("\(String(describing: tradeInfo.tradmarkID))/Branches").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let branch = Branch(branchName : snap.childSnapshot(forPath: "branchName").value as? String,
                                    description : snap.childSnapshot(forPath: "description").value as? String,
                                    latitude : snap.childSnapshot(forPath: "latitude").value as? String,
                                    longitude: snap.childSnapshot(forPath: "longitude").value as? String,
                                    region:snap.childSnapshot(forPath: "region").value as? String)
                self.branches.append(branch)
            } // end of itaration over branches
            if let vc = self.children[1] as? BranchView {
                vc.branches = self.branches
            } // End of send data to embedded branches view
        }) // End of obseravtion
    } // End of get branches function
    
}
