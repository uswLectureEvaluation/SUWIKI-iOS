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
    @IBOutlet weak var numTxt: UILabel!
    @IBOutlet weak var classTxt: UILabel!
    @IBOutlet weak var professorTxt: UILabel!
    
    var courseName = ""
    var roomName = ""
    var num = 0
    var classification = ""
    var professor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNameTxt.text = courseName
        roomNameTxt.text = roomName
        numTxt.text = "\(num)"
        classTxt.text = classification
        professorTxt.text = professor
        
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
