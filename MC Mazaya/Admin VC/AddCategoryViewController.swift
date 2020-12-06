//
//  AddCategoryViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 07/01/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage



class AddCategoryViewController : UIViewController {
    /*
    

    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var sectionImg: UIImageView!
    
    @IBOutlet weak var sectionName: UITextField!
    @IBOutlet weak var addPic: UIButton!
    @IBOutlet weak var addCategory: UIButton!
    
    var imagePicker = UIImagePickerController()
    var vSpinner : UIView?
    
    
    
    var Name: String?
    var img: UIImage?
    var levelsCount = 0
    var sectionCount = 0
    var ref: DatabaseReference?
    var key: String = ""

    var sectionKey : String?
    var sectionsImages : [[String: Any]] = []
    
    var sectionsWithImages : [[String: Any]] = []
    
    let imagesGroup = DispatchGroup()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addCategory.setButton()
        self.title = "إضافة فئة"
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        addPic.setBackgroundImage(#imageLiteral(resourceName: "editButtonWhite"), for: .normal)

        imagePicker.delegate = self
        
        addCategory.setButton()
        sectionImg.layer.masksToBounds = true
        sectionImg.layer.cornerRadius = 30
        sectionImg.image = UIImage(named: "CategoryUpload")
        sectionImg.backgroundColor = .clear
        
     
        sectionName.underlineHomeAdminTextField()
        sectionName.textAlignment = .right
        self.view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9529411765, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    @IBAction func addPic(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
              imagePicker.allowsEditing = true
              present(imagePicker, animated: true, completion: nil)
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
    
    
    @IBAction func addCategoryPressed(_ sender: Any) {
        if sectionName.text != "" && validateImg() {
            confirmAddSection()
        }
        else {
            let alert = alertContent(title: "البيانات غير مكتملة!", message: "من فضلِك، أدخل اسم الفئة")
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    
    
    func validateImg() -> Bool{
        if sectionImg.image == UIImage(named: "uploadPic") {
            let alert = alertContent(title: "البيانات غير مكتملة!", message: "من فضلِك، أضف صورة الفئة")
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
  
    
    @objc func confirmAddSection(){
        let alert = alertConfirmSave(title: "سيتم إضافة فئة جديدة", message: "هل انت متأكد؟")
        present(alert, animated: true, completion: nil)

    }
    
   

    
    
    
    
    func saveToDatabase(url: URL){
        let values = ["Name": Name!, "imgName": url.absoluteString] as [String : Any]
        
        
        let ref = Database.database().reference().child("Categories").child(sectionKey!)
        
        // add section image to the array
        let imageUrl = URL(string: url.absoluteString)!
        let imageData = try! Data(contentsOf: imageUrl)
        let image = UIImage(data: imageData)
        let imgValues = ["SectionKey": sectionKey!, "Image":image!] as [String : Any]
        self.sectionsImages.append(imgValues)
        
        // save to database
        ref.setValue(values)
   
    }
    
    
    
    func addSectionsImg() {
        
        let imageData = img!.pngData()
        
        let storageRef = Storage.storage().reference().child("TSectionImages/").child(String(sectionKey!)+"/").child(String(sectionKey!))
        
        // Upload the file
        let uploadTask = storageRef.putData(imageData!, metadata: nil)
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            
            storageRef.downloadURL{ (url, err) in
                if err == nil {
                    self.saveToDatabase(url: url!)
                    print("========= storage image added successfully urrlll ===========", url!)
                }
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    func showActivityIndicator(uiView: UIView) {
         container.frame = uiView.frame
         container.center = uiView.center
         container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
     
      
         loadingView.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 80, height: 80))

         loadingView.center = uiView.center
         loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
         loadingView.clipsToBounds = true
         loadingView.layer.cornerRadius = 10
     
         activityIndicator.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 40, height: 40))
         activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
         activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

         loadingView.addSubview(activityIndicator)
         container.addSubview(loadingView)
         uiView.addSubview(container)
         activityIndicator.startAnimating()
     }
    
    func hideActivityIndicator(uiView: UIView) {
           activityIndicator.stopAnimating()
           container.removeFromSuperview()
       }
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
           let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
           let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
           let blue = CGFloat(rgbValue & 0xFF)/256.0
           return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
       }
    
    
    
    
    func alertContent(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        return alertVC
    }
    
    
    func alertConfirmExit(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("نعم", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            self.navigationController?.popToRootViewController(animated: true)
            //            self.navigationController?.popViewController(animated: true)
        }))
        
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("الغاء", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("The \"cancel\" alert occured.")
            alertVC.dismiss(animated: true) {
            }
        }))
        return alertVC
    }
    
    
    func alertConfirmSave(title: String, message: String)-> UIAlertController{
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("نعم", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            self.showActivityIndicator(uiView: self.view)
            self.addSectionsImg()
            
            /*
            DispatchQueue.global(qos: .userInitiated).async {
                self.imagesGroup.enter()
                
                
                self.imagesGroup.wait()
*/
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.hideActivityIndicator(uiView: self.view)
                    if let storyboard = self.storyboard{
                        //                print("hmmmmmm")
                        
                        let navigationController = storyboard.instantiateViewController(withIdentifier: "adminPages") as! UINavigationController
                        if let adminHomeViewController = navigationController.viewControllers.first as? AdminHomeViewController {
                            print("inside moveTo admin =================", self.sectionsImages)
                            adminHomeViewController.categoryImages = self.sectionsImages
                            adminHomeViewController.sectionsWithImages = self.sectionsWithImages
                        }
                        navigationController.modalPresentationStyle = .fullScreen
                        self.present(navigationController, animated: true, completion: nil)
                    }
                } // main dispatch
          //  } // end big dispatch
            
        }))
        
        alertVC.addAction(UIAlertAction(title: NSLocalizedString("الغاء", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("The \"cancel\" alert occured.")
            alertVC.dismiss(animated: true) {
            }
        }))
        return alertVC
    }
    
    
}

extension AddCategoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imageURL = info[.imageURL] as? URL
        print("imgUrl", imageURL!)
        
        
        if let image = info[.editedImage] as? UIImage {
            sectionImg.contentMode = .scaleAspectFit
            sectionImg.image = image
        }
        dismiss(animated: true, completion: nil)
    }
 */
}

