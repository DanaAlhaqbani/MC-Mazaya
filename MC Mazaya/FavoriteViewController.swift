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
    @IBOutlet weak var starButton: UIButton!
    var Categories = [Category]()
    var favDict : NSDictionary = [:]
    var Trademarks = [Trademark]()
    var favTrademarks = [Trademark]()
    var ref = Database.database().reference()
    var uid = Auth.auth().currentUser?.uid
    var tradeName = String()
    var emptyView = UIView()
    let labelTitle : UILabel = {
        $0.text = "المفضلة فارغة"
        $0.font = UIFont(name: "STC", size: 20)
        $0.textColor = UIColor(rgb: 0x5AC5BE)
        return $0
    }(UILabel())
    let emptyImg : UIImageView = {
        $0.image = UIImage(named: "emptyFav")
        return $0
    }(UIImageView())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        self.trademarksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getFavourizte()
        trademarksTableView.delegate = self
        trademarksTableView.dataSource = self
        trademarksTableView.separatorStyle = .none
        setupEmptyView()
//        getFavourites()
        if favTrademarks.count == 0 {
            self.view.addSubview(self.emptyView)
        }
    }
    


    func setupEmptyView(){
        emptyView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        emptyView.addSubview(labelTitle)
        emptyView.addSubview(emptyImg)
        emptyImg.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emptyImg.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        labelTitle.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emptyImg.anchor(width: 150, height: 150)
        labelTitle.anchor(top: emptyImg.bottomAnchor, paddingTop: 20)
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
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toTrademark", sender: favTrademarks[indexPath.row])
    }

    func getFavourites(){
//        self.favTrademarks = []
        ref.child("Users/\(uid!)/FavoriteTradeMarks").observeSingleEvent(of: .value, with: { snapshot in
            let dictionary = snapshot.value as! NSDictionary
            var keys =  [String: Any]()
            for i in dictionary {
                keys["Name"] = i.value as! String
//                self.favTrademarks = Trademarks
            }
        })
    }

    
}
