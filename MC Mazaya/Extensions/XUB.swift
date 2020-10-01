//
//  XUB.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 01/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit

@IBDesignable
public class KGRadioButton: UIButton {

    internal var outerCircleLayer = CAShapeLayer()
    internal var innerCircleLayer = CAShapeLayer()
    
    
    @IBInspectable public var outerCircleColor: UIColor = UIColor.black {
        didSet {
            outerCircleLayer.strokeColor = outerCircleColor.cgColor
        }
    }
    @IBInspectable public var innerCircleCircleColor: UIColor = UIColor.black {
        didSet {
            setFillState()
        }
    }
    
    @IBInspectable public var outerCircleLineWidth: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    @IBInspectable public var innerCircleGap: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
    }
    // MARK: Initialization
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInitialization()
    }
internal var setCircleRadius: CGFloat {
        let width = bounds.width
        let height = bounds.height
        
        let length = width > height ? height : width
        return (length - outerCircleLineWidth) / 2
    }
    
    private var setCircleFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let radius = setCircleRadius
        let x: CGFloat
        let y: CGFloat
        
        if width > height {
            y = outerCircleLineWidth / 2
            x = (width / 2) - radius
        } else {
            x = outerCircleLineWidth / 2
            y = (height / 2) - radius
        }
        
        let diameter = 2 * radius
        return CGRect(x: x, y: y, width: diameter, height: diameter)
    }
    
    private var circlePath: UIBezierPath {
        return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: setCircleRadius)
    }
    
    private var fillCirclePath: UIBezierPath {
        let trueGap = innerCircleGap + (outerCircleLineWidth / 2)
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: setCircleRadius)
        
    }
    
    private func customInitialization() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = outerCircleColor.cgColor
        layer.addSublayer(outerCircleLayer)
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(innerCircleLayer)
        
        setFillState()
    }
    
    private func setCircleLayouts() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.path = circlePath.cgPath
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.path = fillCirclePath.cgPath
    }
    
    // MARK: Custom
    private func setFillState() {
        if self.isSelected {
            innerCircleLayer.fillColor = outerCircleColor.cgColor
        } else {
            innerCircleLayer.fillColor = UIColor.clear.cgColor
        }
    }
// Overriden methods.
    override public func prepareForInterfaceBuilder() {
        customInitialization()
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        setCircleLayouts()
    }
    override public var isSelected: Bool {
        didSet {
            setFillState()
        }
    }
}

extension UIButton {
    func setButton(){
        self.layer.cornerRadius = 25
       // self.layer.backgroundColor = UIColor.lightPeriwinkleButton.cgColor
        
    }
   
      func homeButtonDesign(){
            //test
            
            let white = CALayer()
            white.frame =  CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        white.backgroundColor = UIColor(named: "buttonBackground")?.cgColor
//        let topColor = UIColor.veryLightBlueTwo
//        let bottomColor =  UIColor.iceBlue
//        white.setGradientBackground(colorOne: topColor, colorTwo: bottomColor)
            white.cornerRadius = 25
            self.layer.addSublayer(white)
            white.setShadow()
        }
    
}

extension CGLayer {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
           
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
           gradientLayer.locations = [0.5, 1.0, 1.0]
           gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
           gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
//           self.insertSublayer(gradientLayer, at: 0)
       }
    func generalGradiantView() {
        let green = UIColor(rgb: 0x38a089)
        let dark = UIColor(rgb: 0x00524d)
        let topColor = UIColor.green
        let bottomColor =  UIColor.white
        self.setGradientBackground(colorOne: topColor, colorTwo: bottomColor)
    }
}

extension UIButton {
   func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
     let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
       color.setFill()
       UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
     }
     setBackgroundImage(colorImage, for: controlState)
   }
//    func customLabel(label: String, img: String) {
//        let titleLabel : UILabel = {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.text = label
//            $0.font = UIFont(name: "STC", size: 15.00)
//            $0.textColor = UIColor(rgb: 0x38a089)
//            return $0
//        }(UILabel())
//        let image : UIImageView = {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.image = UIImage(named: img)
//            return $0
//        }(UIImageView())
//
//        self.addSubview(titleLabel)
//        self.addSubview(image)
//        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        image.anchor(top: self.topAnchor, bottom: titleLabel.topAnchor, paddingTop: 30, width: 50, height: 50)
//        titleLabel.anchor(top: image.bottomAnchor, paddingTop: 5)
//
//        }
 }

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
//        setTitle("الأكثر مشاهدة", for: .normal)
        setTitleColor(UIColor(rgb: 0x38a089), for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setTitleColor(.white, for: .selected)
        backgroundColor = .white
        tintColor = .white
        layer.borderColor = UIColor(rgb: 0x38a089).cgColor
        layer.borderWidth = 0.3
        titleLabel?.font = UIFont(name: "STC", size: 15)
        layer.cornerRadius = 20
        addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        clipsToBounds = true
        
        
    }
    
    @objc func btnClicked (_ sender:UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = UIColor(rgb: 0x38a089)
            sender.layer.borderColor = UIColor.white.cgColor
        } else {
            sender.backgroundColor = .white
            sender.layer.borderColor =  UIColor(rgb: 0x38a089).cgColor
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        super.touchesBegan(touches, with: event)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesEnded(touches, with: event)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesCancelled(touches, with: event)
    }

}


class categoryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(UIColor(rgb: 0x38a089), for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setTitleColor(.white, for: .selected)
        tintColor = .white
//        addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        clipsToBounds = true
        self.addSubview(Label)
        self.addSubview(image)
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        Label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        image.anchor(top: self.topAnchor, bottom: Label.topAnchor, paddingTop: 30, width: 50, height: 50)
        Label.anchor(top: image.bottomAnchor, paddingTop: 5)
    }
    
    let Label : UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: "STC", size: 15.00)
        $0.textColor = UIColor(rgb: 0xA5A7A7)
        return $0
    }(UILabel())
    
    let image : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.image = UIImage(named: img)
        $0.image = $0.image?.withRenderingMode(.alwaysTemplate)
        return $0
    }(UIImageView())
    

    
//    @objc func btnClicked (_ sender:UIButton) {
//        let categoryBtn = sender as! categoryButton
//        sender.isSelected = !sender.isSelected
//        if categoryBtn.isSelected {
//            Label.textColor = UIColor(rgb: 0x38a089)
//            image.image = image.image?.imageWithColor(color: UIColor(rgb: 0x38a089))
//        }
//        else {
//            Label.textColor = UIColor(rgb: 0xA5A7A7)
//            image.image = image.image?.imageWithColor(color: UIColor(rgb:0xA5A7A7))
//        }
//
//    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        super.touchesBegan(touches, with: event)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesEnded(touches, with: event)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesCancelled(touches, with: event)
    }
    

}
