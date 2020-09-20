//
//  Textfields.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 01/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
extension UITextField {
    
    func underlineProfileTextField(){
        let border1 = CALayer()
        let width1 = CGFloat(2.0)
        border1.borderColor = UIColor.lightGray.cgColor
        border1.frame = CGRect(x: 5, y: self.frame.size.height+8, width: self.frame.size.width+10, height: 1)
        border1.borderWidth = width1
         self.layer.addSublayer(border1)
        border1.addSublayer(border1)
        border1.setShadow()
    }
  
    
    func underlineHomeAdminTextField(){
        
        let separatorView : UIView = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .gray
            return $0
        }(UIView())
        
        self.addSubview(separatorView)
        NSLayoutConstraint.activate([
//                  textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
//                  textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
//                  textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
//                  textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
                  separatorView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
                         separatorView.heightAnchor.constraint(equalToConstant: 1),
                         separatorView.widthAnchor.constraint(equalTo: self.widthAnchor),
                         separatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
              ])
        
       
        
//           let border1 = CALayer()
//           let width1 = CGFloat(2.0)
//           border1.borderColor = UIColor.lightGray.cgColor
//           border1.frame = CGRect(x: 5, y: self.frame.size.height+8, width: self.frame.size.width+10, height: 1)
//           border1.borderWidth = width1
//            self.layer.addSublayer(border1)
//           border1.addSublayer(border1)
//           border1.setShadow()
           
       }

    func backgroundUnderlined(){
        //test
        let white = CALayer()
        white.frame =  CGRect(x: -10, y: -10, width: self.frame.size.width+60, height: self.frame.size.height+30)
        white.backgroundColor = UIColor.white.cgColor
        white.cornerRadius = 25
        self.layer.addSublayer(white)
        
        let border1 = CALayer()
        let width1 = CGFloat(2.0)
        border1.borderColor = UIColor.lightGray.cgColor
        border1.frame = CGRect(x: 5, y: self.frame.size.height+8, width: self.frame.size.width+10, height: 1)
        border1.borderWidth = width1
        white.addSublayer(border1)
        white.setShadow()
        //test
        
        
        //creating the white View
//        let whiteBackView = UIView()
//        whiteBackView.frame =  CGRect(x: -10, y: -10, width: self.frame.size.width+60, height: self.frame.size.height+30)
//        whiteBackView.backgroundColor = UIColor.white
//        whiteBackView.layer.cornerRadius = 25
//        self.addSubview(whiteBackView)
//
//        // creating the line in the view
//        let border = CALayer()
//        let width = CGFloat(2.0)
//        border.borderColor = UIColor.lightGray.cgColor
//        border.frame = CGRect(x: 5, y: self.frame.size.height+8, width: self.frame.size.width+10, height: 1)
//        border.borderWidth = width
//
//        // adding the line + adding shadow to the white view
//        whiteBackView.layer.addSublayer(border)
//        whiteBackView.setShadow()
      
    }
       func backgroundUnderlinedForTextFields(){
            //test
            let white = CALayer()
            white.frame =  CGRect(x: -20, y:0, width: self.frame.size.width + 20, height: self.frame.size.height)
            white.backgroundColor = UIColor.white.cgColor
            white.cornerRadius = 25
            self.layer.addSublayer(white)
            
//            let border1 = CALayer()
//            let width1 = CGFloat(2.0)
//            border1.borderColor = UIColor.lightGray.cgColor
//            border1.frame = CGRect(x: 5, y: self.frame.size.height, width: self.frame.size.width - 10, height: 1)
//            border1.borderWidth = width1
//            white.addSublayer(border1)
            white.setShadow()
            //test
            
            
            
            
            
            //creating the white View
    //        let whiteBackView = UIView()
    //        whiteBackView.frame =  CGRect(x: -10, y: -10, width: self.frame.size.width+60, height: self.frame.size.height+30)
    //        whiteBackView.backgroundColor = UIColor.white
    //        whiteBackView.layer.cornerRadius = 25
    //        self.addSubview(whiteBackView)
    //
    //        // creating the line in the view
    //        let border = CALayer()
    //        let width = CGFloat(2.0)
    //        border.borderColor = UIColor.lightGray.cgColor
    //        border.frame = CGRect(x: 5, y: self.frame.size.height+8, width: self.frame.size.width+10, height: 1)
    //        border.borderWidth = width
    //
    //        // adding the line + adding shadow to the white view
    //        whiteBackView.layer.addSublayer(border)
    //        whiteBackView.setShadow()
            
            
        }
    
    func roundedCorners(){
        self.layer.cornerRadius = 20
    }
}

extension CALayer {
    func setShadow() {
        //           self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.masksToBounds = true;
        self.shadowOffset = .zero
        self.shadowOpacity = 0.5
        self.shadowRadius = 2
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
        //viewAll.setRadius(radius: CGFloat(signOf: 20, magnitudeOf: 20))
        
    }
    func setShadowForAdmin() {
          //           self.layer.cornerRadius = radius ?? self.frame.width / 2;
          self.masksToBounds = true;
          self.shadowOffset = .zero
          self.shadowOpacity = 0.7
          self.shadowRadius = 10
          self.shadowColor = UIColor.black.cgColor
          self.masksToBounds = false
          //viewAll.setRadius(radius: CGFloat(signOf: 20, magnitudeOf: 20))
          
      }
    

}
