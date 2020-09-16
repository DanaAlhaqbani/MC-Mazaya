//
//  DscriptionViewController.swift
//  MC Mazaya
//
//  Created by ALHANOUF  on 7/5/20.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit


class DscriptionViewController : UIViewController , UITextViewDelegate {

    
    
    //MARK: - IBOutlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nav: UINavigationItem!
    
    //MARK:- Variables
    let identifier = "dis"
    var tradeInfo : Trademark!
    var name = String()

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.label.text = tradeInfo.Name
        //self.nav.leftBarButtonItem?.title = "عودة"
        //loadImage()
        

    }
    
    
    //MARK: -Fetch Trademark Logo
    func loadImage(){
        let url = URL(string: tradeInfo.brandImage ?? "https://trello-attachments.s3.amazonaws.com/5ef04261198acb0cf54fd294/807x767/db28d3a2562c70bb0b9f1f14f803af54/LogoMaz.png")
            if url != nil {
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error != nil {
                        print("Error: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    DispatchQueue.main.async {
                        self.img.image = UIImage(data: data!)
                    }
                }).resume()
            }
    }

}
