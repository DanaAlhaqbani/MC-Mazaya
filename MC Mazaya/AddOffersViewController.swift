//
//  AddOffersViewController.swift
//  MC
//
//  Created by Ajwan Alshaye on 08/01/1442 AH.
//  Copyright © 1442 Ajwan Alshaye. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
class AddOffersViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var OffersTitle: UITextField!
    
    @IBOutlet weak var OffersDescription: UITextField!
    
    @IBOutlet weak var OffersDetails: UITextField!
    
    @IBOutlet weak var startDate: UITextField!
    
    @IBOutlet weak var endDate: UITextField!
    
    @IBOutlet weak var NumberOfPoints: UITextField!
    
    @IBOutlet weak var Coupons: UITextField!
    
    @IBOutlet weak var DiscountCode: UITextField!
    
    @IBOutlet weak var LocalService: UIButton!
    
    @IBOutlet weak var OnlineService: UIButton!
    
    @IBOutlet weak var AllService: UIButton!
    
    
    @IBOutlet weak var OffersType: UIButton!
    
    
    @IBOutlet weak var DealOffers: UIButton!
    
    
    @IBOutlet weak var couponOffer: UIButton!
    
    
    //MARK: - Properties
    var ref : DatabaseReference?
    var datePicker = UIDatePicker()
    var dateFormatter = DateFormatter()
    var toolBar = UIToolbar()
    var ServiceType = ""
    var OfferType = ""
    var Offersarr = [String:String]()
    var isFavorite = false
    var myindex = 0
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
      
        ref = Database.database().reference()
        //datePicker
        startDate.inputView = datePicker
        endDate.inputView = datePicker
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolBar.setItems([doneButton], animated: true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        datePicker.datePickerMode = .date
        startDate.inputAccessoryView = toolBar
        endDate.inputAccessoryView = toolBar
        
        
        
    }
    //MARK: - Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == startDate {
            datePicker.datePickerMode = .date
        }
        if textField == endDate {
            datePicker.datePickerMode = .date
        }
    }
    
    
    @objc func doneButtonTapped() {
        if startDate.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            startDate.text = dateFormatter.string(from: datePicker.date)
        }
        if endDate.isFirstResponder {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            endDate.text = dateFormatter.string(from: datePicker.date)
            
        }
        view.endEditing(true)
    }
    
    @IBAction func selectServiceType(_ sender: UIButton) {
        
        
        if sender.tag == 1 {
          ServiceType = "محلي"
        } else if sender.tag == 2 {
           ServiceType = "أونلاين"
        } else {
           ServiceType = "الكل"
        }
        
        print(ServiceType)
        
    }
    
    @IBAction func SelectOfferType(_ sender: UIButton){
        if sender.tag == 1 {
              OfferType = "عرض"
            } else if sender.tag == 2 {
               OfferType = "صفقة"
            } else {
               OfferType = "قسيمة"
            }
            
            print(OfferType)
            
        }
    
    
    func AddOffers(){
        
        Offersarr = ["OffersTitle":OffersTitle.text!,"OffersDescription":OffersDescription.text!
            ,"OffersDetails":OffersDetails.text!,"startDate":startDate.text!,"endDate":endDate.text!,"NumberOfPoints":NumberOfPoints.text!,"NumberOfCoupons":Coupons.text!,"DiscountCode":DiscountCode.text!,"ServiceType":ServiceType,"OfferType":OfferType,"isFavorite":String(isFavorite)]
        
        //  ref?.child("Categories").child(AddTrademark.categoryName).child("TradeMarks").child(AddTrademark.key).updateChildValues(Offersarr)
        
       ref?.child("Categories").child(AddTrademark.categoryName).child("TradeMarks").child(AddTrademark.key).child("Offers").child("\(myindex)").setValue(Offersarr)
        
    }
    
    @IBAction func NextTapped(_ sender: Any) {
        
        AddOffers()
        
        
        
    }
    
    @IBAction func MoreOffers(_ sender: Any) {
        AddOffers()
        myindex += 1
        OffersTitle.text = ""
        OffersDescription.text = ""
        OffersDetails.text = ""
        startDate.text = ""
        endDate.text = ""
        NumberOfPoints.text = ""
        Coupons.text = ""
        DiscountCode.text = ""
        
        
        
    }
    
    }
    
    

