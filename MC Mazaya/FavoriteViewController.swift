//
//  FavoriteViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 11/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase


class FavoriteViewController: UIViewController, MyCellDelegate {
    
    func btnTapped(cell: TrademarkCell) {
        let indexPath = self.trademarksTableView.indexPath(for: cell)
        self.favTrademarks.remove(at: indexPath!.row)
        self.trademarksTableView.reloadData()
    }
    
    @IBOutlet weak var trademarksTableView: UITableView!
    var Categories = [Category]()
    var favDict : NSDictionary = [:]
    var Trademarks = [Trademark]()
    var favTrademarks = [Trademark]()
    var ref = Database.database().reference()
    var uid = Auth.auth().currentUser?.uid
    var tradeName = String()
    @IBOutlet weak var starButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.trademarksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFavourite()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        trademarksTableView.separatorStyle = .none
        
    }
    
    func getFavourite(){
        for category in Categories {
            print("Hello in Categories ----------------------------------------")
            let trades = category.trademarks!
            for trade in trades {
                print("Hello in Trademarks ----------------------------------------")
                if trade.isFav == true {
                    print("Hello in Favourite Trademarks ----------------------------------------")
                    self.favTrademarks.append(trade)
                    self.trademarksTableView.reloadData()
                }
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DscriptionViewController, segue.identifier == "toTrademark" {
            vc.tradeInfo = sender as? Trademark
        }
    }
    
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favTrademarks.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trademarksTableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        let imageURL = favTrademarks[indexPath.row].brandImage ?? ""
//        cell.starButton.addTarget(indexPath.row, action: #selector(starPressed(_:)), for: .touchUpInside)
        cell.favDict = self.favDict
        cell.trademarkName.text = favTrademarks[indexPath.row].BrandName
        cell.trademarkImage.sd_setImage(with: URL(string: imageURL))
        cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 2
        cell.trademarkImage.layer.cornerRadius = cell.trademarkImage.frame.height / 2
        cell.trademarkView.layer.borderWidth = 1.5
        cell.trademarkImage.layer.borderWidth = 1.5
        cell.trademarkView.layer.borderColor = UIColor.gray.cgColor
        cell.trademarkImage.layer.borderColor = UIColor.gray.cgColor
        cell.trademarkImage.bringSubviewToFront(cell.trademarkView)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTrademark", sender: favTrademarks[indexPath.row])
    }

    
}
