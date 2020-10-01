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
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil){
       translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        if let left = left{
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom!).isActive = true
        }
        if let right = right{
            rightAnchor.constraint(equalTo: right, constant: -paddingRight!).isActive = true
        }
        if let width = width{
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height{
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
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
 

extension UISearchBar {

    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func set(textColor: UIColor) { if let textField = getTextField() { textField.textColor = textColor } }
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }

    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 6
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }

    func setSearchImage(color: UIColor) {
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        imageView.tintColor = color
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    }
}

private extension UITextField {

    private class Label: UILabel {
        private var _textColor = UIColor.lightGray
        override var textColor: UIColor! {
            set { super.textColor = _textColor }
            get { return _textColor }
        }

        init(label: UILabel, textColor: UIColor = .lightGray) {
            _textColor = textColor
            super.init(frame: label.frame)
            self.text = label.text
            self.font = label.font
        }

        required init?(coder: NSCoder) { super.init(coder: coder) }
    }


    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = "txt"
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }

    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }

    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }

    func setPlaceholder(textColor: UIColor) {
        guard let placeholderLabel = placeholderLabel else { return }
        let label = Label(label: placeholderLabel, textColor: textColor)
        setValue(label, forKey: "placeholderLabel")
    }

    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }
}

extension UITableView {

    func indicatorView() -> UIActivityIndicatorView{
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 40)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.isHidden = false
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            activityIndicatorView.isHidden = true
            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        } else {
            return activityIndicatorView
        }
    }

    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)){
        indicatorView().startAnimating()
        if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
        }

        indicatorView().isHidden = false
    }

    func stopLoading(){
        indicatorView().stopAnimating()
        indicatorView().isHidden = true
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


extension UIImage {
      func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
