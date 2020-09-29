//
//  filterViewController.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 12/02/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import UIKit

class filterViewController: UIViewController {

    @IBOutlet weak var orderStack: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var storeType: UIStackView!
    @IBOutlet weak var applyBtn: UIButton!
    var filteredTrademarks : [Trademark]!
    
    
    var featuredChoice : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("مميز", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.setBackgroundColor(UIColor.white, forState: .normal)
        $0.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .selected)
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    
    var mostWatched : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundColor(UIColor.white, forState: .normal)
        $0.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .selected)
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("الأكثر مشاهدة", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    
    var nearest : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.setBackgroundColor(UIColor.white, forState: .normal)
        $0.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .selected)
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("قريب مني", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    var all : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.setBackgroundColor(UIColor.white, forState: .normal)
        $0.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .selected)
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("الكل", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    var online : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.setBackgroundColor(UIColor.white, forState: .normal)
        $0.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .selected)
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("أون لاين", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    var local : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.setBackgroundColor(UIColor.white, forState: .normal)
        $0.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .selected)
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("محلي", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        $0.clipsToBounds = true
        return $0
    }(UIButton(type: .system))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "تصفية النتائج"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x38a089), NSAttributedString.Key.font: UIFont(name: "STC", size: 25.0)!]
        self.navigationController?.navigationBar.barTintColor = .white
        setOrderedByStack()
        setStoreTypeStack()
        applyButtonSetup()
    }
    
    //MARK: - Setup Stacks
    func setOrderedByStack(){
        orderStack.translatesAutoresizingMaskIntoConstraints = false
        orderStack.alignment = .fill
        orderStack.distribution = .fillEqually
        orderStack.spacing = 20.00
        orderStack.addArrangedSubview(featuredChoice)
        orderStack.addArrangedSubview(mostWatched)
        orderStack.addArrangedSubview(nearest)
    } // End of Ordered by stack setup
    
    func setStoreTypeStack(){
        storeType.translatesAutoresizingMaskIntoConstraints = false
        storeType.alignment = .fill
        storeType.distribution = .fillEqually
        storeType.spacing = 20.00
        storeType.addArrangedSubview(all)
        storeType.addArrangedSubview(online)
        storeType.addArrangedSubview(local)
    } // End of store type stack setup
    
    
    // MARK: - Handle buttons selection
    @objc func btnClicked (_ sender:UIButton) {
        sender.isSelected.toggle()
    }
    
    //MARK: - Setup Apply button
    func applyButtonSetup(){
        applyBtn.setTitle("تطبيق", for: .normal)
        applyBtn.setBackgroundColor(UIColor(rgb: 0x38a089), forState: .normal)
        applyBtn.tintColor = .white
        applyBtn.layer.cornerRadius = 25.0
        applyBtn.clipsToBounds = true
    } // End of button setup
    
    @objc func applyBtnClicked(_ sender: UIButton){
        self.performSegue(withIdentifier: "filteredTrademarls", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filteredTrademarks" {
            let vc = UIViewController() as? homePageViewController
//            vc?.Categories = self.
        }
    }
    
}
