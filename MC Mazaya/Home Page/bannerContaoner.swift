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

class bannerContainer: UIViewController, UIScrollViewDelegate { // Id: 'PageViewController'
    // MARK: @IBOutlet
    lazy var database = Database.database()
    lazy var ref = self.database.reference()
    lazy var bannersRef = self.database.reference(withPath: "Banners")
    var observers = [DatabaseQuery]()
    var query: DatabaseReference!
    var bannerSnapshots = [DataSnapshot]()
//    var banner
    /// Menu button item.
    @IBOutlet weak var backgroundView: UIView!
//    @IBOutlet weak var offers: UIImageView!
    var showFeed = false
    var loadingBannerCount = 0
    @IBOutlet weak var scrollView: UIScrollView!
    /// Pagination controller.
    @IBOutlet weak var pagination: UIPageControl!
    var currentIndex = 0
    var data: [Banner] = []
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
        backgroundView.layer.shadowColor = UIColor.systemGray6.cgColor
        backgroundView.layer.shadowRadius = 2.0
        backgroundView.layer.shadowOpacity = 0.8
        backgroundView.layer.shadowOffset = CGSize(width: 2, height: 2.0)
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.masksToBounds = false
        backgroundView.clipsToBounds = true
  
//        print(banners.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        loadBanners()
        loadData()
//        loadBanner(<#T##snapshot: DataSnapshot##DataSnapshot#>)
            let count = bannerIds?.keys.count
            pagination.numberOfPages = count ?? 5
//        print(banners.count)
//        print(banners)
//        }
//        )
        
       
    }
    
    

    func ConfigureScrollView(_ index: IndexPath){
        scrollView.contentSize = CGSize(width: backgroundView.frame.size.width, height: backgroundView.frame.size.height)
        scrollView.isPagingEnabled = true
        for page in pages {
            scrollView.addSubview(page)
            let imageURL = data[index.row].imageURL
        }
    }

//    func retrieveBanners() -> [Banner]{
//        self.banners = []
//        bannerRef.child("Banners").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let dict = snapshot.value as? [String : Any] {
//                for bannerKey in dict.keys {
//                    let bannerDict = dict[bannerKey] as! NSDictionary
//                    self.banners.append(Banner(title: bannerDict["Title"] as! String, imageURL: bannerDict["imageURL"] as! String, type: bannerDict["Type"] as! String))
//                    print(self.banners.count)
//                }
//            }
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//        return banners
//    }
    
    
    func loadBanners() {
        if observers.isEmpty && !banners.isEmpty {
            print("Hello There!")
//            self.removeSpinner()
//        }
            print("")
        for banner in banners {

            bannerRef.child(banner.bannerID).observeSingleEvent(of: .value, with: {
                if ($0.exists()) {
//                    self.updateBanners(banner, bannerSnapshot: $0)
//                    self.listenBanner(banner)
                } else {
                    if let index = self.banners.firstIndex(where: {$0.bannerID == banner.bannerID}) {
                        self.banners.remove(at: index)
//                        self.loadingBannersCount -= 1
                        Crashlytics.crashlytics().setCustomValue(self.banners.count, forKey: "updateDeletes")
                    }
                }
            })
        }
        } else {
            
            var query = self.query?.queryOrderedByKey()
            print(query)
            print(nextEntry)
            print("Hello, we are in 0")
            if let queryEnding = nextEntry {
                print("Hello, we are in 1")
                query = query?.queryEnding(atValue: queryEnding)
            }
            loadingBannerCount = banners.count
            query?.observeSingleEvent(of: .value, with: { snapshot in
                print("Hello, we are in 2")
                if let reversed = snapshot.children.allObjects as? [DataSnapshot], !reversed.isEmpty {
                    print("Hello, we are in 3")
                    self.nextEntry = reversed[0].key
                    var results = [Int: DataSnapshot]()
                    let myGroup = DispatchGroup()
                    let extraElement = reversed.count
                    DispatchQueue.main.async {
                        print("Hello, we are in 4")
                        for index in stride(from: reversed.count - 1, through: extraElement, by: -1) {
                            let item = reversed[index]
                            self.loadBanner(item)
                            print("Hello, we are in 5")
                        }
                        myGroup.notify(queue: .main) {
                            print("Hello, we are in 6")
                            print(self.banners)

                            for index in 0..<(reversed.count) {
                                if let snapshot = results[index] {
                                    if snapshot.exists(){
                                        self.loadBanner(snapshot)
                                    } else {
                                        print("Not exist")
                                    }
                                }
                            }
                        }
                    }
                } else if self.banners.isEmpty {
                    print("Empty")
                }
            })
        }
    }
//
//    func updateBanners(_ banner: Banner, bannerSnapshot: DataSnapshot) {
//        let bannerId = bannerSnapshot.key
//        bannerRef.child(bannerId).observeSingleEvent(of: .value, with: { snapshot in
//            let enumerator = snapshot.children
//            while let bannersSnapshot = enumerator.nextObject() as? DataSnapshot {
//                let b = Banner(snapshot: bannersSnapshot)
//                self.banners.append(b)
//            }
//        })
//    }
//
//    func listenBanner(_ banner: Banner) {
////        let bannerQuer
//    }
//
//    func loadBanner(_ bannerSnapshot: DataSnapshot){
//        let bannerId = bannerSnapshot.key
//        self.bannerRef.child(bannerId).observeSingleEvent(of: .value, with: { snapshot in
//            let banner = Banner(snapshot: bannerSnapshot)
//            self.banners.append(banner)
//            let last = self.banners.count - 1
//            let lastIndex = [IndexPath(item: last, section: 0)]
////            self.listenBanner(banner)
//        })
//    }
//
//
//    func listenDeletes(){
//        bannerRef.observe(.childRemoved, with: { bannerSnapshot in
//            if let index = self.banners.firstIndex(where: {$0.bannerID == bannerSnapshot.key}) {
//                self.banners.remove(at: index)
//                self.loadingBannerCount -= 1
//                Crashlytics.crashlytics().setCustomValue(self.banners.count, forKey: "listenDeletes")
//
//            }
//        })
//    }
//
    func loadData(){
       query = bannersRef
        loadBanners()
//        listenDeletes()

    }
    
//    func loadBanner() {
////        if status {
//      database.reference(withPath: "Banners").observeSingleEvent(of: .value, with: {
//        if var posts = $0.value as? [String: Any] {
//          if !self.bannerSnapshots.isEmpty {
//            var index = self.bannerSnapshots.count - 1
////            self.performBatchUpdates({
//            DispatchQueue.main.async {
//                for post in self.bannerSnapshots.reversed() {
//                    if posts.removeValue(forKey: post.key) == nil {
//                        self.bannerSnapshots.remove(at: index)
////                 self.collectionView?.deleteItems(at: [IndexPath(item: index, section: 1)])
//                        return
//                    }
//                index -= 1
//                }
//            }
////            }, completion: nil)
//            self.bannerIds = posts
//            self.loadingBannerCount = posts.count
//          } else {
//            self.bannerIds = posts
//            self.loadFeed()
//          }
////          self.registerForPostsDeletion()
//        }
//      })
//
//    }
    
//    func loadFeed() {
//      loadingBannerCount = bannerSnapshots.count + 5
////      self.collectionView?.performBatchUpdates({
//        DispatchQueue.main.async {
//            for _ in 1...5 {
//                if let bannerId = self.bannerIds?.popFirst()?.key {
//                    self.database.reference(withPath: "Banners/\(bannerId)").observeSingleEvent(of: .value, with: { bannerSnapshot in
//                        self.bannerSnapshots.append(bannerSnapshot)
////             self.collectionView?.insertItems(at: [IndexPath(item: self.postSnapshots.count - 1, section: 1)])
//                    })
//                } else {
//                    break
//                }
//            }
//        }
////      }, completion: nil)
//    }
    
//    func registerForPostsDeletion() {
//      let userPostsRef = database.reference(withPath: "people/\(profile.uid)/posts")
//      userPostsRef.observe(.childRemoved, with: { postSnapshot in
//        var index = 0
//        for post in self.postSnapshots {
//          if post.key == postSnapshot.key {
//            self.postSnapshots.remove(at: index)
//            self.loadingPostCount -= 1
//            self.collectionView?.deleteItems(at: [IndexPath(item: index, section: 1)])
//            return
//          }
//          index += 1
//        }
//        self.postIds?.removeValue(forKey: postSnapshot.key)
//      })
//    }
    
//    func registerForBannersCount() {
////      let userPostsRef = database.reference(withPath: "people/\(profile.uid)/posts")
//      bannersRef.observe(.value, with: {
//        self.headerView.postsLabel.text = "\($0.childrenCount) post\($0.childrenCount != 1 ? "s" : "")"
//      })
//    }
    
    
    func loadBanner(_ snapshot: DataSnapshot){
        let bennarId = snapshot.key
        bannersRef.child(bennarId).observeSingleEvent(of: .value, with: { bannerSnapshot in
            let banner = Banner(snapshot: snapshot)
            self.banners.append(banner)
        })
    }
}
