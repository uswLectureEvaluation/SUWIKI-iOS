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
    var courseDayData = ""
    var numData = 0
    var classificationData = ""
    var startTimeData = ""
    var endTimeData = ""
   // courseDay, backgroundColor는 테스트 후 데이터 삽입 예정
    var backgroundColor = UIColor.purple
    var checkTimeTable: String = UserDefaults.standard.string(forKey: "name") ?? ""
    
    var changeDay = 0

    
    override func viewDidLoad() {
        print(courseDayData)
        checkDate()
        print(changeDay)
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
        if changeDay == 7 {
            let alert = UIAlertController(title:"죄송해요..ㅠㅠ 추가할 수 없어요",
                message: "확인버튼을 눌러주시기 바랍니다",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert,animated: true,completion: nil)
        } else {
            realm.beginWrite()
            let readUserDB = realm.objects(userDB.self)
            let courseData = testUserCourse()
            var courseCount = realm.objects(testUserCourse.self).count
            print(checkTimeTable)
            for userData in readUserDB{
                if userData.timetableName == checkTimeTable{
                    courseData.courseId = courseIdData
                    courseData.courseName = courseNameData
                    courseData.roomName = roomNameData
                    courseData.courseDay = changeDay
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
        

    func checkDate(){
        switch courseDayData{
        case "월":
            changeDay = 1
        case "화":
            changeDay = 2
        case "수":
            changeDay = 3
        case "목":
            changeDay = 4
        case "금":
            changeDay = 5
        default:
            changeDay = 7
        }
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
    


