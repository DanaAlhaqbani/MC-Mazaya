//
//  singleVoucher.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 25/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class usedVouchersView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Variables and constants
 
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    //MARK: - TableView Delegate and Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trademarkCell") as! TrademarkCell
        return cell
    }

}
