//
//  popUpViewController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/08.
//

import UIKit
import RealmSwift
import DropDown

class popUpViewController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var semeView: UIView!
    @IBOutlet weak var table: UILabel!
    @IBOutlet weak var yearTxtField: UILabel!
    @IBOutlet weak var semeTxtField: UILabel!
    
    let yearDropDown = DropDown()
    let semeDropDown = DropDown()
    
    var timetableName = ""
    var semester = ""
    var year = ""
    var arrayIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
