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

class bannerContainer: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate { // Id: 'PageViewController'
    // MARK: @IBOutlet
    lazy var database = Database.database()
    lazy var ref = self.database.reference()
    lazy var bannersRef = self.database.reference(withPath: "Banners")
    var observers = [DatabaseQuery]()
    var query: DatabaseReference!
    var bannerSnapshots = [DataSnapshot]()
    var frame = CGRect.zero
    typealias ResultBlock = (Bool) -> Void?
//    var banner
    /// Menu button item.
    @IBOutlet weak var scrollView: UIScrollView!
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
        scrollView.delegate = self
//        img.layer.masksToBounds = false
        backgroundView.clipsToBounds = false

        // Setup slide handler
        let leftSwipe = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.scrollView.addGestureRecognizer(leftSwipe)
        self.scrollView.addGestureRecognizer(rightSwipe)
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
        frame.origin.x = scrollView.frame.size.width * CGFloat(index)
        frame.size = scrollView.frame.size
        self.pagination.currentPage = currentIndex
        self.title = banners[index].title
        let imageURL = banners[index].imageURL
        //Uncomment next line After adding the banner from admin
//        self.img.sd_setImage(with: URL(string: imageURL))
        //Comment next lines after adding the banner from admin
        self.img.image = UIImage(named: "\(banners[index].imageURL)")
        self.img.contentMode = .scaleAspectFit
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(banners.count)), height: scrollView.frame.size.height)
        scrollView.addSubview(img)
        print(imageURL)
//        scrollView.delegate = self

//        scrollView.panGestureRecognizer.require(toFail: rightSwipe)
    }
    

    func loadData(){
       query = bannersRef
        query.observeSingleEvent(of: .value, with: { snapshot in
            if let snaps = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snaps {
                    self.loadBanner(snap, { enabled in
//                        self.setValues(index: self.currentIndex)
                        self.scrollView.delegate = self
                        })

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
    
    
    func loadBanner(_ snapshot: DataSnapshot, _ resultBlock: ResultBlock?){
        let bennarId = snapshot.key
        var result = false
        bannersRef.child(bennarId).observeSingleEvent(of: .value, with: { bannerSnapshot in
            let banner = Banner(snapshot: snapshot)
            self.banners.append(banner)
            self.pagination.numberOfPages = self.banners.count
            result = true
            resultBlock?(result)
        })
        
        
    }
    
    
//    func setupScreens() {
//        for index in 0..<banners.count {
//            // 1.
//            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
//            frame.size = scrollView.frame.size
//
//            // 2.
//            let imgView = UIImageView(frame: frame)
//            imgView.image = UIImage(named: movies[index])
//
//            self.scrollView.addSubview(imgView)
//        }
//
//        // 3.
//        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(movies.count)), height: scrollView.frame.size.height)
//        scrollView.delegate = self
//    }
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pagination.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//        if scrollView.
        pagination.currentPage = Int(pageNumber)
        
    }
    
    
}
