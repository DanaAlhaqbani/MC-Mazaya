//
//  LastTableViewController.swift
//  MC Mazaya
//
//  Created by ALHANOUF  on 8/25/20.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit

class LastTableViewController: UITableViewController   {


    @IBOutlet weak var tbleList: UITableView!
    

//           @IBOutlet weak var tbleList: UITableView!



        var list = [[Dictionary<String, Any>]]()

           //MARK:- setDatSourceForCollectionView
           func setDatSourceForCollectionView() {
               for _ in 0...4 {
                   var cellArray = [Dictionary<String, Any>]()
                   for i in 0...8 {
                       var dict = Dictionary<String, Any>()
                       if i%2 == 0 {
                           dict.updateValue( UIColor.green, forKey: "color")
                       } else {
                           dict.updateValue( UIColor.blue, forKey: "color")
                       }
                       cellArray.append(dict)
                   }
                   list.append(cellArray)
               }
           }

           override func viewDidLoad() {
               super.viewDidLoad()
               // Do any additional setup after loading the view.
               setDatSourceForCollectionView()
               tbleList.tableFooterView = UIView(frame: .zero)
               tbleList.register(UINib(nibName: "CollectionviewTableCell", bundle: nil), forCellReuseIdentifier: "CollectionviewTableCell")
               tbleList.dataSource = self
               tbleList.delegate = self
            tbleList.isUserInteractionEnabled = true


           }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return list.count
           }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionviewTableCell") as! CollectionviewTableCell
               cell.infoArray = list[indexPath.row]
            //   cell.setUpDataSource()
            cell.isUserInteractionEnabled = true

               return cell
           }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 200.0
           }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DscriptionViewController") as? DscriptionViewController
            self.navigationController?.pushViewController(vc!, animated: true)
           // DscriptionViewController.isUserInteractionEnabled = true

        }

       }





