//
//  DscriptionViewController.swift
//  MC Mazaya
//
//  Created by ALHANOUF  on 7/5/20.
//  Copyright © 2020 MC. All rights reserved.
//

import UIKit


class DscriptionViewController : UIViewController , UITextViewDelegate{

 
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    
//    fileprivate var texts = ["مستعمل","جديد"]
//
//    fileprivate var popover: Popover!
//     fileprivate var popoverOptions: [PopoverOption] = [
//         .type(.up),
//         .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
//     ]
//class DscriptionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

 
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


//   //////// 33333333333333
//    let productName: UITextField = {
//          let tf = UITextField()
//          tf.placeholder = "Email"
//          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
//          tf.borderStyle = .roundedRect
//          tf.font = UIFont.systemFont(ofSize: 14)
//          return tf
//      }()
//
//
//      let phoneNumTxtField: UITextField = {
//          let tf = UITextField()
//          tf.placeholder = "Email"
//          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
//          tf.borderStyle = .roundedRect
//          tf.font = UIFont.systemFont(ofSize: 14)
//          return tf
//      }()
//
//
//      let emailTextField: UITextField = {
//          let tf = UITextField()
//          tf.placeholder = "Email"
//          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
//          tf.borderStyle = .roundedRect
//          tf.font = UIFont.systemFont(ofSize: 14)
//          return tf
//      }()
//
//
//      let locationTxtField: UITextField = {
//          let tf = UITextField()
//          tf.placeholder = "Email"
//          tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
//          tf.borderStyle = .roundedRect
//          tf.font = UIFont.systemFont(ofSize: 14)
//          return tf
//      }()
//
//
//        let descriptionLabel: UILabel = {
//            let label = UILabel()
//            label.textColor = .lightGray
//            return label
//        }()
//
//        lazy var descriptionTextView: UITextView = {
//            let tv = UITextView()
//            tv.translatesAutoresizingMaskIntoConstraints = false
//            tv.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
//            tv.backgroundColor = UIColor.rgb(red: 234, green: 234, blue: 234)
//
//            tv.delegate = self
//            tv.becomeFirstResponder()
//            return tv
//        }()
//
//        lazy var itemLabel: UILabel = {
//              let label = UILabel()
//              label.text = "جديد  ▼"
//              label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMore)))
//              label.textAlignment = .center
//              label.isUserInteractionEnabled = true
//
//              return label
//          }()
//
//
//
//
//        lazy var itemConditionView: Popover = {
//            let view = Popover()
//            view.backgroundColor = .lightGray
//
//            view.animationIn = 0.6
//            view.animationOut = 0.3
//            view.popoverType = .down
//            let startPoint = CGPoint(x: view.frame.width - 60, y: 55)
//            //60
//            let width = view.frame.width / 4
//            let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 220))
//            let options: [PopoverOption] = [.type(.up), .cornerRadius(width / 5), .showBlackOverlay(false)]
//            let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
//            popover.show(aView, fromView: itemLabel)
//            view.show(aView, point: startPoint)
//            return view
//        }()
//
//
//
//
//
//        @objc func handleMore() {
//
//            let tableView = UITableView(frame: CGRect(x: 0, y: 0, width:  view.frame.width / 2, height: 250))
//            tableView.delegate = self
//            tableView.dataSource = self
//            tableView.isScrollEnabled = true
//
//            let width = view.frame.width / 2
//
//            self.popover = Popover(options: self.popoverOptions)
//            self.popover.willShowHandler = {
//                print("willShowHandler")
//            }
//            self.popover.didShowHandler = {
//                print("didDismissHandler")
//            }
//            self.popover.willDismissHandler = {
//                print("willDismissHandler")
//            }
//            self.popover.didDismissHandler = {
//                print("didDismissHandler")
//            }
//            self.popover.show(tableView, fromView: self.itemLabel)
//
//        }
//
//
//
//
//
//        let addPictures: UIButton = {
//            let button = UIButton()
//            button.setTitle("اضف صوره", for: .normal)
//            return button
//        }()
//
//

        override func viewDidLoad() {
            super.viewDidLoad()
    }
//            let stack1 = UIStackView(arrangedSubviews: [productName,phoneNumTxtField])
//            stack1.distribution = .fillEqually
//            stack1.axis = .vertical
//            stack1.spacing = 5
//
//
//
//            let stack2 = UIStackView(arrangedSubviews: [itemConditionView,emailTextField])
//            stack2.distribution = .fillEqually
//            stack2.axis = .vertical
//            stack1.spacing = 5
//
//
//
//            view.addSubview(emailTextField)
//            emailTextField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 0)
//
//        }
//    }
//
//
//    extension DscriptionViewController: UITableViewDelegate {
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            self.popover?.dismiss()
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            cell.textLabel?.text = self.texts[(indexPath as NSIndexPath).row]
//            itemLabel.text = cell.textLabel?.text
//            itemLabel.font = UIFont.boldSystemFont(ofSize: 16)
//        }
//    }
//
//
//    extension DscriptionViewController: UITableViewDataSource {
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return texts.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//            cell.textLabel?.text = self.texts[(indexPath as NSIndexPath).row]
//
//            return cell
//        }
//
//
}
