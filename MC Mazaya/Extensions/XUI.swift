//
//  XUI.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 07/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

var aView : UIView?


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


extension UIViewController {
    
    func Alert (Message: String) {
        let alert = UIAlertController(title: "", message: Message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showSpinner(){
         aView = UIView(frame: self.view.bounds)
         aView?.backgroundColor = UIColor(white: 0, alpha: 0.2)

         let ai = UIActivityIndicatorView(style: .large)
         ai.center = aView!.center
         ai.color = .white
         ai.startAnimating()
         aView?.addSubview(ai)
         self.view.addSubview(aView!)

         Timer.scheduledTimer(withTimeInterval: 20, repeats: false, block: {_ in self.removeSpinner()})
     }

     func removeSpinner(){
        
         aView?.removeFromSuperview()
         aView = nil
     }
    
}

extension UITableView {
    func showActivityIndicator() {
        
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .large)
            let aView = UIView(frame: self.bounds)
//            aView.backgroundColor = .white
            activityView.center = aView.center
            self.separatorStyle = .none
            activityView.startAnimating()
            aView.addSubview(activityView)
//            self.addSubview(aView)
            self.backgroundView = aView
        }
        
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.separatorStyle = .singleLine
            self.backgroundView = nil
        }
    }
}
 
