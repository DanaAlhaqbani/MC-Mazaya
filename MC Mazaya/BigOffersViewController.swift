//
//  BigOffersViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 25/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//
import UIKit
import Firebase
class BigOffersViewController: UIViewController {
    var Categories = [Category]()
      var Trades = [Trademark]()
    var BigOffersTitles = [String]()
    var BigOffersNames = [String]()
    var ref: DatabaseReference?
    // for trademarks images
    var sectionsImages : [[String: Any]] = []
    
    @IBOutlet weak var trademarksTableView: UITableView!
    var trademarks = ["باتشي","جوديفا","ماكدونالدز","هرفي"] //[String]()
   var trademarksImages = ["patchi","patchi","patchi","patchi"] //[String]()

    override func viewDidLoad() {
        super.viewDidLoad()
       // retrieveTrades()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
         let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        cell.trademarkImage.sendSubviewToBack(cell.trademarkView)

    }
    
    func retrieveTrades(){

           // Retrieve all Sections with their content
           self.ref = Database.database().reference().child("Categories")
           self.ref?.observe(.value) { (snapshot) in
              // self.imagesGroup.enter()

               
               if snapshot.childrenCount > 0 {
                   self.Categories.removeAll()
                   
                   // get sections
                   for cate in snapshot.children.allObjects as![DataSnapshot] {
                       let category = cate.value as?[String: AnyObject]
                       let name = category?["Name"]
                       let key = cate.key
                    
                       let ref2 = Database.database().reference().child("Categories").child(key).child("TradeMarks")
                       ref2.observe(.value) { (snapshot) in
                       self.Trades.removeAll()


                       for trad in snapshot.children.allObjects as![DataSnapshot] {
                           let trademark = trad.value as?[String: AnyObject]
                           let name = trademark?["BrandName"] as! String
                           let offerTitle = trademark?["OffersTitle"] as! String
                           let levKey = trad.key
                           
                           if offerTitle == "صفقة" {
                               self.BigOffersNames.append(name)
                               self.BigOffersTitles.append(offerTitle)
                           }
                           }

                           

                       }
                   
                       } // end second observe
                   } // end for each sec
               } // end if has childeren
           } // end first observe
           



}

extension BigOffersViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trademarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        //let trademarkName = BigOffersNames[indexPath.row]
        //let trademarkImage = trademarksImages[indexPath.row]
        //cell.trademarkName.text = trademarkName
        //cell.trademarkImage.image = UIImage(named: trademarkImage)
        //make the cell looks good
        cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 3
        cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkView.layer.borderWidth = 1.5
        cell.trademarkView.layer.borderColor = UIColor.gray.cgColor
        cell.trademarkImage.bringSubviewToFront(cell.trademarkView)

        //cell.trademarkImage.bringSubviewToFront(cell.trademarkView)

        return cell
    }
   
        
        
    }
    



