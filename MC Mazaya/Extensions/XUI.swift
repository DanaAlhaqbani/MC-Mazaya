//
//  XUI.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 07/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
extension UIView {
   
    //this is the gradient colors
    func generalGradiantView() {
    let greenC = UIColor(rgb: 0x38a089)
    let white = UIColor(rgb: 0xFFFFFF)
        let topColor = UIColor.white
        let bottomColor =  greenC
        self.setGradientBackground(colorOne: topColor, colorTwo: bottomColor)
    }
    
    //setting the gradiant to the background
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.5, 1.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func setGradientBackgroundRightLeft(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.5, 1.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    func generalGradiantTabView() {
         let greenC = UIColor(rgb: 0x38a089)
        let topColor = UIColor.white
         let bottomColor =  greenC
         self.setGradientBackground(colorOne: topColor, colorTwo: bottomColor)
     }
     
     //setting the gradiant to the background
     func setGradientTabBackground(colorOne: UIColor, colorTwo: UIColor) {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = bounds
         gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 0.0, 0.1]
         gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.1)
         gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
         layer.insertSublayer(gradientLayer, at: 0)
     }
//    func setShadow() {
//        //           self.layer.cornerRadius = radius ?? self.frame.width / 2;
//        self.layer.masksToBounds = true;
//        self.layer.shadowOffset = .zero
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowRadius = 2
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.masksToBounds = false
//        //viewAll.setRadius(radius: CGFloat(signOf: 20, magnitudeOf: 20))
//
//    }
    
}
extension UIView {
//   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
}


extension UIImage {
    func resize(size: CGFloat) -> UIImage {
        if self.size.width < size || self.size.height < size {
            return self
        }
        let scale = size / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: size, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0,width: size, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
