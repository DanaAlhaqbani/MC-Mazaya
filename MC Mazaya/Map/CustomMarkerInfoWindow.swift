//
//  CustomMarkerInfoWindow.swift
//  MC Mazaya
//
//  Created by Alhanouf alabdullah on 26/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import UIKit

class CustomMarkerInfoWindow: UIView {
    
    var txtLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var subtitleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var chevronButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var imgView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor, multiplier: 1).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        imgView.sizeThatFits(CGSize(width: 30, height: 30))
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
//        imgView.layer.cornerRadius = (30 / 2)
        imgView.layer.masksToBounds = true
        imgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        self.addSubview(chevronButton)
        chevronButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        chevronButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        chevronButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        chevronButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        chevronButton.setImage(UIImage(named: "chevron"), for: .normal)
        chevronButton.tintColor = UIColor.white
        chevronButton.isUserInteractionEnabled = false
        self.addSubview(txtLabel)
        txtLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 4).isActive = true
        txtLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 8).isActive = true
        txtLabel.trailingAnchor.constraint(equalTo: chevronButton.leadingAnchor, constant: -8).isActive = true
        txtLabel.bottomAnchor.constraint(greaterThanOrEqualTo: centerYAnchor, constant: 2).isActive = true
        txtLabel.font = UIFont.boldSystemFont(ofSize: 16)
        txtLabel.numberOfLines = 2
        txtLabel.textColor = UIColor.black
        self.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 0).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: txtLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        subtitleLabel.textColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
}
