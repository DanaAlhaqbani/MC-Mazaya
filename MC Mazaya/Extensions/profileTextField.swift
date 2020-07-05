//
//  profileTextField.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 04/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

class InputTextField : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOpacity = 1
//        self.layer.shadowOffset = .zero
//        self.layer.shadowRadius = 5
        self.textField.textAlignment = .right

        self.addSubview(textField)
        self.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            
            separatorView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: -5),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.widthAnchor.constraint(equalTo: textField.widthAnchor),
            separatorView.centerXAnchor.constraint(equalTo: textField.centerXAnchor)
        ])
    }
    

    lazy var textField : UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .none
        $0.minimumFontSize = 12
        $0.textAlignment = .left
        $0.font = UIFont(name: "stc", size: 22)
        $0.delegate = self
        return $0
    }(UITextField())
    
    let separatorView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .gray
        return $0
    }(UIView())
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

extension InputTextField : UITextFieldDelegate  {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let trimmed = self.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.textField.text = trimmed
    }
    func customTextColor(text : UIColor) {
        self.textField.tintColor = text
    }
    func setPass (){
        self.textField.isSecureTextEntry = true
    }
    
}

extension UITextField {
    func placeholderColor(text : String , color : UIColor) {
        self.attributedPlaceholder = NSAttributedString(string: text,
        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
}


extension UIView {
    
    func shakeView() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.09
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))

        self.layer.add(animation, forKey: "position")
    }
}


class InputTextView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
        
        self.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
 
        ])
    }
    

    lazy var textView : UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .left
        $0.font = UIFont(name: "Futura", size: 16)
        $0.textColor = .darkGray
        return $0
    }(UITextView())
   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
}

