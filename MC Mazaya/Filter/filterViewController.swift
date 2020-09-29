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
    
    var featuredChoice : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("مميز", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        if $0.isSelected {
            $0.backgroundColor = UIColor(rgb: 0x38a089)
            $0.tintColor = .white
        }
        return $0
    }(UIButton(type: .system))
    
    
    var mostWatched : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("الأكثر مشاهدة", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        if $0.isSelected {
            $0.backgroundColor = UIColor(rgb: 0x38a089)
            $0.tintColor = .white
        }
        return $0
    }(UIButton(type: .system))
    
    
    var nearest : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        $0.layer.borderWidth = 0.3
        $0.tintColor = UIColor(rgb: 0x38a089)
        $0.setTitle("قريب مني", for: .normal)
        $0.titleLabel?.font = UIFont(name: "STC", size: 15)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        if $0.isSelected {
            $0.backgroundColor = UIColor(rgb: 0x38a089)
            $0.tintColor = .white
        }
        return $0
    }(UIButton(type: .system))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "تصفية النتائج"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x38a089), NSAttributedString.Key.font: UIFont(name: "STC", size: 25.0)!]
        self.navigationController?.navigationBar.barTintColor = .white
        
        orderStack.translatesAutoresizingMaskIntoConstraints = false
        orderStack.alignment = .fill
        orderStack.distribution = .fillEqually
        orderStack.spacing = 20.00
        orderStack.addArrangedSubview(featuredChoice)
        orderStack.addArrangedSubview(mostWatched)
        orderStack.addArrangedSubview(nearest)
        
    }
    
    @objc func btnClicked (_ sender:UIButton) {
        sender.isSelected.toggle()
//        sender.backgroundColor = UIColor(rgb: 0x38a089)
    }
    
}
