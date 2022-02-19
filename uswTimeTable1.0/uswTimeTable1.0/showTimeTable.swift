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
        print(Realm.Configuration.defaultConfiguration.fileURL!)
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
                        var appendData = ElliottEvent(courseId: getData.userCourseData[i].courseId, courseName: getData.userCourseData[i].courseName, roomName: getData.userCourseData[i].roomName, professor: getData.userCourseData[i].professor, courseDay: ElliotDay.init(rawValue: getData.userCourseData[i].courseDay)!, startTime: getData.userCourseData[i].startTime, endTime: getData.userCourseData[i].endTime, backgroundColor: randomColor(x: i))
                        courseList.append(appendData)
                    }
            }
        }
    }
        
}
    
    func randomColor(x: Int) -> UIColor{
        var rand = x
        switch rand{
        case 0:
            return UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00)
        case 1:
            return UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
        case 2:
            return UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        case 3:
            return UIColor(red: 0.99, green: 0.80, blue: 0.00, alpha: 1.00)
        case 4:
            return UIColor(red: 0.92, green: 0.59, blue: 0.58, alpha: 1.00)
        case 5:
            return UIColor(red: 0.69, green: 1.00, blue: 0.64, alpha: 1.00)
        case 6:
            return UIColor(red: 0.69, green: 1.00, blue: 1.00, alpha: 0.34)
        case 7:
            return UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
        case 8:
            return UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
        default:
            return UIColor.darkGray
    }
}
    
    @IBAction func testRemove(_ sender: Any) {
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
        var userData: String = UserDefaults.standard.string(forKey: "name") ?? ""
        var deleteCourse = selectedCourse.courseName
        var deleteProfessor = selectedCourse.professor
        var deleteIndex: Int = courseList.firstIndex(where: { $0.courseName == "\(deleteCourse)" }) ?? 0
        print(deleteIndex)
        print(deleteCourse)
        let deleteDB = realm.objects(userDB.self).filter("timetableName == %s", userData)
        print(deleteDB)
           

            let text: String = "먹어봤던 맥주 리뷰 1개만 남기면 모든 리뷰를 보실 수 있어요!"
            let attributeString = NSMutableAttributedString(string: text) // 텍스트 일부분 색상, 폰트 변경 - https://icksw.tistory.com/152
            let font: UIFont = UIFont(name: "system", size: 16)!
            attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "\(text)")) // 폰트 적용.
            attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "먹어봤던 맥주 리뷰 1개")) // '먹어봤던 맥주 리뷰 1개' 부분 색상 옐로우 변경.
            attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "만 남기면 모든 리뷰를 보실 수 있어요!")) // 나머지 부분 색상 화이트 변경.

            let alertController = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.setValue(attributeString, forKey: "attributedTitle") // 폰트 및 색상 적용.

            let sendButton = UIAlertAction(title: "수정 할수도 안할수도", style: .default, handler: { [self] (action) -> Void in
                print("Ok button tapped")
                print(courseList)

            })
            
            let deleteButton = UIAlertAction(title: "삭제하기 !", style: .destructive, handler: { [self] (action) -> Void in
                courseList.removeAll(where: { $0.courseName == "\(deleteCourse)" })
                print(courseList)
                print("Delete button tapped")
                
                for mydata in deleteDB{
                try! realm.write{
                    realm.delete(mydata.userCourseData[deleteIndex])
                    }
                }
                readTimeTable()
                
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
            
            alertController.addAction(sendButton)
            alertController.addAction(deleteButton)
            alertController.addAction(cancelButton)
            self.navigationController!.present(alertController, animated: true, completion: nil)
          

    }
    
    func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
        // nothing
    }
    
    func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
        return dayString[dayPerIndex]
    }
    
    func numberOfDays(in elliotable: Elliotable) -> Int {
        return dayString.count
    }
}

extension UIAlertAction {
    static var propertyNames: [String] {
        var outCount: UInt32 = 0
        guard let ivars = class_copyIvarList(self, &outCount) else {
            return []
        }
        var result = [String]()
        let count = Int(outCount)
        for i in 0..<count {
            let pro: Ivar = ivars[i]
            guard let ivarName = ivar_getName(pro) else {
                continue
            }
            guard let name = String(utf8String: ivarName) else {
                continue
            }
            result.append(name)
        }
        return result
    }
}
