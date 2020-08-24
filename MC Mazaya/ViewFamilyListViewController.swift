//
//  ViewFamilyListViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 29/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase


class ViewFamilyListViewController: UIViewController, familyPassData {
    
      func passDataBack(numbers: [String]) {
            userData.family = numbers
        print("")
        print(numbers)
        }


    var projectsRef: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    let green = UIColor(rgb: 0x38a089)
    var count = 0
    //creating array contains title
    var phones = [String]()

    @IBOutlet weak var collectionView: FamilyCollectionViewCell!
    
    @IBOutlet weak var phone: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("========is Empty?????==========")
       print(phones)
    }


}
extension ViewFamilyListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phones.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FamilyCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 3
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.borderColor = UIColor.gray.cgColor
        let number = phones[indexPath.row]
        cell.phone.text = number
        cell.contentView.backgroundColor = green
        return cell
    }
  

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: size, height: size)
    }
}

