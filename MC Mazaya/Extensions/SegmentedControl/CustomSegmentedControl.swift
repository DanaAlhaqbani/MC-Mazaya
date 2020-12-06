//
//  CustomSegmentedControl.swift
//  MC Mazaya
//
//  Created by ALHANOUF  on 8/27/20.
//  Copyright © 2020 MC. All rights reserved.
//

//@@@@@@@@ https://medium.com/code-with-coffee/create-a-custom-segmented-control-6488400f8705


import UIKit


class CustomSegmentedControl: UIView {

    private var buttonTitles : [String ]!
    private var buttons : [UIButton] = []
    private var selectorView : UIView!

    var textColor : UIColor  = .black
    var selectorViewColor : UIColor  = .red
    var selectorTextColor : UIColor  = .red


    private func configStackView() {

        let Stack = UIStackView( arrangedSubviews: buttons)
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.distribution = .fillEqually
        addSubview(Stack)
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        Stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        Stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true





    }

    private func configSelectorView() {

        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)

        selectorView  = UIView(frame: CGRect(x: 0 , y: self.frame.height , width: selectorWidth , height: 2 ))

        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)

    }

    private func createButton() {

        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle  in buttonTitles {
            let button = UIButton (type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender :)),
                             for: .touchUpInside)

            button.setTitleColor( textColor , for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)

        }
    
    private var _seletedIndex:Int = 0
           public var selectedIndex:Int {
               return _seletedIndex
           }
    
    @objc func buttonAction(sender: UIButton) {
       
        
        
        for (buttonIndex , btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
            
            let selectorPosition =
                frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                delegate?.changeToIndex(index: buttonIndex)
            UIView.animate(withDuration: 0.3 ){
                self.selectorView.frame.origin.x = selectorPosition
            }
            btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        
        
    }
    
    private func updateView(){
        createButton()
        configSelectorView()
        configStackView()
    }
    
    convenience init(frame:CGRect,
                     buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect){
        super.draw(rect)
        updateView()
    }
    func setButtonTitles(buttonTitles: [String]){
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    
//    override func viewDidLoad(){
//        super.viewDidLoad()
//        let codeSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50), buttonTitle: ["OFF", "HTTP", "AUTO"])
//        codeSegmented.backgroundColor = .clear
//        view.addSubview(codeSegmented)
//    }
//    
    
    
   
    func setIndex (index:Int){
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        _seletedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition =
            frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2){
            self.selectorView.frame.origin.x = selectorPosition
        }
        
        
        
    }
    
    
    }


