//
//  MenuListController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 14/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import Foundation
import UIKit
import DropDown

protocol MenuListControllerDelegate {
    func didSelectMenuItem (name: String)
}
class MenuListController: UITableViewController{

    public var delegate: MenuListControllerDelegate?

    let green = UIColor(rgb: 0x38a089)
    let white = UIColor(rgb: 0xFFFFFF)
    var items = ["المنطقة","عائلتي","المفضلة","جديد العروض","الصفقات المستخدمة","إقترح عرضاً","القسائم الشرائية","تواصل معنا","تسجيل الخروج"]
    private let MeniItems: [String]
    init(MeniItems: [String]) {
        self.MeniItems = MeniItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.textLabel?.textAlignment = .center
        //cell.textLabel?.tintColor = white


        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = MeniItems[indexPath.row]

        delegate?.didSelectMenuItem(name: selectedItem)
    }

}
