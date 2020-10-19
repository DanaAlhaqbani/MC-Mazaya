//
//  RegionVC.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 01/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseStorage


class RegionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Constants
    let storageRef = Storage.storage().reference(withPath: "images")
//    let imageNames = ["Riyadh", "Alqassim", "Tabouk", "Makkah", "Eastern", "North", "Hail", "Aseer", "Albaha", "Jazan", "Najran", "Aljouf", "Almadinah"]
    
    //MARK: -TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 13
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "regionCell") as! RegionTableViewCell
//        cell.regionName.text = imageNames[indexPath.row]
//        cell.imageView?.image = UIImage(named: "\(imageNames[indexPath.row])")
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
