//
//  searchResultTable.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 04/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

protocol reloadResultsTable {
    func reloadResultTable()
}

protocol ResultCellDelegator {
    func callSegueFromTradeCell(myData dataobject: Trademark)
}

class searchResultTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var didSelectItemAction: ((IndexPath) -> Void)?
    var tradeDelegate : ResultCellDelegator! = nil
    var delegate : reloadResultsTable! = nil
    var areThereResults : Bool?
    {
        didSet {
            tableView.reloadData()
            if let delegate = delegate {
                delegate.reloadResultTable()
            }
        }
    }
    var offers : [Offer]!
    var trademarks : [Trademark]?
    {
        didSet {
          tableView.reloadData()
            if let delegate = delegate {
                delegate.reloadResultTable()
//                areThereResults = true
            }
        }
    }
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trademarks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleResult") as! singleResultCell
            let imgURL = trademarks?[indexPath.row].imgURL
            cell.logoImage.sd_setImage(with: URL(string: imgURL ?? ""))
            cell.trademarkView.layer.cornerRadius = cell.trademarkView.frame.height / 2
            cell.logoImage.layer.cornerRadius = cell.logoImage.frame.height / 2
            cell.logoImage.layer.borderWidth = 0.8
            cell.logoImage.layer.borderColor = UIColor.systemGray3.cgColor
            cell.trademarkView.backgroundColor = UIColor(rgb: 0xF4F4F4)
            cell.trademarkView.layer.shadowColor = UIColor.systemGray5.cgColor
            cell.trademarkView.layer.shadowRadius = 2
            cell.trademarkView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            cell.trademarkView.layer.shadowOpacity = 0.5
            cell.trademarkView.clipsToBounds = false
            cell.logoImage.bringSubviewToFront(cell.trademarkView)
            cell.tradeName.text = trademarks?[indexPath.row].trademarkName
            cell.tradeDes.text = trademarks?[indexPath.row].description
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.masksToBounds = true
        backgroundView.layoutIfNeeded()
        backgroundView.needsUpdateConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        definesPresentationContext = true

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
//        if (self.tradeDelegate != nil) {
//            self.tradeDelegate.callSegueFromTradeCell(myData: trademarks![indexPath.row] )
        self.performSegue(withIdentifier: "toTrademark", sender: trademarks?[indexPath.row])
//    }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.tableView.isHidden = false
        if let lastIndexPath = tableView.indexPathsForVisibleRows?.last{
            if lastIndexPath.row <= indexPath.row{
                cell.center.y = cell.center.y + cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                    cell.center.y = cell.center.y - cell.frame.height / 2
                    cell.alpha = 1
                }, completion: nil)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                if let lastIndexPath = tableView.indexPathsForVisibleRows?.last{
            if lastIndexPath.row <= indexPath.row{
                cell.center.y = cell.center.y + cell.frame.height / 2
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseOut], animations: {
                    cell.center.y = cell.center.y - cell.frame.height / 2
                    cell.alpha = 1
                }, completion: nil)
//                if tableView.visibleCells.count == 0 {
//                    self.tableView.isHidden = true
//                }
            }
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? detailsViewController ,segue.identifier == "toTrademark" {
            let sender = sender as! Trademark
            vc.tradeInfo = sender
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
