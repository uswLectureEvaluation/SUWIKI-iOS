//
//  uswMakeSchedule.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/07.
//

import UIKit
import DropDown


class uswMakeSchedule: UIViewController {
 
 
    @IBOutlet weak var yearDropdown: UIView!
    @IBOutlet weak var yearTxtField: UILabel!
    @IBOutlet weak var semeDropdown: UIView!
    @IBOutlet weak var semeTxtField: UILabel!
    let dropDown1 = DropDown()
    let dropDown2 = DropDown()
    
    let yearList = ["2022","2023","2024"]
    let semeList = ["1", "2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown1.anchorView = yearDropdown
        dropDown1.dataSource = yearList
        dropDown1.bottomOffset = CGPoint(x: 0, y:(dropDown1.anchorView?.plainView.bounds.height)!)
        dropDown1.direction = .bottom
        dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.yearTxtField.text = yearList[index]
            self.yearTxtField.font = UIFont(name: "system", size: 17)
            self.yearTxtField.textColor = .black
            self.yearTxtField.textAlignment = .center
                                            
        }
        dropDown2.anchorView = semeDropdown
        dropDown2.dataSource = semeList
        dropDown2.bottomOffset = CGPoint(x: 0, y:(dropDown2.anchorView?.plainView.bounds.height)!)
        dropDown2.direction = .bottom
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.semeTxtField.text = semeList[index]
            self.semeTxtField.font = UIFont(name: "system", size: 17)
            self.semeTxtField.textColor = .black
            self.semeTxtField.textAlignment = .center
        }
        //test
        
        
    }

    @IBAction func finishBtnClicked(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isLogin")
        UserDefaults.standard.synchronize()
        let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
        self.navigationController?.pushViewController(showVC, animated: true)
    }
    @IBAction func yearBtnClicked(_ sender: Any) {
        dropDown1.show()
    }
    
    @IBAction func semeBtnClicekd(_ sender: Any) {
        dropDown2.show()
    }
}


