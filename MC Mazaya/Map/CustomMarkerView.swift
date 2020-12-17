//
//  CustomMarkerView.swift
//  MC Mazaya
//
//  Created by Alhanouf alabdullah on 26/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class CustomMarkerView: UIView {
    
    var imageName: String?
    var borderColor: UIColor!
    
    init(frame: CGRect, imageName: String?, borderColor: UIColor, tag: Int) {
        super.init(frame: frame)
        self.imageName=imageName
        self.borderColor=borderColor
        self.tag = tag
        setupViews()
    }
    
    func setupViews() {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.layer.cornerRadius = (30/2)
        imgView.layer.borderColor = borderColor?.cgColor
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderWidth = 4
        imgView.clipsToBounds = true
        let url = URL(string: imageName!)
        imgView.sd_setImage(with: url)
//        imgView.image = UIImage(named: imageName!)
        
        let triangleImgView = UIImageView()
        self.insertSubview(triangleImgView, belowSubview: imgView)
        triangleImgView.translatesAutoresizingMaskIntoConstraints = false
        triangleImgView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        triangleImgView.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: -6).isActive = true
        triangleImgView.widthAnchor.constraint(equalToConstant: 23/2).isActive = true
        triangleImgView.heightAnchor.constraint(equalToConstant: 24/2).isActive = true
        triangleImgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        triangleImgView.image = UIImage(named: "markerTriangle")
        triangleImgView.image = triangleImgView.image?.imageWithColor(color: primaryColor)
        triangleImgView.tintColor = borderColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
