//
//  homeViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 02/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import SideMenu
class homeViewController: UIViewController {
    var menu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
       // self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    @IBAction func didTapMenu(){
        present(menu! , animated: true)
    }

    


}
class MenuListController: UITableViewController{
    let green = UIColor(rgb: 0x38a089)
    let white = UIColor(rgb: 0xFFFFFF)
    var items = ["المنطقة","عائلتي","المفضلة","جديد العروض","إقترح عرضاً","تواصل معنا",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = green
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = white
        cell.backgroundColor = green
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.tintColor = white

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
