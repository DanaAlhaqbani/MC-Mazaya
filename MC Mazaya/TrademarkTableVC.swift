//
//  TrademarkTableVC.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 21/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import SDWebImage

class TrademarkTableVC: UIViewController, CollectionCellDelegator {
    var delegate : CollectionCellDelegator!
    var didSelectItemAction: ((IndexPath) -> Void)?
    func selectedCategory(myData dataobject: [Trademark]) {
           self.performSegue(withIdentifier: "trademarks", sender: dataobject)
       }
       
       //MARK: -Protocols' functions

       func callSegueFromCell(myData dataobject: Trademark) {
           self.performSegue(withIdentifier: "toDetails", sender:dataobject )

       }
    @IBOutlet weak var trademarksTableView: UITableView!
    var trades = [Trademark]()//[String]()
    var url : String?
   var trademarksImages = ["patchi","patchi","patchi","patchi"] //[String]()
    var name = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
    print(name)
    }
    
}

extension TrademarkTableVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        let trademarkName = trades[indexPath.row].BrandName
        let trademarkDes = trades[indexPath.row].description        
      //  let trademarkImage = trademarksImages[indexPath.row]
        cell.trademarkName.text = trademarkName
        cell.Des.text = trademarkDes
        //cell.trademarkImage.image = UIImage(named: trademarkImage ?? "")
        let imageURL = trades[indexPath.row].brandImage
        cell.trademarkImage.sd_setImage(with: URL(string: imageURL ?? " https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png"))
         cell.trademarkView.layer.cornerRadius = cell.trademarkImage.frame.height / 2
             cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
             cell.trademarkImage.layer.borderWidth = 0.8
             cell.trademarkImage.layer.borderColor = UIColor.systemGray3.cgColor
             cell.trademarkView.backgroundColor = UIColor(rgb: 0xF4F4F4)
             cell.trademarkView.layer.shadowColor = UIColor.systemGray5.cgColor
             cell.trademarkView.layer.shadowRadius = 2
             cell.trademarkView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
             cell.trademarkView.layer.shadowOpacity = 0.5
             cell.trademarkView.clipsToBounds = false
             cell.trademarkImage.bringSubviewToFront(cell.trademarkView)
//        cell.trademarkImage.bringSubviewToFront(cell)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         didSelectItemAction?(indexPath)
         if (self.delegate != nil) {
        self.delegate.callSegueFromCell(myData: trades[indexPath.row])
               }
        let trade = trades[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: trade)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toDetails" {
               let dis = segue.destination as! DscriptionViewController
               dis.tradeInfo = sender as? Trademark
           } // Show Description Segue
    }
}
