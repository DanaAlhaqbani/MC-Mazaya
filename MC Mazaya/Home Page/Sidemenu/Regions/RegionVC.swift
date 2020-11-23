//
//  RegionVC.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 01/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseStorage

protocol sendSelectedRegionDelegate {
    func selectedRegion(myData dataObject: String)
}

class RegionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Constants
    let regionNames = [ "الكل", "الرياض","مكة","القصيم","المنطقة الشرقية","الحدود الشمالية","تبوك","الجوف","المدينة المنورة","نجران","جازان","الباحة","عسير","حائل"]
    let imageNames = ["AllRegions", "Riyadh", "Makkah", "Alqassim", "Eastern", "North", "Tabouk", "Aljouf", "Almadinah", "Najran", "Jazan", "Albaha", "Aseer", "Hail"]
    @IBOutlet weak var containerView: UIView!
    var selectedRegion : String?
    var categories = [Category]()
    var trademarks = [Trademark]()
    var passedTrademarks = [Trademark]()
    var delegate : sendSelectedRegionDelegate!
    var dismissHandler: (() -> Void)!

    //MARK: -TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell") as! RegionTableViewCell
        cell.regionName.text = regionNames[indexPath.row]
        cell.backgroundColor = UIColor(rgb: 0x7CC3BA)
        cell.regionImage.image = UIImage(named: "\(imageNames[indexPath.row])")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRegion = self.regionNames[indexPath.row]
        self.dismissHandler()
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
//        if self.view.touch
        tabBarController?.tabBar.isUserInteractionEnabled = false
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    
    func filteredByRegion(){
//        for category in categories {
//            let trades = category.trademarks!
//            for trade in trades {
////                self.trademarks.append(trade)
//            }
//        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
