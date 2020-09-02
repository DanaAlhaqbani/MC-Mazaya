//
//  AdminTrademarksViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 06/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import Firebase
class AdminTrademarksViewController: UIViewController {
/*
      
        var TEstValue = ""
        var pageTitle = ""
        var section: Category?
        var key = ""
        var sectionNumber = 0
    
        var levels = [Trademark]()
        
        var levelsCount = 0
        
        var titleArray = [String]()
        var scoreArray = [Int]()
        var levelsScoreSum = 0
        var ref: DatabaseReference?
        //    var ins: AdminEditGameVC?
        
        
        var currentlevel: Trademark?

        var isSelectDelete = false
        var isSelectEdit = false
        
        var sectionsImages : [[String: Any]] = []
        
        var levelsWithImages : [[String: Any]] = []
        var questionsImages = [[String: Any]]()
        
        var sectionsWithImages : [[String: Any]] = []
        
        //    @IBOutlet weak var levelCollectionView: UICollectionView!
        
        @IBOutlet weak var levelCollectionView: UICollectionView!
        
        @IBOutlet weak var addLevelBtn: UIButton!
        
        @IBOutlet weak var DeleteLevelBtn: UIButton!
        @IBOutlet weak var EditLevelBtn: UIButton!
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
        }
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
    //        let topColor = UIColor.lightPink
    //        let bottomColor =  UIColor.fadedBlue
    //        self.navigationController?.navigationBar.setGradientBackground(colors: [bottomColor, topColor], startPoint: .bottom, endPoint: .top)
            
            let nib = UINib(nibName: "CustomCell", bundle: nil)
            levelCollectionView.register(nib, forCellWithReuseIdentifier: "CustomCell")
            levelCollectionView.dataSource = self
            levelCollectionView.delegate = self
            levelCollectionView.semanticContentAttribute = .forceRightToLeft
            title = section?.Name
            key = section!.key

        }
        
        @IBAction func addLevel(_ sender: Any) {
            if isSelectDelete == false &&  isSelectEdit == false {
                performSegue(withIdentifier: "addSingleLevel", sender: nil)
            }
            else if isSelectDelete == true  { // delete is selected
                let alertDelete = UIAlertController(title: "!عذراً", message: "يجب عليك انهاء عملية الحذف أولاً" , preferredStyle: .alert)
                alertDelete.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                self.present(alertDelete, animated: true)
            }
            else { // edit is selected
                let alert = UIAlertController(title: "!عذراً", message: "يجب عليك انهاء عملية التعديل أولاً" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        
        @IBAction func editPressed(_ sender: Any) {
            
            // to check if delete is selected first
            if isSelectDelete == false {
                
                if isSelectEdit == false {
                    let alert = UIAlertController(title: "تعديل مرحلة", message:      "بإمكانك الآن اختيار المرحلة التي ترغب بتعديلها بمجرد الضغط عليها" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    isSelectEdit = true
                    EditLevelBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                    
                } else if isSelectEdit == true {
                    isSelectEdit = false
                    EditLevelBtn.setImage(#imageLiteral(resourceName: "editingButton"), for: .normal)
                }
                
                // else if delete is selected
            } else {
                let alert = UIAlertController(title: "!عذراً", message: "يجب عليك انهاء عملية الحذف أولاً" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
    }
        
        
        
        
        
        @IBAction func deleteAction(_ sender: Any) {
            
            // to check if edit is selected first
            if isSelectEdit == false {
                
                // if section have only one level you  cannot delete
                if titleArray.count ==  1 {
                    let alertCannotDelete = UIAlertController(title: "حذف مرحلة", message: "نأسف لك، لا يمكنك الحذف إن لم يكن هنالك سوى مرحلة واحدة.", preferredStyle: .alert)
                    alertCannotDelete.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                    self.present(alertCannotDelete, animated: true)
                    
                    return // to return and not changing anything
                }
                
                if isSelectDelete == false {
                    isSelectDelete = true
                    
                    DeleteLevelBtn.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                    
                    let alertDelete = UIAlertController(title: "حذف مرحلة", message: "بإمكانك الآن اختيار المرحلة التي ترغب بحذفها بمجرد الضغط عليها", preferredStyle: .alert)
                    alertDelete.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                    self.present(alertDelete, animated: true)
                    
                } else if isSelectDelete == true {
                    isSelectDelete = false
                    DeleteLevelBtn.setImage(#imageLiteral(resourceName: "cancelingButton"), for: .normal)
                    
                }
                
                // else if edit is selected
            } else {
                let alert = UIAlertController(title: "!عذراً", message: "يجب عليك انهاء عملية التعديل أولاً" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        
        func setSection(section: Category){
            self.section = section
        }
        
        
    }

    extension AdminTrademarksViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return titleArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
                fatalError("can't dequeue CustomCell")
            }
            cell.label.text = titleArray[indexPath.row]
            if scoreArray[indexPath.row] <= 1 {
                cell.star1.image = UIImage(named: "star")!
                cell.star2.image = UIImage(named: "star")!
                cell.star3.image = UIImage(named: "star")!
            }
            if scoreArray[indexPath.row] == 2 || scoreArray[indexPath.row] == 3 {
                cell.star1.image = UIImage(named: "starfilled")!
                cell.star2.image = UIImage(named: "star")!
                cell.star3.image = UIImage(named: "star")!
            }
            if scoreArray[indexPath.row] == 4 || scoreArray[indexPath.row] == 5 {
                cell.star1.image = UIImage(named: "starfilled")!
                cell.star2.image = UIImage(named: "starfilled")!
                cell.star3.image = UIImage(named: "star")!
            }
            if scoreArray[indexPath.row] == 6 {
                cell.star1.image = UIImage(named: "starfilled")!
                cell.star2.image = UIImage(named: "starfilled")!
                cell.star3.image = UIImage(named: "starfilled")!
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if isSelectDelete == true {
                //check if section has only one level YOU CANNOT DELETE SORRY
                if titleArray.count > 1{
                    //if user selected the delete option show alert
                    
                    let alertDelete = UIAlertController(title: "حذف مرحلة", message: "هل أنت متأكد من حذف هذه المرحلة؟", preferredStyle: .alert)
                    
                    alertDelete.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                        
                        //section key
                        if let sectionKeyforLevel = self.section?.levels[indexPath.row].sectionKey {
                            //level key
                            if let levelKey = self.section?.levels[indexPath.row].levelKey{
                                //path
                                let levelToBeDeleted = Database.database().reference().child("TSections").child(sectionKeyforLevel).child("Levels").child(levelKey)
                                print(levelToBeDeleted)
                                //delete from database
                                levelToBeDeleted.removeValue()
                                
                                //remove from users tsections
                                let levelToBeDeletedUsers = Database.database().reference().child("Users")
                                levelToBeDeletedUsers.observe(.value) { (snapshot) in
                                    
                                    if snapshot.childrenCount > 0 {
                                        
                                        for User in snapshot.children.allObjects as![DataSnapshot] {
                                            let keyUser = User.key
                                            Database.database().reference().child("Users").child(keyUser).child("TSections").child(sectionKeyforLevel).child("Levels").child(levelKey).removeValue()
                                            
                                        } // end for each user
                                        
                                        
                                    } // end if children
                                } // end observe
                            }
                        }
                        
                        //storage
                        if let sectionKeyforLevel = self.section?.levels[indexPath.row].sectionKey {
                            if let levelKey = self.section?.levels[indexPath.row].levelKey{
                                
                                for ( questionIndex, question) in (self.section?.levels[indexPath.row].questions.enumerated())!{
                                    let questionNumberToBeDeleted = questionIndex + 1
                                    let storageRef = Storage.storage().reference().child("TSectionImages/").child(sectionKeyforLevel+"/").child((levelKey)+"/").child(String(questionNumberToBeDeleted))
                                    
                                    storageRef.delete{ (error) in
                                        
                                        print("error: \(String(describing: error))")
                                        
                                        print("-----QUESTION IN LEVEL-------")
                                        
                                    }
                                    print(storageRef)
                                    print("CAAAN UUU SEEE IT !!!")
                                }
                            }
                        }
                        
                        
                        
                        
                        //delete from arrays
                        self.titleArray.remove(at: indexPath.row)
                        self.questions.remove(at: indexPath.row)
                        self.section?.levels.remove(at: indexPath.row)
                        //delete from collectionview
                        collectionView.deleteItems(at: [indexPath])
                        print("Deleted")
                        //check if there is only one level changing the button status to cannot delete
                        if self.titleArray.count ==  1 {
                            self.isSelectDelete = false
                            self.DeleteLevelBtn.setImage(#imageLiteral(resourceName: "cancelingButton"), for: .normal)
                            
                        }
                    }))
                    
                    alertDelete.addAction(UIAlertAction(title: "لا", style: .cancel, handler: nil))
                    self.present(alertDelete, animated: true)
                    
                } else if titleArray.count ==  1 {
                    
                    //cannot delete level
                    let alertCannotDelete = UIAlertController(title: "حذف مرحلة", message: "نأسف لك، لا يمكنك الحذف إن لم يكن هنالك سوى مرحلة واحدة.", preferredStyle: .alert)
                    alertCannotDelete.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                    self.present(alertCannotDelete, animated: true)
                    //  // return back to the defaultt
                    
                    isSelectDelete = false
                    DeleteLevelBtn.setImage(#imageLiteral(resourceName: "cancelingButton"), for: .normal)
                    
                    
                    
                }
                
            }
            
            // to edit section Name
            if isSelectEdit == true {
                self.currentlevel = (section?.levels[indexPath.row])!
                editLevelAlert(collectionView: collectionView, didSelectItemAt: indexPath )
            }
            
            
            print(indexPath.row)
            self.levelQuestions = questions[indexPath.row]
            self.currentlevel = (section?.levels[indexPath.row])!
            
            
            if levelsWithImages.isEmpty {
                for q in self.self.currentlevel!.questions {
                    if q.imgName != "none"{
                        let values = ["qnum": q.qnum, "image": UIImage(named: q.imgName)!] as [String : Any]
                        self.questionsImages.append(values)
                    }
                }
            } // add existed images to the array for section 1 and 2
                
            else { // for sections in firebase storage
                self.questionsImages = levelsWithImages[indexPath.row]["QuestionsImg"] as! [[String: Any]]
            }
            
            performSegue(withIdentifier: "questionsPage", sender: self)
        }
        
        
        
        func editLevelAlert(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
            let alert = UIAlertController(title: "تعديل اسم المرحلة", message: "أدخل اسم جديد", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = self.titleArray[indexPath.row]
                textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
                textField.textAlignment = .right
            }
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("تم", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                let textField = alert.textFields![0]
                var index = 0
                for sectionTitle in self.titleArray {
                    if sectionTitle == self.titleArray[indexPath.row] {
                        self.titleArray[index] = textField.text!
                    }
                    index += 1
                }
                self.EditLevelName(newName: textField.text! )
                collectionView.reloadItems(at: [indexPath])
            }))
            
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("الغاء", comment: "Default action"), style: .cancel, handler: { _ in
                NSLog("The \"cancel\" alert occured.")
                alert.dismiss(animated: true, completion: nil)
            }))
            
            alert.actions[0].isEnabled = false
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        
        // for alert text validation
        @objc func textChanged(_ sender: Any) {
            let tf = sender as! UITextField
            var resp : UIResponder! = tf
            while !(resp is UIAlertController) { resp = resp.next }
            let alert = resp as! UIAlertController
            alert.actions[0].isEnabled = (tf.text != "")
        }
        
        
        
        
        
        func EditLevelName (newName: String) {
            Database.database().reference().child("TSections").child(section!.key).child("Levels").child(currentlevel!.levelKey).updateChildValues(["Name": newName])
            
            
            var flag = true
            let ref = Database.database().reference().child("Users")
            ref.observe(.value) { (snapshot) in
                
                if flag {
                    for User in snapshot.children.allObjects as![DataSnapshot] {
                        let keyUser = User.key
                        Database.database().reference().child("Users").child(keyUser).child("TSections").child(self.section!.key).child("Levels").child(self.currentlevel!.levelKey).updateChildValues(["Name": newName])
                        
                    } // end for each user
                } // end if flag = true
                flag = false
            } // end observe
        }
        
        
        
        
        
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "addSingleLevel" {
                let v = segue.destination as? AddSingleLevel
                v!.sectionKey = section?.key
                v!.levelNum = levelsCount
                v!.sectionName = self.section?.Name
                v!.sectionsImages = self.sectionsImages
                v!.sectionsWithImages = self.sectionsWithImages
                
            } else if segue.identifier == "questionsPage" {
                let v = segue.destination as? QuestionsVC
                v?.questions = currentlevel!.questions
                v?.questionsImages = self.questionsImages
                v?.sectionKey = self.section!.key
                v?.levelKey = currentlevel!.levelKey
            }
        }
 */
        
    }

