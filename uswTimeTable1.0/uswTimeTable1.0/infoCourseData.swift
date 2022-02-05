//
//  infoCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/02/03.
//

import UIKit
import RealmSwift

class infoCourseData: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var courseNameTxt: UILabel!
    @IBOutlet weak var roomNameTxt: UILabel!
    @IBOutlet weak var professorTxt: UILabel!
    @IBOutlet weak var myView: UIView!
    var courseId = ""
    var courseName = ""
    var roomName = ""
    var professor = ""
    var num = 0
    var classification = ""
    var startTime = ""
    var endTime = ""
    var courseDay = 1 // courseDay, backgroundColor는 테스트 후 데이터 삽입 예정
    var backgroundColor = UIColor.purple
    var checkTimeTable = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm.beginWrite()
        courseNameTxt.text = courseName
        roomNameTxt.text = roomName
        professorTxt.text = professor
        myView.layer.cornerRadius = 12.0
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor
        try! realm.commitWrite()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        let readMyDB = realm.objects(userDB.self)
        for myData in readMyDB{
            let firstd = myData.year
            let secondd = myData.semester
            let thirded = myData.timetableName
            print("\(firstd).\(secondd).\(thirded).")
        }
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
