//
//  bannerContaoner.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 28/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
 import Firebase
import FirebaseCrashlytics
import CHIPageControl

class bannerContainer: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    // Id: 'PageViewController'
    // MARK: @IBOutlet
    lazy var database = Database.database()
    lazy var bannersRef = self.database.reference(withPath: "Banners")
    var query: DatabaseReference!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: CHIPageControlChimayo!
    @IBOutlet weak var backgroundView: UIView!
    var banners = [Banner]()
    var bannerRef : DatabaseReference! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        bannerRef = Database.database().reference()
        collectionView.delegate = self
        collectionView.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        pageControl.semanticContentAttribute = .forceRightToLeft
        flowLayout.itemSize = CGSize(width: 325 , height: 145)
        collectionView.collectionViewLayout = flowLayout
        loadData()
    }
    

    func loadData(){
       query = bannersRef
        query.observeSingleEvent(of: .value, with: { snapshot in
            if let snaps = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snaps {
                    self.loadBanner(snap)
                }
            }
        })
    }
 
    func loadBanner(_ snapshot: DataSnapshot){
        self.banners = []
        let bennarId = snapshot.key
        bannersRef.child(bennarId).observeSingleEvent(of: .value, with: { bannerSnapshot in
            let banner = Banner(snapshot: snapshot)
            self.banners.append(banner)
            self.pageControl.numberOfPages = self.banners.count
//            self.setValues(index: self.currentIndex)
            self.backgroundView.layer.shadowColor = UIColor.systemGray4.cgColor
            self.backgroundView.layer.shadowRadius = 5
            self.backgroundView.layer.shadowOpacity = 0.5
            self.backgroundView.layer.shadowOffset = .zero
            self.backgroundView.layer.shadowPath = UIBezierPath(rect: self.backgroundView.bounds).cgPath
            self.backgroundView.layer.cornerRadius = 10
            self.backgroundView.layer.shouldRasterize = false
            self.backgroundView.clipsToBounds = false
            print(self.banners.count)
            self.collectionView.reloadData()
        })
    }
    
    //MARK: - Collectionview delegate and datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.banners.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell
        cell.imgView.image = UIImage(named: "\(banners[indexPath.section].imageURL)")
        cell.imgView.layer.cornerRadius = 15
        cell.imgView.clipsToBounds = true
//        cell.Title = self.banners[indexPath.section].imageURL

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.set(progress: indexPath.section, animated: true)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.parent?.performSegue(withIdentifier: "toSeasonalOffers", sender: self.banners[indexPath.section].title)
    }

    
}
