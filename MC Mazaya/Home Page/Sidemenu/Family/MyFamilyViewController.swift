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
import MessageUI

class MyFamilyViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }
    
    
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
        numberOfMembers.text = "- / 6"
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
        if familyMembers[indexPath.row].status == "قيد الانتظار" {
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
            let editButton = UIContextualAction(style: .normal, title: "تعديل", handler: { (contextualAction, view, boolValue) in
    //            ref.child("Users/\(self.userID!)/FamilyMembers").child("\(self.familyMembers[indexPath.row].userID)").
                self.FMAAction(indexPath)
            })
            let swipeActions = UISwipeActionsConfiguration(actions: [deletButton, editButton])
            return swipeActions
        }
        return nil
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
    
    func FMAAction(_ index: IndexPath) {
        let alertController = UIAlertController(title: "إضافة عضو", message: "أدخل اسم ورقم العضو الذي ترغب بدعوته", preferredStyle: .alert)
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "إرسال الدعوة", style: .default) { (_) in
            //getting id
            //let id = task1.id
            //getting new values
            let  memberName = alertController.textFields?[0].text
            let memberPhone = alertController.textFields?[1].text
            //let assignedMember = alertController.textFields?[1].text
            //calling the update method to update artist
            self.editFamilyMember(memberName: memberName, memberPhone: memberPhone, indexPath: index)
        }
        
        let cancelAction = UIAlertAction(title: "الغاء", style: .cancel) { (_) in }
        //adding two textfields to alert
        alertController.addTextField { (textField) in
            textField.placeholder = "الاسم"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "رقم الجوال"
        }
        //adding action
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func editFamilyMember(memberName: String!, memberPhone: String! , indexPath: IndexPath){
        self.sendInvitation(memberName: memberName, memberPhone: memberPhone)
        if memberName != "" && memberPhone != ""{
            if isValidNumber(Family_Phone: memberPhone) == true {
//                let userRef = Database.database().reference().child("Users/\(userID!)/FamilyMembers")
                let alert = self.alertContent(title:  "تم التعديل!", message: "تم تعديل بيانات العضو" )
                self.present(alert, animated: true, completion: nil)
                let ref = Database.database().reference().child("FamilyMembers/\(self.familyMembers[indexPath.row].userID ?? "")")
                ref.child("name").setValue("\(memberName ?? "")")
                ref.child("phoneNumber").setValue("\(memberPhone ?? "")")
                print("Success Add family Member")
            }
            else {
                let alert = self.alertContent(title:  "رقم الهاتف غير صالح!", message: " من فضلِك، أدخل رقم الهاتف بشكل صحيح" )
                self.present(alert, animated: true, completion: nil)
            }
        }
        let alert = self.alertContent(title:  "بياناتك غير مكتملة!", message:"قم بتعبئة جميع الحقول")
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func isValidNumber(Family_Phone:String) -> Bool{
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: Family_Phone)
    }
    
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
    
    func sendInvitation(memberName: String, memberPhone: String){
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.recipients = [memberPhone]
        composeVC.body = "قم بتحميل تطبيق مزايا"
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
    
    
}
