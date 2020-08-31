//
//  AdminHomeViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 05/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import FirebaseStorage

class AdminHomeViewController: UIViewController {

        var projectsRef: DatabaseReference!
        let userID = Auth.auth().currentUser?.uid
        let green = UIColor(rgb: 0x38a089)
        var count = 0
      var pageTitle = ""

        //creating array contains title
        var categories = ["المنزل","الأغذية ","السفر","السيارات","رياضة","الكترونيات","تسوق","مدارس","خدمات"]
  var iconsArray = [#imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "plane"),#imageLiteral(resourceName: "pickup-car"),#imageLiteral(resourceName: "sport"),#imageLiteral(resourceName: "tablet"),#imageLiteral(resourceName: "shopping-cart"),#imageLiteral(resourceName: "Schools"),#imageLiteral(resourceName: "support")] // change this later

        @IBOutlet weak var collectionView: FamilyCollectionViewCell!
        
        @IBOutlet weak var name: UILabel!
       
        //Side Menu Code
    
    var leftBarButtonItem = UIBarButtonItem()
    var mainViewXConstraint : NSLayoutConstraint!
    var sideMenuWidth = CGFloat()
    
        override func viewDidLoad() {
            super.viewDidLoad()
           
        }


    }
    extension AdminHomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return categories.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FamilyCollectionViewCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 25
            cell.layer.borderWidth = 5
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.borderColor = UIColor.gray.cgColor
            let number = categories[indexPath.row]
            let image = iconsArray[indexPath.row]
            cell.phone.text = number
            cell.imageF.image = image
            
            cell.contentView.backgroundColor = green
            return cell
        }
      

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = (collectionView.frame.size.width - 30) / 3
            return CGSize(width: size, height: size)
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
              print(indexPath.row)
              pageTitle = categories[indexPath.row]
        }
/*
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var add: UIButton!
    
    @IBOutlet weak var sectionCollectionView: UICollectionView!
   

  
            
            var imagesArray = [#imageLiteral(resourceName: "homePage"),#imageLiteral(resourceName: "map"),#imageLiteral(resourceName: "useOffer"),#imageLiteral(resourceName: "QA 40"),#imageLiteral(resourceName: "LogoMaz"),#imageLiteral(resourceName: "femalee")]
            var imageCount = 6
      
            //creating array contains title
            var titleArray = [String]()
            //creating array contains sections
            var categories = [Category]()
            
            // section number clicked
            var sectionNumberClicked = 0
            var pageTitle = ""
            // to decide which section is selected
            var sectionIndicator: Category?
            
            // to count number of sections
            var sectionCount = 0
            
          
            // for sections images
            var categoryImages : [[String: Any]] = []
            //creating array contains section number
            var sectionKeyArray = [String]()
            
            var trademarksCount = 0
            
            var sectionsWithImages : [[String: Any]] = []
            // to specify levels images and send them to the next page
            var levelsImgIndicator = -1
            var count = -1
            
            
            // delete indicator
            var isSelectDelete = false
            
            var isSelectEdit = false
            
      
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                navigationController?.navigationBar.isHidden = false
                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                self.navigationController?.navigationBar.shadowImage = UIImage()
                self.navigationController?.navigationBar.isTranslucent = true
            }
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                
// navigationController?.navigationBar.setGradientBackground(colors: [.clear,.clear
                //] )
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
                // Do any additional setup after loading the view.
                
                
                let nib = UINib(nibName: "CustomCellS", bundle: nil)
                sectionCollectionView.register(nib, forCellWithReuseIdentifier: "CustomCellS")
                sectionCollectionView.dataSource = self
                sectionCollectionView.delegate = self
                sectionCollectionView.semanticContentAttribute = .forceRightToLeft
                
                
                // append sections names and scores to an arrays to put them into the cells
                for sec in categories {
                    sectionCount += 1
                    trademarksCount = 0
                    titleArray.append(sec.Name)
                    sectionKeyArray.append(sec.key)
                    for _ in sec.Trademarks {
                        // to know how many levels in each section
                        trademarksCount += 1
                    }
                    // each level has 3 stars so to find total score ->
                   
                } // end for
                
            }
            
            
            func convertToArabicNum(eText: String) -> String {
                var text = eText
                text = text.replacingOccurrences(of: "0", with: "٠")
                text = text.replacingOccurrences(of: "1", with: "١")
                text = text.replacingOccurrences(of: "2", with: "٢")
                text = text.replacingOccurrences(of: "3", with: "٣")
                text = text.replacingOccurrences(of: "4", with: "٤")
                text = text.replacingOccurrences(of: "5", with: "٥")
                text = text.replacingOccurrences(of: "6", with: "٦")
                text = text.replacingOccurrences(of: "7", with: "٧")
                text = text.replacingOccurrences(of: "8", with: "٨")
                text = text.replacingOccurrences(of: "9", with: "٩")
                return text
            }
            
            
            
            
            @IBAction func addNewSection(_ sender: Any) {
                
                if isSelectDelete == false &&  isSelectEdit == false {
                    performSegue(withIdentifier: "addNewSection", sender: self)
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
            
            
            
            @IBAction func editSection(_ sender: Any) {
                
                // to check if delete is selected first
                if isSelectDelete == false {
                    
                    if isSelectEdit == false {
                        let alert = UIAlertController(title: "تعديل مستوى", message:      "بإمكانك الآن اختيار المستوى الذي ترغب بتعديله بمجرد الضغط عليه" , preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                        isSelectEdit = true
                        edit.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                        
                        
                    } else if isSelectEdit == true {
                        isSelectEdit = false
                        edit.setImage(#imageLiteral(resourceName: "editingButton"), for: .normal)
                    }
                    
                    // else if delete is selected
                } else {
                    let alert = UIAlertController(title: "!عذراً", message: "يجب عليك انهاء عملية الحذف أولاً" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
                
                
            }
            
            
            
            
            @IBAction func deleteSection(_ sender: Any) {
                
                // to check if edit is selected first
                if isSelectEdit == false {
                    
                    if titleArray.count ==  2 {
                        
                        //cannot delete level
                        let alertCannotDelete = UIAlertController(title:  "حذف مستوى", message: "نأسف لك، لا يمكنك الحذف إن لم يكن هنالك سوى مستويين.", preferredStyle: .alert)
                        alertCannotDelete.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                        self.present(alertCannotDelete, animated: true)
                        //  // return back to the defaultt
                        
                        isSelectDelete = false
                        delete.setImage(#imageLiteral(resourceName: "cancelingButton"), for: .normal)
                        return
                        
                    }
                    if isSelectDelete == false {
                        let alertDelete = UIAlertController(title: "حذف مستوى", message:      "بإمكانك الآن اختيار المستوى الذي ترغب بحذفه بمجرد الضغط عليه" , preferredStyle: .alert)
                        alertDelete.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                        self.present(alertDelete, animated: true)
                        isSelectDelete = true
                        delete.setImage(#imageLiteral(resourceName: "check"), for: .normal)
                        
                    } else if isSelectDelete == true {
                        isSelectDelete = false
                        delete.setImage(#imageLiteral(resourceName: "cancelingButton"), for: .normal)
                        
                    }
                    
                    // else if edit is selected
                } else {
                    let alert = UIAlertController(title: "!عذراً", message: "يجب عليك انهاء عملية التعديل أولاً" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
            
            
            
        }


        extension AdminHomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
            
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return titleArray.count
            }
            
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellS", for: indexPath) as? CustomCellS else {
                    fatalError("can't dequeue CustomCellS")
                }
                cell.label.text = titleArray[indexPath.row]
                
                // for first and second sections
                if imageCount <= 6 && imageCount > 0 {
                    if sectionKeyArray[indexPath.row] == "-M2SfoCallhbRI3BOuQa" ||
                        sectionKeyArray[indexPath.row] == "-M2TA9iUNUknT2cRpCcM" ||
                        sectionKeyArray[indexPath.row] == "-M5OlNo1llwPct0GPy3x" ||
                        sectionKeyArray[indexPath.row] == "-M5Ommz3TX2DUnMHBdGV" ||
                        sectionKeyArray[indexPath.row] == "-M5OnGMnNi4vAFmt0M-x" ||
                        sectionKeyArray[indexPath.row] == "-M5OnrURBaucizDMXAOm"  {
                        cell.sectionImage.image = imagesArray[indexPath.row]
                        imageCount -= 1
                    }
                }
                else {
                    // to add section images to the cells
                    for secImg in categoryImages {
                        let sectionKey = secImg["SectionKey"] as! String
                        if sectionKeyArray[indexPath.row] == sectionKey {
                            cell.sectionImage.image = secImg["Image"] as? UIImage
                        } // end if
                    } // end for
                } // end else
               
                return cell
            }
   
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
                let sectionID = self.categories[indexPath.row].key
                sectionNumberClicked = indexPath.row + 1
                
                // to delete section
                if isSelectDelete == true {
                    if titleArray.count ==  2 {
                        
                        //cannot delete level
                        let alertCannotDelete = UIAlertController(title:  "حذف مستوى", message: "نأسف لك، لا يمكنك الحذف إن لم يكن هنالك سوى مستويين.", preferredStyle: .alert)
                        alertCannotDelete.addAction(UIAlertAction(title:"حسنًا", style: .cancel, handler: nil))
                        self.present(alertCannotDelete, animated: true)
                        //  // return back to the deسfaultt
                        
                        isSelectDelete = false
                        delete.setImage(#imageLiteral(resourceName: "cancelingButton"), for: .normal)
                        return
                        
                    }
                    
                    //if user selected the delete option show alert
                    let alertDelete = UIAlertController(title: "حذف مستوى", message: "هل أنت متأكد من حذف هذا المستوى؟", preferredStyle: .alert)
                    
                    alertDelete.addAction(UIAlertAction(title: "نعم", style: .default, handler: { action in
                        //Deleting sectionس
                        print("Deleted")
                        self.sectionCount -= 1
                        
                        
                        var ref = Database.database().reference()
                        print(sectionID)
                        print("*******")
                        //delete from database
                        ref.child("TSections/\(sectionID)").removeValue()
                        ref.child("Levels/\(sectionID)").removeValue()
                        ref.child("Name/\(sectionID)").removeValue()
                        ref.child("Score/\(sectionID)").removeValue()
                        ref.child("imgName/\(sectionID)").removeValue()
                        ref.child("SectionNum/\(sectionID)").removeValue()
                        //                ref.child("Trophies/\(sectionID)").removeValue()
                        
                        //remove from users tsections
                        ref = Database.database().reference().child("Users")
                        ref.observe(.value) { (snapshot) in
                            
                            if snapshot.childrenCount > 0 {
                                
                                for User in snapshot.children.allObjects as![DataSnapshot] {
                                    let keyUser = User.key
                                    Database.database().reference().child("Users").child(keyUser).child("TSections").child(sectionID).removeValue()
                                    
                                } // end for each user
                                
                                
                            } // end if children
                        } // end observe
                        //remove from storage
                        
                        //count questions
                        var questionsNumberArray = [Int]()
                        for lev in self.categories[indexPath.row].Trademarks {
                            //questionsNumberArray.append(lev.questions.count)
                        }
                        //num of questions in each level
                        for lev in self.categories[indexPath.row].Trademarks {
                          // questionsNumberArray.append(lev.questions.count)
                        }
                        
                        // delete each questin in each level
                        for tademark in self.categories[indexPath.row].Trademarks {
                            var count = 0
                            let questionImageToBeDeltedSum = questionsNumberArray[count]+1 // ex. 5 questions
                            let levelToBeDelted = tademark.levelKey
                            for n in 1...questionImageToBeDeltedSum {
                                let questionNumberToBeDeleted = n
                                let storageRef = Storage.storage().reference().child("TSectionImages/").child(sectionID+"/").child(levelToBeDelted+"/").child(String(questionNumberToBeDeleted))
                                
                                print("QUESTION TO BE FV CKING DELETED!!! PLEASEEE!!!")
                                storageRef.delete { (error) in
                                    
                                    print("error: \(String(describing: error))")
                                    
                                    print("-----QUESTION IN LEVEL-------")
                                    
                                }
                                print (storageRef)
                            }
                            count += 1
                        }
                        
                        //first delete section image
                        let storageRef = Storage.storage().reference().child("TSectionImages/").child(sectionID+"/").child(sectionID)
                        // now we delete
                        print("SUPPOSE TO DELETE SECTION IMAGE")
                        storageRef.delete { (error) in
                            
                            print("error: \(String(describing: error))")
                            
                            print("-----SECTION-------")
                            
                        }
                        
                        //DELETE FROM USER STUFF
                        ref.child("Users").observeSingleEvent(of: .value) { (snapshot) in
                            // print(snapshot)
                            if let dictionary = snapshot.value as? [String: AnyObject] {
                                //print(dictionary.keys)
                                for one in dictionary.keys {
                                    ref.child("Users").child(one).child("TSections").child(sectionID).removeValue()
                                }
                            }
                            
                        }
                        
                        self.titleArray.remove(at: indexPath.row)
                        // change this later
                        if self.categories[indexPath.row].key != "-M2SfoCallhbRI3BOuQa" &&
                            self.categories[indexPath.row].key != "-M2TA9iUNUknT2cRpCcM" &&
                            self.categories[indexPath.row].key != "-M2SfoCallhbRI3BOuQa" &&
                            self.categories[indexPath.row].key != "-M2TA9iUNUknT2cRpCcM" &&
                            self.categories[indexPath.row].key != "-M5OlNo1llwPct0GPy3x" &&
                            self.categories[indexPath.row].key != "-M5Ommz3TX2DUnMHBdGV" &&
                            self.categories[indexPath.row].key != "-M5OnGMnNi4vAFmt0M-x" &&
                            self.categories[indexPath.row].key != "-M5OnrURBaucizDMXAOm" {
                            //                    print("indexPath.row===============", indexPath.row)
                            self.categoryImages.remove(at: indexPath.row-6)
                        }
                        self.categories.remove(at: indexPath.row)
                        
                        
                        //delete from the collection
                        collectionView.deleteItems(at: [indexPath])
                        
                        if self.titleArray.count ==  2 {
                            
                            //  // return back to the defaultt
                            
                            self.isSelectDelete = false
                            self.delete.setImage(#imageLiteral(resourceName: "cancelingButton"), for: .normal)
                            return
                            
                        }
                        
                        
                    }))
                    alertDelete.addAction(UIAlertAction(title: "لا", style: .cancel, handler: nil))
                    
                    self.present(alertDelete, animated: true)
                } // end delete
                
                
                // to edit section Name
                if isSelectEdit == true {
                    sectionIndicator = categories[indexPath.row]
                    editSectionAlert(collectionView: collectionView, didSelectItemAt: indexPath )
                }
                
                print(indexPath.row)
                pageTitle = titleArray[indexPath.row]
                sectionIndicator = categories[indexPath.row]
                count = -1
                levelsImgIndicator = -1
                for sec in sectionsWithImages {
                    count += 1
                    let sectionKey = sec["SectionKey"] as! String
                    if sectionKey == sectionIndicator?.key {
                        levelsImgIndicator = count
                    }
                }
                
                performSegue(withIdentifier: "theoLevels", sender: self)
            }
            
            
            
            
            func editSectionAlert(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
                let alert = UIAlertController(title: "تعديل اسم المستوى", message: "أدخل اسم جديد", preferredStyle: .alert)
                
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
                    self.EditSectionName(newName: textField.text! )
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
            
            
            func EditSectionName (newName: String) {
        //        self.start = Date()
                Database.database().reference().child("TSections").child(sectionIndicator!.key).updateChildValues(["Name": newName])
                
                
                var flag = true
                let ref = Database.database().reference().child("Users")
                ref.observe(.value) { (snapshot) in
                    
                    if snapshot.childrenCount > 0 {
                        if flag {
                            for User in snapshot.children.allObjects as![DataSnapshot] {
                                let keyUser = User.key
                                Database.database().reference().child("Users").child(keyUser).child("TSections").child(self.sectionIndicator!.key).updateChildValues(["Name": newName])
                                
                            } // end for each user
                        } // end if flag
                        flag = false
                    } // end if children
        //            self.end = Date()
        //            print("\n\n\n\n\n\n\n\n\n\n\n")
        //
        //
        //
        //
        //            let actualResponseTime = self.durationTime(start: self.start!, end: self.end!)
        //            let result = DurationComparison(maximumResponseTime: 2 ,actualResponseTime: actualResponseTime)
        //            print(result)
        //
        //
        //
        //
        //
        //            print("\n\n\n\n\n\n\n\n\n\n\n")
                } // end observe
                
            }
            
            
            
            
            func setSections(categories: [Category]){
                self.categories = categories
            }
            
          /*
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "theoLevels" {
                    let nextVC = segue.destination as? AdminTrademarksViewController
                    nextVC?.pageTitle = pageTitle
                    nextVC?.setSection(section: sectionIndicator!)
                    nextVC?.Usections = self.Usections
                    nextVC?.sectionNumber = sectionNumberClicked
                    nextVC?.sectionsImages = self.sectionsImages
                    nextVC?.sectionsWithImages = self.sectionsWithImages
                    
                    if levelsImgIndicator != -1 {
                        nextVC?.levelsWithImages = sectionsWithImages[levelsImgIndicator]["levelsImg"] as! [[String : Any]]
                    }
                    else {
                        nextVC?.levelsWithImages = []
                    }
                }
                else if segue.identifier == "addNewSection" {
                    let nextVC = segue.destination as? AddSectionsVC
                    nextVC?.sectionCount = self.sectionCount+1
                    nextVC?.sectionsImages = self.sectionsImages
                    nextVC?.sectionsWithImages = self.sectionsWithImages
                }
            }
            */
            
            func alertContent(title: String, message: String)-> UIAlertController{
                
                let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                return alertVC
            }
            
            
            
            func duration(of block: () -> Void ) -> TimeInterval {
                
                // to start a timer for the method completion
                let start = Date()
                block()
                let end = Date()
                let timeInterval = end.timeIntervalSince(start)
                return timeInterval
            }
            
            
            
            
        //
        //    func durationTime(start: Date , end: Date ) -> TimeInterval {
        //        let timeInterval = end.timeIntervalSince(start)
        //        return timeInterval
        //    }
        //
        //
        //    struct DurationComparison: CustomStringConvertible {
        //
        //        let maximumResponseTime: TimeInterval
        //        let actualResponseTime: TimeInterval
        //
        //        // to compare the actual response time to the Maximum response time
        //        var comparison: String {
        //
        //            let fasterBlock = actualResponseTime < maximumResponseTime ? "Actual response time": "Maximum response time"
        //            let slowerBlock = actualResponseTime < maximumResponseTime ? "Maximum response time" : "Actual response time"
        //
        //            let difference = (actualResponseTime - maximumResponseTime).magnitude
        //
        //
        //            return "\(fasterBlock) is \(difference) seconds faster than \(slowerBlock)"
        //        }
        //
        //        var description: String {
        //            return """
        //            Maximum response time to complete the method: \(maximumResponseTime)
        //            Actual response time for the method : \(actualResponseTime)
        //            \(comparison)
        //            """
        //        }
        //    }
            */
            
        }
