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
    
    let dayString: [String] = ["월", "화", "수", "목", "금"]
    
    let courseList: [ElliottEvent] = [ElliottEvent(courseId: "c0001", courseName: "운영체제론", roomName: "IT Building 21204", professor: "TEST", courseDay: .tuesday, startTime: "09:00", endTime: "10:15", textColor: UIColor.white, backgroundColor: .purple), ElliottEvent(courseId: "c0002", courseName: "데이터 구조", roomName: "IT Building 21204", professor: "TEST", courseDay: .thursday, startTime: "10:00", endTime: "12:00", textColor: UIColor.white, backgroundColor: .blue), ElliottEvent(courseId: "c0002", courseName: "데이터베이스", roomName: "IT Building 21204", professor: "TEST", courseDay: .friday, startTime: "14:00", endTime: "15:00", textColor: UIColor.white, backgroundColor: .blue), ElliottEvent(courseId: "c0002", courseName: "알고리즘", roomName: "IT Building 21204", professor: "TEST", courseDay: .tuesday, startTime: "13:00", endTime: "15:00", textColor: UIColor.white, backgroundColor: .blue)] // 시간표 강의 아이템
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
 
    
    @IBAction func testRemove(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "isLogin")
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
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
