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
    @IBOutlet weak var orderStack: UIStackView!
    @IBOutlet weak var storeType: UIStackView!
    @IBOutlet weak var applyBtn: UIButton!
    var filteredTrademarks : [Trademark]!
    @IBOutlet weak var categoryContainerStackView: UIStackView!
    @IBOutlet weak var categoryFirstSubStack: UIStackView!
    @IBOutlet weak var categorySecondSubStack: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    var Categories = [Category]()
    var passedCategories = [Category]()
    var Trades = [Trademark]()
    var filteredData = [String]()
    var filteredTradeMarks = [Trademark]()
    var filteredCategory = [Category]()
    var selectedCategory : [Category]!
    var selectedCategoryName = [String]()
    var delegate : sendBackSelectedOptions! = nil
    var tableDelegate : handleRetrievedData!
    
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
        $0.setTitle("أون لاين", for: .normal)
        return $0
    }(CustomButton())
    
    var nearest : CustomButton = {
        $0.setTitle("قريب مني", for: .normal)
        return $0
    }(CustomButton())
    
    var all : CustomButton = {
        $0.setTitle("الكل", for: .normal)
        return $0
    }(CustomButton())
    
    var local : CustomButton = {
        $0.setTitle("محلي", for: .normal)
        return $0
    }(CustomButton())
    
    
    
    
    var electronicsCategory : categoryButton = {
        $0.Label.text = "الكترونيات"
        $0.image.image = UIImage(named: "Electronics")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        return $0
    }(categoryButton())
    
    var carsCategory : categoryButton = {
        $0.Label.text = "السيارات"
        $0.image.image = UIImage(named: "Cars")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var foodCategory : categoryButton = {
        $0.Label.text = "الأغذية"
        $0.image.image = UIImage(named: "Restaurants")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var clothesCategory : categoryButton = {
        $0.Label.text = "التسوق"
        $0.image.image = UIImage(named: "Clothes")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var travelCategory : categoryButton = {
        $0.Label.text = "السفر"
        $0.image.image = UIImage(named: "Travel")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var healthCategory : categoryButton = {
        $0.Label.text = "الرياضة"
        $0.image.image = UIImage(named: "sports")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var homeCategory : categoryButton = {
        $0.Label.text = "المنزل"
        $0.image.image = UIImage(named: "Home-1")
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var schoolsCategory : categoryButton = {
        $0.Label.text = "المدارس"
        $0.image.image = UIImage(named: "schools")
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)

        return $0
    }(categoryButton())
    
    var servicesCategory : categoryButton = {
        $0.Label.text = "خدمات"
        $0.image.image = UIImage(named: "Cars")
        $0.image.image = $0.image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
        return $0
    }(categoryButton())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "تصفية النتائج"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x38a089), NSAttributedString.Key.font: UIFont(name: "STC", size: 25.0)!]
        self.navigationController?.navigationBar.barTintColor = .white
        setOrderedByStack()
        setStoreTypeStack()
        applyButtonSetup()
        setCategoryStackView()
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
    } // End of Ordered by stack setup
    
    func setStoreTypeStack(){
        storeType.translatesAutoresizingMaskIntoConstraints = false
        storeType.alignment = .fill
        storeType.distribution = .fillEqually
        storeType.spacing = -15.00
        storeType.addArrangedSubview(all)
        storeType.addArrangedSubview(online)
        storeType.addArrangedSubview(local)
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
    }
    
    // MARK: - Handle buttons selection
    @IBAction func applyBtnAction(_ sender : UIButton) {
        self.passedCategories = []
        for name in selectedCategoryName {
            let catName = name
            for category in Categories {
                if category.Name == catName {
                    self.passedCategories.append(category)
                }
            }
            self.dismissHandler()
        }
        self.dismiss(animated: true)
    }
    
    @IBAction func disableAll(_ sender: Any) {
        featuredChoice.isSelected = false
        mostWatched.isSelected = false
        nearest.isSelected = false
        local.isSelected = false
        online.isSelected = false
        all.isSelected = false
        electronicsCategory.isSelected = false
        carsCategory.isSelected = false
        homeCategory.isSelected = false
        healthCategory.isSelected = false
        clothesCategory.isSelected = false
        travelCategory.isSelected = false
        
    }
    
    
    
    @objc func btnClicked (_ sender:categoryButton) {
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
    
    func disSelectButtons(){
//        self.
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
