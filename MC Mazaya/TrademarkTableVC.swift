//
//  TrademarkTableVC.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 21/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        // Make the table view looks good
        trademarksTableView.separatorStyle = .none
        trademarksTableView.showsVerticalScrollIndicator = false
    

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
        let trademarkName = trades[indexPath.row].Name
        let trademarkDes = trades[indexPath.row].description        
      //  let trademarkImage = trademarksImages[indexPath.row]
        cell.trademarkName.text = trademarkName
        cell.Des.text = trademarkDes
        //cell.trademarkImage.image = UIImage(named: trademarkImage ?? "")
        let url = URL(string: trades[indexPath.row].brandImage ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png" )
        if url != nil {
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Error: \(String(describing: error?.localizedDescription))")
                    return
                }
                DispatchQueue.main.async {
                    cell.trademarkImage.image = UIImage(data: data!)
                }
            }).resume()
        }        //make the cell looks good
        cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 3
        cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkView.layer.borderWidth = 1
        cell.trademarkView.layer.borderColor = UIColor.lightGray.cgColor
       // cell.trademarkView.backgroundColor = .lightGray
       // cell.trademarkImage.bringSubviewToFront(cell.trademarkView.tr)

        cell.trademarkImage.bringSubviewToFront(cell)

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         didSelectItemAction?(indexPath)
         if (self.delegate != nil) {
        self.delegate.callSegueFromCell(myData: trades[indexPath.row])
               }
    }
}
