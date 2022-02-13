//
//  infoCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/02/03.
//

import UIKit
import RealmSwift
import Elliotable

class infoCourseData: UIViewController{

    let realm = try! Realm()
    
    @IBOutlet weak var courseNameTxt: UILabel!
    @IBOutlet weak var roomNameTxt: UILabel!
    @IBOutlet weak var professorTxt: UILabel!
    @IBOutlet weak var myView: UIView!
    var courseIdData = ""
    var courseNameData = ""
    var roomNameData = ""
    var professorData = ""
    var numData = 0
    var classificationData = ""
    var startTimeData = ""
    var endTimeData = ""
    var courseDayData = 1 // courseDay, backgroundColor는 테스트 후 데이터 삽입 예정
    var backgroundColor = UIColor.purple
    var checkTimeTable = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseNameTxt.text = courseNameData
        roomNameTxt.text = roomNameData
        professorTxt.text = professorData
        myView.layer.cornerRadius = 12.0
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        realm.beginWrite()
        let readUserDB = realm.objects(userDB.self)
        let courseData = testUserCourse()
        var courseCount = realm.objects(testUserCourse.self).count
        
        for userData in readUserDB{
            if userData.timetableName == checkTimeTable{
                courseData.courseId = courseIdData
                courseData.courseName = courseNameData
                courseData.roomName = roomNameData
                courseData.courseDay = 2
                courseData.professor = professorData
                courseData.startTime = startTimeData
                courseData.endTime = endTimeData
                courseData.courseCount = courseCount
                userData.userCourseData.append(courseData)
                realm.add(courseData)
                realm.add(userData)
            }
        }
        
        try! realm.commitWrite()
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
    


