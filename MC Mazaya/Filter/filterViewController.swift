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
    @IBOutlet weak var categoryThirdSubStack: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    var Categories = [Category]()
    var trademarks = [Trademark]()
    var passedCategories = [Category]()
    var Trades = [Trademark]()
    var selectedCategory : [Category]!
    var selectedCategoryName = [String]()
    var delegate : sendBackSelectedOptions! = nil
    var serviceTypeButtonsArray = [CustomButton]()
    var sortByButtonsArray = [CustomButton]()
    var categoryButtonsArray = [categoryButton]()
    var selectedChecker : Bool! = false
    var passedTradeMarks = [Trademark]()
    var selectedServiceString : String?
    var selectedSortByString : String?
    var dismissHandler: (() -> Void)!
    
    lazy var featuredChoice : CustomButton = {
        $0.setTitle("مميز", for: .normal)
        $0.addTarget(self, action: #selector(orderedByBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    
    lazy var mostWatched : CustomButton = {
        $0.setTitle("الأكثر مشاهدة", for: .normal)
        $0.addTarget(self, action: #selector(orderedByBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    lazy var online : CustomButton = {
        $0.setTitle("أونلاين", for: .normal)
        $0.addTarget(self, action: #selector(serviceTypeBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    lazy var nearest : CustomButton = {
        $0.setTitle("قريب مني", for: .normal)
        $0.addTarget(self, action: #selector(orderedByBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    lazy var all : CustomButton = {
        $0.setTitle("الكل", for: .normal)
        $0.addTarget(self, action: #selector(serviceTypeBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    lazy var local : CustomButton = {
        $0.setTitle("محلي", for: .normal)
        $0.addTarget(self, action: #selector(serviceTypeBtnClicked(_:)), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    
    lazy var electronicsCategory : categoryButton = {
        $0.Label.text = "الكترونيات"
        $0.image.image = UIImage(named: "Electronics")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    lazy var carsCategory : categoryButton = {
        $0.Label.text = "السيارات"
        $0.image.image = UIImage(named: "Cars")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    lazy var foodCategory : categoryButton = {
        $0.Label.text = "الأغذية"
        $0.image.image = UIImage(named: "Restaurants")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    lazy var clothesCategory : categoryButton = {
        $0.Label.text = "التسوق"
        $0.image.image = UIImage(named: "Clothes")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    lazy var travelCategory : categoryButton = {
        $0.Label.text = "السفر"
        $0.image.image = UIImage(named: "Travel")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    lazy var healthCategory : categoryButton = {
        $0.Label.text = "الرياضة"
        $0.image.image = UIImage(named: "sports")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    lazy var homeCategory : categoryButton = {
        $0.Label.text = "المنزل"
        $0.image.image = UIImage(named: "Home-1")
         $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    lazy var schoolsCategory : categoryButton = {
        $0.Label.text = "المدارس"
        $0.image.image = UIImage(named: "Schools")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    lazy var servicesCategory : categoryButton = {
        $0.Label.text = "خدمات"
        $0.image.image = UIImage(named: "Services")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(categoryBtnClicked), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    // MARK: - View Lify Cecle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "تصفية النتائج"
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
        sortByButtonsArray.append(featuredChoice)
        sortByButtonsArray.append(mostWatched)
        sortByButtonsArray.append(nearest)
    } // End of Ordered by stack setup
    
    func setStoreTypeStack(){
        storeType.translatesAutoresizingMaskIntoConstraints = false
        storeType.alignment = .fill
        storeType.distribution = .fillEqually
        storeType.spacing = -15.00
        storeType.addArrangedSubview(all)
        storeType.addArrangedSubview(online)
        storeType.addArrangedSubview(local)
        serviceTypeButtonsArray.append(all)
        serviceTypeButtonsArray.append(online)
        serviceTypeButtonsArray.append(local)
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
        categoryThirdSubStack.alignment = .fill
        categoryThirdSubStack.distribution = .fillEqually
        categoryFirstSubStack.addArrangedSubview(electronicsCategory)
        categoryFirstSubStack.addArrangedSubview(foodCategory)
        categoryFirstSubStack.addArrangedSubview(carsCategory)
        categorySecondSubStack.addArrangedSubview(clothesCategory)
        categorySecondSubStack.addArrangedSubview(travelCategory)
        categorySecondSubStack.addArrangedSubview(healthCategory)
        categoryThirdSubStack.addArrangedSubview(homeCategory)
        categoryThirdSubStack.addArrangedSubview(schoolsCategory)
        categoryThirdSubStack.addArrangedSubview(servicesCategory)
        categoryButtonsArray.append(electronicsCategory)
        categoryButtonsArray.append(foodCategory)
        categoryButtonsArray.append(carsCategory)
        categoryButtonsArray.append(clothesCategory)
        categoryButtonsArray.append(travelCategory)
        categoryButtonsArray.append(healthCategory)
        categoryButtonsArray.append(homeCategory)
        categoryButtonsArray.append(schoolsCategory)
        categoryButtonsArray.append(servicesCategory)
    }
    
    // MARK: - Apply button handling
    @IBAction func applyBtnAction(_ sender : UIButton) {
//        self.passedCategories = []
//        self.passedTradeMarks = []
        if selectedChecker == true {
            passedCategories.removeAll()
            self.dismiss(animated: true)
        }
        else {
            if selectedSortByString == nil && selectedCategoryName != [] && selectedServiceString != nil {
                handleSelectedCategory()
                self.dismissHandler()
                self.dismiss(animated: true)
            }
            if selectedServiceString == nil && selectedSortByString != nil && selectedCategoryName != [] {
                handleSelectedCategory()
                self.dismissHandler()
                self.dismiss(animated: true)
            }
            if selectedCategoryName == [] && selectedSortByString != nil && selectedServiceString != nil {
                self.passedCategories = Categories
                handleSelectedCategory()
                self.dismissHandler()
                self.dismiss(animated: true)
            }
             if selectedSortByString == nil && selectedServiceString == nil && selectedCategoryName == [] {
                self.passedCategories = Categories
//                handleSelectedCategory()
//                self.dismissHandler()
                self.dismiss(animated: true)
            }
            if selectedSortByString == nil && selectedServiceString == nil && selectedCategoryName != [] {
                handleSelectedCategory()
                self.dismissHandler()
                self.dismiss(animated: true)
            }
            if selectedSortByString != nil && selectedServiceString != nil && selectedCategoryName != [] {
                handleSelectedCategory()
                self.dismissHandler()
                self.dismiss(animated: true)
            }
            if selectedSortByString != nil && selectedServiceString == nil && selectedCategoryName == [] {
                self.passedCategories = Categories
                handleSelectedCategory()
                self.dismissHandler()
                self.dismiss(animated: true)
            }
            if selectedSortByString == nil && selectedServiceString != nil && selectedCategoryName == [] {
                self.passedCategories = Categories
                handleSelectedCategory()
                self.dismissHandler()
                self.dismiss(animated: true)
            }
            self.dismiss(animated: true)
        }

    }
    
    //MARK: - Reset button handling
    func resetServiceTypeButtonStates() {
        for button in serviceTypeButtonsArray {
            button.isSelected = false
            button.backgroundColor = .white
            button.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
            button.layer.borderWidth = 0.5
        }
        
    }
    
    func resetSortByButtons(){
        for button in sortByButtonsArray {
            button.isSelected = false
            button.backgroundColor = .white
            button.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
            button.layer.borderWidth = 0.5
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
        if sender.isSelected == true {
            self.selectedCategoryName = []
            self.selectedSortByString = nil
            self.selectedServiceString = nil
            self.selectedChecker = true
            resetServiceTypeButtonStates()
            resetSortByButtons()
            resetCategoryButtonStates()
            self.dismissHandler()
            sender.tintColor = .white
            sender.titleLabel?.textColor = .red
            sender.setTitleColor(UIColor(rgb: 0xAA262E), for: .selected)
        } else {
            self.selectedChecker = false
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
        resetServiceTypeButtonStates()
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor(rgb: 0x38a089)
            sender.titleLabel?.textColor = .white
            sender.layer.borderColor = UIColor.white.cgColor
            self.selectedServiceString = sender.titleLabel?.text
            
        } else {
            sender.backgroundColor = .white
            sender.layer.borderColor =  UIColor(rgb: 0x38a089).cgColor
            self.selectedServiceString = nil
        }
    }
    
    @objc func orderedByBtnClicked(_ sender: CustomButton){
        resetSortByButtons()
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor(rgb: 0x38a089)
            sender.titleLabel?.textColor = .white
            sender.layer.borderColor = UIColor.white.cgColor
            self.selectedSortByString = sender.titleLabel?.text
            
        } else {
            sender.backgroundColor = .white
            sender.layer.borderColor =  UIColor(rgb: 0x38a089).cgColor
            self.selectedSortByString = nil
        }
    }

    
    func handleSelectedCategory(){
        for name in selectedCategoryName {
            let catName = name
            for category in Categories {
                if category.Name == catName {
                    self.passedCategories.append(category)
                }
            }
            self.dismissHandler()
        }
    }
    
    
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
