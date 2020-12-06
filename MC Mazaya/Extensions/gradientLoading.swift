//
//  gradientLoading.swift
//  MC Mazaya
//
//  Created by Alhnuof khalid on 19/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func gradientLoading(view: UIView){
        // Add Shiny Effect View
        let shinyView = UIView()
        shinyView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(shinyView)
        // Add Gradient Layer to Shiny View
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(rgb: 0xF3F3F3), UIColor.clear.cgColor]
        gradientLayer.locations = [0,0.5,1]
        gradientLayer.frame = shinyView.frame
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        shinyView.layer.mask = gradientLayer
        // Add Animation to Gradient Layer
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1.5
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "")
        view.layer.addSublayer(gradientLayer)
    }
}
