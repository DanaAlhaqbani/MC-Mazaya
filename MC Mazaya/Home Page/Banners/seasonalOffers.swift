//
//  seasonalOffers.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 09/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class seasonalOffers: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    var offers = [Offer]()
    var seasonTitle = "عروض موسمية"
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = seasonTitle
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Table View Delegate and Data Sourse Protocols' Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "seasonalOffer") as! seasonalOfferTableViewCell
        
        return cell
    }
}
