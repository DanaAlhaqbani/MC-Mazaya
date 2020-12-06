//
//  AddFamilyMemberViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 24/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//AddFamilyMemberViewController


import UIKit

class AddFamilyMemberViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //           self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        //           self.navigationController?.navigationBar.shadowImage = nil
        //           self.navigationController?.navigationBar.isTranslucent = false
    }
    
    //creating array contains images
    // var imagesArray = [#imageLiteral(resourceName: "parking"), #imageLiteral(resourceName: "circleRoad"), #imageLiteral(resourceName: "road bomp"),#imageLiteral(resourceName: "LockUp"),#imageLiteral(resourceName: "LockUp"),#imageLiteral(resourceName: "LockUp"),#imageLiteral(resourceName: "LockUp"),#imageLiteral(resourceName: "LockUp"),#imageLiteral(resourceName: "LockUp")] // change this later
    //creating array contains title
    var titleArray = [String]()
    //creating array contains score
   // var scoreArray = [String]()
    //creating array contains if section is open or closed
    //creating array contains sections
    var sections = [FamilyMemebr]()
    var pageTitle = ""
    // to decide which section is selected
    //var sectionIndicator: PSection?
    // to know the next section
    var nextSectionIndicator: FamilyMemebr?
    // to update total stars number
    var sectionsTotalScore = [String]()
    var levelsCount = 0
    @IBOutlet weak var sectionCollectionView: UICollectionView!
    @IBOutlet weak var Edit: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        let nib = UINib(nibName: "CustomCellS", bundle: nil)
        sectionCollectionView.register(nib, forCellWithReuseIdentifier: "CustomCellS")
        sectionCollectionView.dataSource = self
        sectionCollectionView.delegate = self
        sectionCollectionView.semanticContentAttribute = .forceRightToLeft
        // append sections names and scores to an arrays to put them into the cells
    }

    func setSections(sections: [FamilyMemebr]){
        self.sections = sections
    }
}

extension AddFamilyMemberViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellS", for: indexPath) as? CustomCellS else {
            fatalError("can't dequeue CustomCellS")
        }
        
        cell.label.text = titleArray[indexPath.row]
     
        
        //        if open[indexPath.row] {
        cell.isUserInteractionEnabled = false
        //        }
        //        else { // closed sections
        //        cell.sectionImage.image = UIImage(named: "lock")
        //        cell.backView.alpha = 0.4
        //        cell.isUserInteractionEnabled = false
        //        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        pageTitle = titleArray[indexPath.row]
        nextSectionIndicator = sections[indexPath.row+1]
        //        performSegue(withIdentifier: "Plevel", sender: self)
    }
    
    

    
    
    
    
}



