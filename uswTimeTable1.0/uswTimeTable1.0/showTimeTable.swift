//
//  ViewController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2021/12/31.
//

import UIKit
import Elliotable
import RealmSwift

class showTimeTable: UIViewController, ElliotableDelegate, ElliotableDataSource{
    
    let realm = try! Realm()
    
    @IBOutlet weak var timetable: Elliotable!
    @IBOutlet weak var timeTableNameTxt: UILabel!
    
    let dayString: [String] = ["월", "화", "수", "목", "금"]
    
    var courseList: [ElliottEvent] = []// 시간표 강의 아이템
    
    

    var timeTableName = ""
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTimeTable()
        readCourseDB()
        //        timetable.courseItems = courseList
        readTimeTable()
        
        // json 시간표 데이터 입력
}
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillappear")
        checkTimeTable()
        readCourseDB()
        readTimeTable()

    }
    
    
    
    func checkTimeTable(){
        var userData: String = UserDefaults.standard.string(forKey: "name") ?? ""
        let dbTimeTable = realm.objects(userDB.self)
        if dbTimeTable.count == 0{
            timeTableNameTxt.text = timeTableName
        } else {
            timeTableNameTxt.text = userData
        }
    }
    
    func readTimeTable(){
        timetable.delegate = self
        timetable.dataSource = self
        
        timetable.elliotBackgroundColor = UIColor.white
        timetable.borderWidth = 1
        timetable.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)

        timetable.textEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 10)
        timetable.courseItemMaxNameLength = 18
        timetable.courseItemTextSize = 12.5
        timetable.courseTextAlignment = .left

        timetable.borderCornerRadius = 24
        timetable.roomNameFontSize = 8

        timetable.courseItemHeight = 70.0
        timetable.symbolFontSize = 14
        timetable.symbolTimeFontSize = 12
        timetable.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        timetable.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        timetable.isFullBorder = true // 시간표 겉 테두리
    
        timetable.reloadData()
    }
    // ElliottEvent(courseId: myData.userCourseData[i].courseId, courseName: myData.userCourseData[i].courseName, roomName: myData.userCourseData[i].roomName, professor: myData.userCourseData[i].professor, courseDay: ElliotDay.init(rawValue: myData.userCourseData[i].courseDay)!, startTime: myData.userCourseData[i].startTime, endTime: myData.userCourseData[i].endTime, backgroundColor: UIColor.systemBlue)
    func readCourseDB(){
        var userData: String = UserDefaults.standard.string(forKey: "name") ?? ""
        let dataCount = realm.objects(userDB.self).count
        if dataCount != 0{
            let dataCheck = realm.objects(userDB.self).filter("timetableName == %s", userData)
            for getData in dataCheck{
                if getData.userCourseData.count != 0 {
                    for i in 0...getData.userCourseData.count-1 {
                        var appendData = ElliottEvent(courseId: getData.userCourseData[i].courseId, courseName: getData.userCourseData[i].courseName, roomName: getData.userCourseData[i].roomName, professor: getData.userCourseData[i].professor, courseDay: ElliotDay.init(rawValue: getData.userCourseData[i].courseDay)!, startTime: getData.userCourseData[i].startTime, endTime: getData.userCourseData[i].endTime, backgroundColor: UIColor.systemBlue)
                        courseList.append(appendData)
                    }
            }
        }
    }
        
}
    
    @IBAction func testRemove(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    
    @IBAction func testView(_ sender: Any) {
        var userData: String = UserDefaults.standard.string(forKey: "name") ?? ""
        let listVC = self.storyboard?.instantiateViewController(withIdentifier: "listVC") as! listCourseData
        listVC.checkTimeTable = userData
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    @IBAction func goList(_ sender: Any) {
        let timeVC = self.storyboard?.instantiateViewController(withIdentifier: "timeVC") as! listTimeTable
        self.navigationController?.pushViewController(timeVC, animated: true)
    }
    func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
        return courseList
    }
    
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        // Nothing
    }
    
    func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
        // Nothing
    }
    
    func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
        return dayString[dayPerIndex]
    }
    
    func numberOfDays(in elliotable: Elliotable) -> Int {
        return dayString.count
    }
}

extension showTimeTable{

}
