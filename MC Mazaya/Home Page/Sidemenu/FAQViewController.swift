//
//  FAQViewController.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 17/11/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}
class FAQViewController: UITableViewController {
    let green = UIColor(rgb: 0x38a089)

    var tableViewData = [cellData] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.isHidden = false
        tableViewData = [cellData(opened: false, title: "ماهو برنامج مزايا وزارة التجارة؟", sectionData: ["يقدم برنامج مزايا عروض وخصومات وكوبونات لموظفي الوزارة وذلك لتحفيزهم وزيادة مستوى ولائهم ورفع ادائهم"]),
                         cellData(opened: false, title: "ماهي طريقة إضافة أفراد العائلة الى البرنامج؟", sectionData: ["بعد الدخول الى تطبيق مزايا قم باختيار خانة عائلتي وقم بإضافة أرقام أفراد العائلة كحد أعلى ٦ اشخاص وستصل اليهم دعوة تحتوي على رابط يرجي التسجيل من خلاله بالبريد الخاص بالشخص المدعو وبياناته"]),
                         cellData(opened: false, title: "كيف يمكنني استعادة كلمة المرور الخاصة بي؟", sectionData: ["من صفحة تسجيل الدخول في التطبيق قم باختيار نسيت كلمة المرور وقم بإدخل البريد الالكتروني الخاص بك والمسجل في التطبيق وستصلك رساله عبر البريد لاستعادة كلمة مرورك"]),
                         cellData(opened: false, title: "كيف يمكنني الوصول الى العروض القريبة مني", sectionData: ["أذهب الى الصفحة الرئيسية لتطبيق مزايا وقم بالضغط على أيقونة  تصفية في اعلى الصفحة واختر (قريب مني)"]),
                         cellData(opened: false, title: "كيف يمكنني الاستفادة من نقاطي؟", sectionData: ["يمكن الاستفادة من النقاط وذلك بإستبدالها بقسيمة شرائية من القسائم المتاحة في خانة القسائم الشرائية في تطبيق مزايا"]),
                       cellData(opened: false, title: "هل العروض محدودة الاستخدام؟", sectionData: ["تختلف العروض من عرض لأخر نرجوا النظر الى تفاصيل العرض لمعرفة ذلك"])]
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableViewData.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView,
               heightForRowAt indexPath: IndexPath) -> CGFloat {
       // Make the first row larger to accommodate a custom cell.
      if indexPath.row == 0 {
          return 80
       }

       // Use the default size for all other rows.
       return 120 //UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData [indexPath.section].title
            cell.textLabel?.textAlignment = .right
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = UIFont(name: "stc", size: 20)
            cell.isUserInteractionEnabled = true


            return cell
        }
        else {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1]
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.font = UIFont(name: "stc", size: 18)
            cell.textLabel?.textColor = green
            cell.isUserInteractionEnabled = false
            cell.textLabel?.numberOfLines = 4
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) // play with animation
        } else {
            tableViewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) 
        
        }
    }


}
