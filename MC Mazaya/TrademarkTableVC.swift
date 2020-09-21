//
//  TrademarkTableVC.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 21/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class TrademarkTableVC: UIViewController {
    @IBOutlet weak var trademarksTableView: UITableView!
    var trades = [Trademark]()//[String]()
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
      //  let trademarkImage = trademarksImages[indexPath.row]
        cell.trademarkName.text = trademarkName
        //cell.trademarkImage.image = UIImage(named: trademarkImage)
        //make the cell looks good
        cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 3
        cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkView.layer.borderWidth = 1
        cell.trademarkView.layer.borderColor = UIColor.gray.cgColor
       
       // cell.trademarkImage.bringSubviewToFront(cell.trademarkView.tr)

        cell.trademarkImage.bringSubviewToFront(cell)

        return cell
    }
    
}
