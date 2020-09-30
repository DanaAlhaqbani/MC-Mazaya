//
//  ViewController.swift
//  MC
//
//  Created by Ajwan Alshaye on 05/01/1442 AH.
//  Copyright © 1442 Ajwan Alshaye. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import Photos



 
class AddTrademark : UIViewController, UITextFieldDelegate , UIPickerViewDelegate , UIPickerViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    //MARK: - Properties
    static var key = String()
    static var categoryName = String()
     
    //from 26 - 34 these variables are unique ID's for catogreas
    let homeID = "-MGD5fU4jx26ar6dvihD"
    let food = "-MGD6U_aPfJdjIMveMnK"
    let Travel = "-MGD6g1ENLB0Ggz1z8FF"
    let cars = "-MGD6r_PsClXMmAz1gB3"
    let sports = "-MGD70-0g_i8ELSbgz0H"
    let electronics = "-MGD79NLC74yn0OYEMKw"
    let shoping = "-MGD7G9euqkuzHyHitij"
    let Schools = "-MGD7RP1yfg_2tETP71F"
    let Services = "-MGD7WgB6ciToISPeWU4"
    
    //MARK: - @IBOutlet
    @IBOutlet weak var BrandName: UITextField!
    
    
    @IBOutlet weak var BrandNameLabel: UILabel!
    
    
    @IBOutlet weak var UploadImage: UIButton!
    
    @IBOutlet weak var UploadBackground: UIButton!
    
    @IBOutlet weak var Description :UILabel!
    @IBOutlet weak var DescriptionTxt: UITextField!
    
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var Number: UILabel!
    
    
    @IBOutlet weak var NumberTxt: UITextField!
    
    
    @IBOutlet weak var EmailTxt: UITextField!
    
    
    @IBOutlet weak var WebURlTxt: UITextField!

    @IBOutlet weak var SelectCAT: UIButton!
      
      
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var Instagram: UITextField!
    
     //@IBOutlet var imageview: UIImageView!
   
    @IBOutlet weak var Twitter: UITextField!
    
    
    @IBOutlet weak var Facebook: UITextField!
    
     
    
    
    var ref : DatabaseReference?
    
    let  imagePicker = UIImagePickerController()
    
    //for selected item UIPikerView
    var selected = ""
    var image : UIImage? = nil
    
    var isValidname = false
    var isValidemail = false
    var isValidselect = false
    var isValidnumber = false
    var isvaildData = false
    //@IBOutlet var imageview: UIImageView!
    var background = ""
    let catogres = ["المنزل","الرياضة","الأغذية","السفر","السيارات","الرياضة","الكترونيات","التسوق","المدارس","الخدمات"]
    
     override func viewDidLoad() {
           super.viewDidLoad()
    
        setUpElements()
        
   
           pickerView.isHidden = true
           pickerView.delegate = self
           pickerView.dataSource = self
        
           // selected = catogres[0] //حطيت الكومنت عشان الشرط الي بالنكست
           
        
    ref = Database.database().reference()
        
        imagePicker.delegate = self
        
       checkPermissions()
        
}
 
   
    
    func setUpElements(){
        
    Utilities.styleTextField(BrandName)
      
    Utilities.styleTextField(DescriptionTxt)
        
    Utilities.styleTextField(NumberTxt)

    Utilities.styleTextField(EmailTxt)
        
    Utilities.styleTextField(WebURlTxt)
        
    Utilities.styleHollowButton(CancelButton)
        
    Utilities.styleFilledButton(NextButton)
        
   
   
        
}
    
    
    
   
   //MARK: - Methods
    
    @IBAction func NextButtonClicked(_ sender: Any) {
        
   //   self.validateData(email: EmailTxt.text!, BrandName: BrandName.text!, PhoneNumber:NumberTxt.text!,Description: DescriptionTxt.text!,WebURl:WebURlTxt.text!,Instagram:Instagram.text!,Twitter: Twitter.text!,Facebook: Facebook.text!)
        
        
   
//        if selected.isEqual("") {
//
//
//                   let alert = UIAlertController(title: "", message: "من فضلك اختار الفئة", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "حسنا", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//
//               }
//
//           else{
//
//         AddTreadMark()
//        }
//
        
        if BrandName.text != ""{
            if selected != ""{
                isvaildData = true
                
            }else{//is select catogry
                let alert = UIAlertController(title: "", message: "من فضلك اختار الفئة", preferredStyle: UIAlertController.Style.alert)
                 alert.addAction(UIAlertAction(title: "حسنا", style: UIAlertAction.Style.default, handler: nil))
                 self.present(alert, animated: true, completion: nil)

            }
            
        }else {//brandname
            let alert = self.alertContent(title:  "هذه الحقول مطلوبة!", message: "من فضلك قم بتعبئة الاسم التجاري")
                       self.present(alert, animated: true, completion: nil)
                       self.isValidname = true
        }
        
         if NumberTxt.text != "" {
            if !isValidNumber(testStr: NumberTxt.text!) {
                           let alert = self.alertContent(title:  "رقم الهاتف غير صالح!", message: "" )
                                      self.present(alert, animated: true, completion: nil)
                         }
           

                 
                }
          
                if EmailTxt.text != ""{
                    
                   if !isValidEmail(testStr: EmailTxt.text!) {
                     let alert = self.alertContent(title:   "البريد الإلكتروني خاطئ", message: "من فضلك أدخل البريد الإلكتروني بشكل صحيح" )
                    self.present(alert, animated: true, completion: nil)

                     
                  }
                    
                }
                else if isvaildData  && isValidNumber(testStr: NumberTxt.text!) || isValidEmail(testStr: EmailTxt.text!) {
                     

                        AddTreadMark()
        
                    }
        
    }
    
 
    
    @IBAction func ssselect(_ sender: UIButton) {
      
          if pickerView.isHidden{
              pickerView.isHidden = false
          }
         
      }
      
    
      func numberOfComponents(in pickerView: UIPickerView) -> Int
      {
        return 1
          
      }

            func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
              return catogres.count
          
      }
      
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return catogres[row]
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          SelectCAT.setTitle(catogres[row], for: .normal)
          pickerView.isHidden = true
        
          selected = catogres[row] //as! String
        
        print(selected)
       
      }
    
    //MARK: - Firebase
    func AddTreadMark() {
        
      
        
        
        
        let imageID = String(Date().timeIntervalSince1970)
        let imageRef = Storage.storage().reference().child("images").child(imageID)
        guard let imageData = selectedImage.resize(size: 120).pngData() else {return}
        
        imageRef.putData(imageData, metadata: nil) { (metaData, error) in
            if error == nil {
                imageRef.downloadURL { (url, error) in
                    if error == nil {
                        // after getting imageURL now start saving the data
                        let BrandInfo = ["BrandName" : self.BrandName.text! ,"BrandImage" : url!.absoluteString ,"Description" : self.DescriptionTxt.text! , "Contact Number" : self.NumberTxt.text! , "Email" : self.EmailTxt.text! , "WebURl" : self.WebURlTxt.text! , "Instagram" : self.Instagram.text! , "Twitter" : self.Twitter.text! , "Facebook": self.Facebook.text!  ] as [String : Any]
                        
                        
                        
                        switch self.selected {
                        case "المنزل":
                            
                            AddTrademark.categoryName = self.homeID
                            
                            self.ref?.child("Categories").child(self.homeID).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                    }
                                    
                                    
                                }
                            })
                            
                         
                            
                            
                            
                        case "الأغذية":
                            AddTrademark.categoryName = self.food
                            
                            self.ref?.child("Categories").child(self.food).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                    }
                                    
                                    
                                }
                            })
                            
                            
                        case "السفر" :
                            AddTrademark.categoryName = self.Travel
                            self.ref?.child("Categories").child(self.Travel).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                    }
                                    
                                    
                                }
                            })
                        case "السيارات" :
                            AddTrademark.categoryName = self.cars
                            self.ref?.child("Categories").child(self.cars).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                    }
                                    
                                    
                                }
                            })
                        case "الرياضة" :
                            AddTrademark.categoryName = self.sports
                            self.ref?.child("Categories").child(self.sports).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                        
                                    }
                                    
                                    
                                }
                            })
                            
                        case "الكترونيات" :
                            AddTrademark.categoryName = self.electronics
                            self.ref?.child("Categories").child(self.electronics).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                    }
                                    
                                    
                                }
                            })
                        case "التسوق" :
                            AddTrademark.categoryName = self.shoping
                            self.ref?.child("Categories").child(self.shoping).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                    }
                                    
                                    
                                }
                            })
                        case "المدارس":
                            AddTrademark.categoryName = self.Schools
                            self.ref?.child("Categories").child(self.Schools).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                    }
                                    
                                    
                                }
                            })
                            
                        case "الخدمات":
                            AddTrademark.categoryName = self.Services
                            self.ref?.child("Categories").child(self.Services).child("TradeMarks").childByAutoId().setValue(BrandInfo, withCompletionBlock: { (error, referance) in
                                if error == nil {
                                    
                                    if let key = referance.key {
                                        AddTrademark.key = key
                                   
                                    }
                                    
                                    
                                }
                            })
                        default:
                            print("hi")
                            
                            
                        }
                    }
                }
            }
        }
        
  
        
        
    }
      
  
    
    
    
    
    
      @IBAction func uploadImageTapped(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
        
        
        }
    
       
    
    func checkPermissions() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized{
            PHPhotoLibrary.requestAuthorization({(status:PHAuthorizationStatus)->Void in
            ()
            
        })
        
    }
    
        if  PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            
        }else{
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
            
        }
    }
    func requestAuthorizationHandler(status : PHAuthorizationStatus){
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            print("We have accessto photos")
        }else{
            print("we dont have access to photo ")
        }
            
        }
    
        
    
    var selectedImage = UIImage()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            selectedImage = image
        
        imagePicker.dismiss(animated: true , completion: nil)
        
    }
         
      func alertContent(title: String, message: String)-> UIAlertController{
          
          let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: NSLocalizedString("حسنًا", comment: "Default action"), style: .default, handler: { _ in
              NSLog("The \"OK\" alert occured.")
          }))
          return alertVC
      }
 
    
    
    
    
    
  
    
    
    
    
    
        func isValidEmail(testStr:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let result = emailTest.evaluate(with: testStr)
            isValidemail = true
            return result
        }
    func isValidNumber(testStr:String) -> Bool{
           let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
           let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
           return phoneTest.evaluate(with: testStr)
           }
     
   
   
    

    func validateData(email: String, BrandName: String, PhoneNumber:String,Description:String,WebURl:String,Instagram:String,Twitter:String,Facebook:String) {
          
        if BrandName.isEmpty  {
              
              
              let alert = self.alertContent(title:  "هذه الحقول مطلوبة!", message: "من فضلك قم بتعبئة الاسم التجاري")
            self.present(alert, animated: true, completion: nil)
            self.isValidname = true
            
            

        }
          
            
      
            
        else if   NumberTxt.text != "" {
            
            if isValidNumber(testStr: PhoneNumber) == false{
                         let alert = self.alertContent(title:  "رقم الهاتف غير صالح!", message: "" )
                                    self.present(alert, animated: true, completion: nil)
                       }
         

               
              }
        
      else if EmailTxt.text != ""{
                  
                 if isValidEmail(testStr: email) == false{
                   let alert = self.alertContent(title:   "البريد الإلكتروني خاطئ", message: "من فضلك أدخل البريد الإلكتروني بشكل صحيح" )
                  self.present(alert, animated: true, completion: nil)

                   
                }
                  
              }
       else if selected.isEqual("") {
             
            
            let alert = UIAlertController(title: "", message: "من فضلك اختار الفئة", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "حسنا", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
            
            self.isValidselect = true
           
            
            
        }
        
        
        if self.isValidname  && self.isValidNumber(testStr: PhoneNumber) && self.isValidEmail(testStr: email) && self.isValidselect {
                     

                        AddTreadMark()
        
                    }



        
    }

    
   
}
