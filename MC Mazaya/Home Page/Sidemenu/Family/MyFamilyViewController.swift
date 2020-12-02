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
    @IBOutlet weak var FamilyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getFamilyMembersIDs()
        FamilyTableView.delegate = self
        FamilyTableView.dataSource = self
        // Making table view style look gooood
        FamilyTableView.separatorStyle = .none
        FamilyTableView.showsVerticalScrollIndicator = false
        
    }
    
}
extension MyFamilyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        familyMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FamilyTableView.dequeueReusableCell(withIdentifier: "cell") as! familyCell
        cell.numberLable.text = familyMembers[indexPath.row].name
        cell.familyView.layer.cornerRadius = cell.familyView.frame.height / 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let projectElement  = familyMembers[indexPath.row]
        //        deleteProjectElement(id: projectElement.key!, index: indexPath.row)
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
                    let snap = snapshot as! DataSnapshot
                    let member = FamilyMemebr(employeeID: snap.childSnapshot(forPath: "employeeID").value as? String, phone: snap.childSnapshot(forPath: "phoneNumber").value as? String, name: snap.childSnapshot(forPath: "name").value as? String, status: snap.childSnapshot(forPath: "status").value as? String, userID: snap.childSnapshot(forPath: "userID").value as? String)
                    self.familyMembers.append(member)
                
                self.FamilyTableView.reloadData()
            })
        }
    }
    
    
}
