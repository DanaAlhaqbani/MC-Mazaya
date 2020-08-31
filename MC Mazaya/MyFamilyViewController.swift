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
    var projectsList = [FamilyMemebr]()
        var projectsKeys = [String]()
        var projectsRef: DatabaseReference!
        let userID = Auth.auth().currentUser?.uid
        
    @IBOutlet weak var FamilyTableView: UITableView!
    var numbers = ["0531242380","0561242389","0567821637"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //Retrive phones from database
            // Do any additional setup after loading the view.
           projectsRef = Database.database().reference().child("Users").child(userID!).child("FamilyList");
            projectsRef.observe(DataEventType.value, with: { (snapshot) in
                //if the reference have some values
                if snapshot.childrenCount > 0 {
                    //clearing the list
                    self.projectsList.removeAll()
                    
                    //iterating through all the values
                    for projects in snapshot.children.allObjects as! [DataSnapshot] {
                        //getting values
                        let projectObject = projects.value as? [String: AnyObject]
                        let phone = projectObject?["Name"] as? String
                        let status = projectObject?["Status"] as? String
                        let projectId = projects.key
                        
                        self.projectsKeys.append(projectId)
                        
                        //creating artist object with model and fetched values
                        let member = FamilyMemebr(Phone: phone, Status: status, key: projectId)
                        self.projectsList.append(member)
                    }
                    
                    //reloading the tableview
                    self.FamilyTableView.reloadData()
                }
            })
     
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
        projectsList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FamilyTableView.dequeueReusableCell(withIdentifier: "cell") as! familyCell
        let member: FamilyMemebr
        member = projectsList[indexPath.row]
        cell.numberLable.text = member.Phone
        cell.familyView.layer.cornerRadius = cell.familyView.frame.height / 2
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let projectElement  = projectsList[indexPath.row]
        deleteProjectElement(id: projectElement.key!, index: indexPath.row)
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
}
