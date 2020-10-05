//
//  filterViewController.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 12/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit
protocol sendBackSelectedOptions {
    func sendCategories(categories dataobject: [String])
}

class filterViewController: UIViewController {
    let FilterNotification = NSNotification.Name("FilterNotification")
    @IBOutlet weak var disableAll: UIButton!
    @IBOutlet weak var orderStack: UIStackView!
    @IBOutlet weak var storeType: UIStackView!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var categoryContainerStackView: UIStackView!
    @IBOutlet weak var categoryFirstSubStack: UIStackView!
    @IBOutlet weak var categorySecondSubStack: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    var Categories = [Category]()
    var trademarks = [Trademark]()
    var passedCategories = [Category]()
    var Trades = [Trademark]()
    var selectedCategory : [Category]!
    var selectedCategoryName = [String]()
    var delegate : sendBackSelectedOptions! = nil
    var buttonsArray = [CustomButton]()
    var categoryButtonsArray = [categoryButton]()
    var selectedChecker : Bool! = false
    var selectedSortingMethod = [String]()
    var selectedServiceType = [String]()
    var passedTradeMarks = [Trademark]()
    var featuredChoice : CustomButton = {
        $0.setTitle("مميز", for: .normal)
        return $0
    }(CustomButton())
    var dismissHandler: (() -> Void)!
    var mostWatched : CustomButton = {
        $0.setTitle("الأكثر مشاهدة", for: .normal)
        return $0
    }(CustomButton())
    
    var online : CustomButton = {
        $0.setTitle("أونلاين", for: .normal)
        $0.addTarget(self, action: #selector(serviceTypeBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    var nearest : CustomButton = {
        $0.setTitle("قريب مني", for: .normal)
        return $0
    }(CustomButton())
    
    var all : CustomButton = {
        $0.setTitle("الكل", for: .normal)
        $0.addTarget(self, action: #selector(serviceTypeBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    var local : CustomButton = {
        $0.setTitle("محلي", for: .normal)
        $0.addTarget(self, action: #selector(serviceTypeBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    
    var electronicsCategory : categoryButton = {
        $0.Label.text = "الكترونيات"
        $0.image.image = UIImage(named: "Electronics")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    var carsCategory : categoryButton = {
        $0.Label.text = "السيارات"
        $0.image.image = UIImage(named: "Cars")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    var foodCategory : categoryButton = {
        $0.Label.text = "الأغذية"
        $0.image.image = UIImage(named: "Restaurants")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var clothesCategory : categoryButton = {
        $0.Label.text = "التسوق"
        $0.image.image = UIImage(named: "Clothes")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    var travelCategory : categoryButton = {
        $0.Label.text = "السفر"
        $0.image.image = UIImage(named: "Travel")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var healthCategory : categoryButton = {
        $0.Label.text = "الرياضة"
        $0.image.image = UIImage(named: "sports")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var homeCategory : categoryButton = {
        $0.Label.text = "المنزل"
        $0.image.image = UIImage(named: "Home-1")
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    var schoolsCategory : categoryButton = {
        $0.Label.text = "المدارس"
        $0.image.image = UIImage(named: "schools")
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    var servicesCategory : categoryButton = {
        $0.Label.text = "خدمات"
        $0.image.image = UIImage(named: "Cars")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        return $0
    }(categoryButton())
    
    // MARK: - View Lify Cecle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "تصفية النتائج"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x38a089), NSAttributedString.Key.font: UIFont(name: "STC", size: 25.0)!]
        self.navigationController?.navigationBar.barTintColor = .white
        setOrderedByStack()
        setStoreTypeStack()
        applyButtonSetup()
        setCategoryStackView()
        self.disableAll.addTarget(self, action: #selector(disableAllBtn(_:)), for: .touchUpInside)
    }
    
    //MARK: - Setup Stacks
    func setOrderedByStack(){
        orderStack.translatesAutoresizingMaskIntoConstraints = false
        orderStack.alignment = .fill
        orderStack.distribution = .fillEqually
        orderStack.spacing = -15.00
        orderStack.addArrangedSubview(featuredChoice)
        orderStack.addArrangedSubview(mostWatched)
        orderStack.addArrangedSubview(nearest)
        buttonsArray.append(featuredChoice)
        buttonsArray.append(mostWatched)
        buttonsArray.append(nearest)
    } // End of Ordered by stack setup
    
    func setStoreTypeStack(){
        storeType.translatesAutoresizingMaskIntoConstraints = false
        storeType.alignment = .fill
        storeType.distribution = .fillEqually
        storeType.spacing = -15.00
        storeType.addArrangedSubview(all)
        storeType.addArrangedSubview(online)
        storeType.addArrangedSubview(local)
        buttonsArray.append(all)
        buttonsArray.append(online)
        buttonsArray.append(local)
    } // End of store type stack setup
    
    func setCategoryStackView(){
        backgroundView.backgroundColor = UIColor(rgb: 0xF8F8F8)
        backgroundView.layer.cornerRadius = 20
        backgroundView.clipsToBounds = true
        categoryContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        categoryContainerStackView.alignment = .fill
        categoryContainerStackView.distribution = .fillEqually
        categoryFirstSubStack.alignment = .fill
        categoryFirstSubStack.distribution = .fillEqually
        categorySecondSubStack.alignment = .fill
        categorySecondSubStack.distribution = .fillEqually
        categoryFirstSubStack.addArrangedSubview(electronicsCategory)
        categoryFirstSubStack.addArrangedSubview(foodCategory)
        categoryFirstSubStack.addArrangedSubview(carsCategory)
        categorySecondSubStack.addArrangedSubview(clothesCategory)
        categorySecondSubStack.addArrangedSubview(travelCategory)
        categorySecondSubStack.addArrangedSubview(healthCategory)
        categoryButtonsArray.append(electronicsCategory)
        categoryButtonsArray.append(foodCategory)
        categoryButtonsArray.append(carsCategory)
        categoryButtonsArray.append(clothesCategory)
        categoryButtonsArray.append(travelCategory)
        categoryButtonsArray.append(healthCategory)
    }
    
    // MARK: - Apply button handling
    @IBAction func applyBtnAction(_ sender : UIButton) {
        self.passedCategories = []
        self.passedTradeMarks = []
        if selectedChecker == true {
            passedCategories.removeAll()
//            self.dismissHandler()
//            handleServiceType()
            self.dismiss(animated: true)
        }
        else {
//            handleSelectedCategory()
            handleServiceType()
            self.dismissHandler()
            self.dismiss(animated: true)
        }
    }
    
    //MARK: - Reset button handling
    func resetButtonStates() {
        for button in buttonsArray {
            button.isSelected = false
            button.backgroundColor = .white
            button.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
            button.layer.borderWidth = 0.5
            self.selectedCategoryName = []
        }
    }
    
    func resetCategoryButtonStates() {
        for button in categoryButtonsArray {
            button.isSelected = false
            button.Label.textColor = UIColor(rgb: 0xA5A7A7)
            button.image.image = button.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        }
    }
    
    @objc func disableAllBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passedCategories = []
        self.selectedCategoryName = []
        self.selectedServiceType = []
        if sender.isSelected == true {
            self.selectedChecker = true
            resetButtonStates()
            resetCategoryButtonStates()
            self.passedCategories = []
            print("button selected")
            self.dismissHandler()
//            sender.backgroundColor = .whit
            sender.tintColor = .white
            sender.titleLabel?.textColor = .red
            sender.setTitleColor(UIColor(rgb: 0xAA262E), for: .selected)
        } else {
            self.selectedChecker = false
            print("button unselected")
            self.dismissHandler()
        }
        
    }
    
    // MARK: - Selected Category handling
    @objc func categoryBtnClicked (_ sender:categoryButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.Label.textColor = UIColor(rgb: 0x38a089)
            sender.image.image = sender.image.image?.imageWithColor(color: UIColor(rgb: 0x38a089))
            self.selectedCategoryName.append(sender.Label.text!)
        }
            
        else {
            sender.Label.textColor = UIColor(rgb: 0xA5A7A7)
            sender.image.image = sender.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
            self.selectedCategoryName.removeLast()
        }
    }
    
    
    //MARK: - Selected service type handling
    @objc func serviceTypeBtnClicked(_ sender: CustomButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor(rgb: 0x38a089)
            sender.layer.borderColor = UIColor.white.cgColor
            self.selectedServiceType.append((sender.titleLabel?.text)!)
        } else {
            sender.backgroundColor = .white
            sender.layer.borderColor =  UIColor(rgb: 0x38a089).cgColor
            self.selectedServiceType.removeLast()
        }
    }
    
    func handleServiceType(){
//        self.passedCategories = []
//        self.pa
        if selectedCategoryName.count == 0 {
            for cat in Categories {
                var category = cat
                let trades = cat.trademarks!
                for type in selectedServiceType {
//                print(type)
                    let serviceType = type
//                   print("-------------- iterate over Categories")
                    for trade in trades {
                        let offers = trade.offers!
                        for offer in offers {
//                          print("---------iterate over offers")
                            if offer.serviceType == serviceType {
                                self.passedTradeMarks.append(trade)
                                category.trademarks = self.passedTradeMarks
                            } // add trade to passed array
                        } // Iterate over offers
                    } // Iterate over trades
                    self.passedCategories.append(category)
                    } // iterate over selected service type
                self.dismissHandler()
            }
        } else {
            for name in selectedCategoryName {
                let catName = name
                for category in Categories {
                    var category = category
                    let trades = category.trademarks!
                    if category.Name == catName {
                        for type in selectedServiceType{
                            let serviceType = type
                            for trade in trades {
                                let offers = trade.offers!
                                for offer in offers {
                                    if offer.serviceType == serviceType {
                                        self.passedTradeMarks.append(trade)
                                        category.trademarks = self.passedTradeMarks
                                    }
                                }
                            }
                        }
                    self.passedCategories.append(category)
                    }
                }
                self.dismissHandler()
            }
        }
        
    }
    
    
//    func handleSelectedCategory(){
////        self.passedCategories = []
//        for name in selectedCategoryName {
//            let catName = name
//            for category in Categories {
//                if category.Name == catName {
//                    self.passedCategories.append(category)
//                }
//            }
////            handleServiceType()
//            self.dismissHandler()
//        }
//    }
    
    
    //MARK: - Setup Apply button
    func applyButtonSetup(){
        applyBtn.setTitle("تطبيق", for: .normal)
        applyBtn.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .normal)
        applyBtn.tintColor = .white
        applyBtn.layer.cornerRadius = 25.0
        applyBtn.clipsToBounds = true
        applyBtn.titleLabel?.font = UIFont(name: "STC", size: 25)
    } // End of button setup
    

    
    
    
}
