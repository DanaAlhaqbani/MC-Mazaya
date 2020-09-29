//
//  DscriptionViewController.swift
//  MC Mazaya
//
//  Created by Ajwan Alshaye  on 21/9/20.
//  Copyright © 2020 Ajwan Alshaye. All rights reserved.
//

import UIKit


class DscriptionViewController : UIViewController , UITextViewDelegate{
    
    

 
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    


 
    func createSegmentedControl(){
    let items = [ "العرض" ,  "طريقة الاستخدام" , "معلومات التاجر"  , "الموقع"]
        let segmentedControl = UISegmentedControl( items: items)
        segmentedControl.addTarget(self, action: #selector(suitDidChange(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
           // segmentedControl.topAnchor.constraint(equalTo: view.cardIma, constant: 30),


         
        ])
        
    }
    
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            view.backgroundColor = .red
            img.image = UIImage(named: "homePage")!
            
        }
        else  if sender.selectedSegmentIndex == 1 {
                   view.backgroundColor = .blue
            img.image = UIImage(named: "homePage")!

               }
        else  if sender.selectedSegmentIndex == 2 {
                   view.backgroundColor = .green
            img.image = UIImage(named: "homePage")!

               }
        else  if sender.selectedSegmentIndex == 3 {
                   view.backgroundColor = .purple
            img.image = UIImage(named: "homePage")!

               }
        
        
        
    }
    




    @objc func suitDidChange (_ segmentedControl : UISegmentedControl){


    }






    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()

    }




    var items : [String] = []



        override func viewDidLoad() {
            super.viewDidLoad()
            
           
                        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["من نحن ", "الفروع ", "العروض  "])
                               codeSegmented.backgroundColor = .clear
                               view.addSubview(codeSegmented)
            
    }
//    extension UIImage {
//        var circleMask: UIImage? {
//            let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
//            let imageView = UIImageView(frame: .init(origin: .init(x: 0, y: 0), size: square))
//            imageView.contentMode = .scaleAspectFill
//            imageView.image = self
//            imageView.layer.cornerRadius = square.width/2
//            imageView.layer.borderColor = UIColor.white.cgColor
//            imageView.layer.borderWidth = 5
//            imageView.layer.masksToBounds = true
//            UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
//            defer { UIGraphicsEndImageContext() }
//            guard let context = UIGraphicsGetCurrentContext() else { return nil }
//            imageView.layer.render(in: context)
//            return UIGraphicsGetImageFromCurrentImageContext()
//        }
//    }

}
