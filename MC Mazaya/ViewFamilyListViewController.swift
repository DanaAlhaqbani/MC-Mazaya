//
//  ViewFamilyListViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 29/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

class ViewFamilyListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
extension ViewFamilyListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UICollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 3
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: size, height: size)
    }
}
