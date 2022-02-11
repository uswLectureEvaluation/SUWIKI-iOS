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

    @IBOutlet weak var timetable: Elliotable!
    @IBOutlet weak var timeTableNameTxt: UILabel!
    let dayString: [String] = ["월", "화", "수", "목", "금"]
    var courseList: [ElliottEvent] = []// 시간표 강의 아이템
    let course_1 = ElliottEvent(courseId: "c0001", courseName: "선형대수학", roomName: "IT308", professor: "고혁진", courseDay: ElliotDay.init(rawValue: 5)!, startTime: "14:30", endTime: "16:20", backgroundColor: UIColor.systemBlue)
    let course_2 = ElliottEvent(courseId: "c0002", courseName: "인공지능", roomName: "IT308", professor: "고혁진", courseDay: ElliotDay.init(rawValue: 5)!, startTime: "09:30", endTime: "12:20", backgroundColor: UIColor.systemMint)
    let course_3 = ElliottEvent(courseId: "c0003", courseName: "모바일 프로그래밍", roomName: "IT215", professor: "김영미", courseDay: ElliotDay.init(rawValue: 1)!, startTime: "10:30", endTime: "13:20", backgroundColor: UIColor.lightGray)
    let course_4 = ElliottEvent(courseId: "c0004", courseName: "소프트웨어프로젝트1", roomName: "IT214", professor: "홍석우", courseDay: ElliotDay.init(rawValue: 2)!, startTime: "10:30", endTime: "13:20", backgroundColor: UIColor.systemGreen)
    let course_5 = ElliottEvent(courseId: "c0005", courseName: "문화기술과 디지털컨텐츠", roomName: "종합506", professor: "-", courseDay: ElliotDay.init(rawValue: 2)!, startTime: "15:30", endTime: "18:20", backgroundColor: UIColor.systemPurple)
    let course_6 = ElliottEvent(courseId: "c0006", courseName: "예술과 심리치료", roomName: "종합506", professor: "-", courseDay: ElliotDay.init(rawValue: 1)!, startTime: "13:30", endTime: "16:20", backgroundColor: UIColor.systemTeal)
    var timeTableName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        timeTableNameTxt.text = timeTableName
        courseList.append(course_1)
        courseList.append(course_2)
        courseList.append(course_3)
        courseList.append(course_4)
        courseList.append(course_5)
        courseList.append(course_6)
//        timetable.courseItems = courseList
   
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
        
        // json 시간표 데이터 입력
}
 
    func readCourseDB(){
        
    }
    
    @IBAction func testRemove(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    
    @IBAction func testView(_ sender: Any) {
        let listVC = self.storyboard?.instantiateViewController(withIdentifier: "listVC") as! listCourseData
        listVC.checkTimeTable = timeTableName
        self.navigationController?.pushViewController(listVC, animated: true)
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
