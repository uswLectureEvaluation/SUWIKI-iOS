//
//  infoCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/02/03.
//

import UIKit

class infoCourseData: UIViewController {

    @IBOutlet weak var courseNameTxt: UILabel!
    @IBOutlet weak var roomNameTxt: UILabel!
    @IBOutlet weak var professorTxt: UILabel!
    
    @IBOutlet weak var myView: UIView!
    var courseName = ""
    var roomName = ""
    var num = 0
    var classification = ""
    var professor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        courseNameTxt.text = courseName
        roomNameTxt.text = roomName
        professorTxt.text = professor
        myView.layer.cornerRadius = 12.0
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor

        // Do any additional setup after loading the view.
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
