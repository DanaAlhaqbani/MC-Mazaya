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

class bannerContainer: UIViewController { // Id: 'PageViewController'
    // MARK: @IBOutlet
    lazy var database = Database.database()
    lazy var ref = self.database.reference()
    lazy var bannersRef = self.database.reference(withPath: "Banners")
    var observers = [DatabaseQuery]()
    var query: DatabaseReference!
    var bannerSnapshots = [DataSnapshot]()
//    var banner
    /// Menu button item.
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
//    @IBOutlet weak var offers: UIImageView!
    var showFeed = false
    var loadingBannerCount = 0
//    @IBOutlet weak var scrollView: UIScrollView!
    /// Pagination controller.
    @IBOutlet weak var pagination: UIPageControl!
    var currentIndex = 0
//    var data: [Banner] = []
    var pages = [UIImageView]()
    var banners = [Banner]()
    var bannerRef : DatabaseReference! = nil
    var nextEntry : String?
    var bannerIds: [String: Any]?
//    var loadingBannerCount = 0

    override func viewDidLoad() {
        bannerRef = Database.database().reference()
//        retrieveBanners()
//        setValues(currentIndex)
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        pagination.numberOfPages = 0
        backgroundView.layer.shadowColor = UIColor.systemGray4.cgColor
        backgroundView.layer.shadowRadius = 5
        backgroundView.layer.shadowOpacity = 0.5
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowPath = UIBezierPath(rect: backgroundView.bounds).cgPath
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shouldRasterize = false

//        img.layer.masksToBounds = false
        backgroundView.clipsToBounds = false
        // Setup slide handler
        let leftSwipe = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.backgroundView.addGestureRecognizer(leftSwipe)
        self.backgroundView.addGestureRecognizer(rightSwipe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadData()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        bannersRef.removeAllObservers()
        query.removeAllObservers()
        banners = []
    }


    private func setValues(index: Int) {
        self.pagination.currentPage = currentIndex
        self.title = banners[index].title
        let imageURL = banners[index].imageURL
        //Uncomment next line After adding the banner from admin
//        self.img.sd_setImage(with: URL(string: imageURL))
        //Comment next lines after adding the banner from admin
        self.img.image = UIImage(named: "\(banners[index].imageURL)")
        self.img.contentMode = .scaleAspectFit
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
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        let size = self.banners.count
        let currentPosition = self.pagination.currentPage
        if sender.direction == .left && currentPosition < size-1 {
            nextPage()
        } else if sender.direction == .right && currentPosition > 0 {
            previousPage()
            
        }
    }
    
    // Button or see UIPageControl @IBOutlet
    private func nextPage() {
        currentIndex = abs((currentIndex + 1) % banners.count)
        print("next Index", banners[currentIndex])
        setValues(index: currentIndex)
    }

    // Button or see UIPageControl @IBOutlet
    private func previousPage() {
        currentIndex = abs((currentIndex - 1) % banners.count)
        print("next Index", banners[currentIndex])
        setValues(index: currentIndex)
    }
    
    
    func loadBanner(_ snapshot: DataSnapshot){
        let bennarId = snapshot.key
        bannersRef.child(bennarId).observeSingleEvent(of: .value, with: { bannerSnapshot in
            let banner = Banner(snapshot: snapshot)
            self.banners.append(banner)
            self.pagination.numberOfPages = self.banners.count
            self.setValues(index: self.currentIndex)

        })
    }
}
