//
//  MyFamilyViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 03/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
import Firebase
import FirebaseDatabase
import FirebaseAuth


class MyFamilyViewController: UIViewController {
    
    let userID = Auth.auth().currentUser?.uid
    var familyMembersIDs = [String]()
    var familyMembers = [FamilyMemebr]()
    var shadowImage : UIImage?
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var FamilyTableView: UITableView!
    @IBOutlet weak var numberOfMembers: UILabel!
    var memberCount : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.masksToBounds = true
        getFamilyMembersIDs()
        FamilyTableView.delegate = self
        FamilyTableView.dataSource = self
        // Making table view style look gooood
        FamilyTableView.separatorStyle = .none
        FamilyTableView.showsVerticalScrollIndicator = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isTranslucent = true
    }
}


extension MyFamilyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        familyMembers.count
    }
    
    //    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    //        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
    //            print("more button tapped")
    //        }
    //        more.backgroundColor = .lightGray
    //
    //        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
    //            print("favorite button tapped")
    //        }
    //        favorite.backgroundColor = .orange
    //
    //        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
    //            print("share button tapped")
    //        }
    //        share.backgroundColor = .blue
    //
    //        return [share, favorite, more]
    //    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletButton = UIContextualAction(style: .destructive, title: "حذف") {  (contextualAction, view, boolValue) in
            //Code I want to do here
            let ref = Database.database().reference()
            ref.child("Users/\(self.userID!)/FamilyMembers").child("\(self.familyMembers[indexPath.row].userID!)").removeValue()
            ref.child("FamilyMembers/\(self.familyMembers[indexPath.row].userID!)").removeValue()
            print("Delete Button Pressed")
            self.memberCount! -= 1
            self.numberOfMembers.text = "\(self.memberCount!) / 6"
            self.familyMembers.remove(at: indexPath.row)
            self.FamilyTableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deletButton])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FamilyTableView.dequeueReusableCell(withIdentifier: "cell") as! familyCell
        cell.nameLabel.text = familyMembers[indexPath.row].name
        cell.numberLable.text = familyMembers[indexPath.row].phone
        cell.statusLabel.text = familyMembers[indexPath.row].status
        if cell.statusLabel.text == "نشط" {
            cell.statusLabel.textColor = UIColor(rgb: 0x009BDA)
        } else if cell.statusLabel.text == "قيد الانتظار" {
            cell.statusLabel.textColor = UIColor(rgb: 0xFFB300)
        }
        cell.familyView.layer.cornerRadius = 20
        cell.familyView.backgroundColor = UIColor(rgb: 0xF4F4F4)
        cell.familyView.layer.shadowColor = UIColor.systemGray5.cgColor
        cell.familyView.layer.shadowRadius = 2
        cell.familyView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseOut], animations: {
            cell.center.y = cell.center.y - cell.frame.height / 2
            cell.alpha = 1
        }, completion: nil)
    }
    
    
    
    func deleteProjectElement(id:String, index:Int){
        let delref = Database.database().reference().child("Users").child(userID!).child("FamilyList").child(id)
        delref.setValue(nil)
        self.FamilyTableView.reloadData()
        let alertController = UIAlertController(title: "تم الحذف!", message: "تم حذف فرد العائلة بنجاح", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "حسنا", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getFamilyMembersIDs(){
        let ref = Database.database().reference().child("Users/\(userID!)/FamilyMembers")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                self.familyMembersIDs.append(key)
            }
            self.getFamilyMembers()
        })
    }
    
    func getFamilyMembers(){
        let memberRef = Database.database().reference().child("FamilyMembers")
        for key in familyMembersIDs {
            memberRef.child(key).observeSingleEvent(of: .value, with:  { snapshot in
                let snap = snapshot 
                let member = FamilyMemebr(employeeID: snap.childSnapshot(forPath: "employeeID").value as? String, phone: snap.childSnapshot(forPath: "phoneNumber").value as? String, name: snap.childSnapshot(forPath: "name").value as? String, status: snap.childSnapshot(forPath: "status").value as? String, userID: snap.childSnapshot(forPath: "userID").value as? String)
                self.familyMembers.append(member)
                self.memberCount = self.familyMembers.count   
                self.numberOfMembers.text = "\(self.memberCount!) / 6"
                self.FamilyTableView.reloadData()
            })
        }
    }
    
    
    
    
}
