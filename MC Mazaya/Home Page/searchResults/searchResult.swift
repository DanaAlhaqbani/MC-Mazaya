//
//  searchResult.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 10/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

protocol reloadResultsCollection {
    func reloadCollection()
}

protocol ResultCollectionCellDelegator {
    func callSegueFromTradeCell(myData dataobject: Trademark)
}

class searchResult: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var didSelectItemAction: ((IndexPath) -> Void)?
    var tradeDelegate : ResultCollectionCellDelegator! = nil
    var delegate : reloadResultsCollection! = nil
    var offers : [Offer]!
    var trademarks : [Trademark]?
    {
        didSet {
          collectionView.reloadData()
            if let delegate = delegate {
            delegate.reloadCollection()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController.con
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.register(UINib(nibName: "trademarkCell", bundle: nil), forCellWithReuseIdentifier: "trademarkCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trademarks?.count ?? 0
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trademarkCell", for: indexPath) as! trademarkCell
//        print()
        let imgURL = trademarks?[indexPath.row].imgURL ?? ""
        cell.brandLogo.sd_setImage(with: URL(string: imgURL))
        cell.brandLogo.clipsToBounds = true
        cell.brandLogo.layer.borderColor = UIColor.systemGray3.cgColor
        cell.brandLogo.layer.borderWidth = 0.3
        cell.brandLogo.layer.cornerRadius =  20
        cell.offerTitle.text = trademarks?[indexPath.row].trademarkName
        cell.offerDetails.text = ""
        cell.offerDetails.text = ""
//        if let o = self.trademarks?[indexPath.row].offers {
//            self.offers = o
//            if self.offers.count != 0 {
//            cell.offerDetails.text = self.offers[0].offerTitle
//            }
//        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
        
        if (self.tradeDelegate != nil) {
            self.tradeDelegate.callSegueFromTradeCell(myData: trademarks![indexPath.row] )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let noOfCellsInRow = 3
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
//        let height = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

            return CGSize(width: width , height: 160)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
