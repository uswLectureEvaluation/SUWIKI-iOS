//
//  ViewController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2021/12/31.
//

import UIKit
import Elliotable
import RealmSwift
import GoogleMobileAds


class showTimeTable: UIViewController, ElliotableDelegate, ElliotableDataSource{
    
    let realm = try! Realm()
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var timetable: Elliotable!
    @IBOutlet weak var timeTableNameTxt: UILabel!
    @IBOutlet weak var timeTableView: UIView!
    
    @IBOutlet weak var firstSceneView: UIView!
    
    let dayString: [String] = ["월", "화", "수", "목", "금"]
    
    var courseList: [ElliottEvent] = []// 시간표 강의 아이템
    
   
    
    var timeTableName = ""
    
    
    override func viewDidLoad() {

        checkUserData()
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        navigationBarHidden()
        checkTimeTable()
        readCourseDB()
        readTimeTable()
        print(courseList.count)
        bannerView.adUnitID = "ca-app-pub-8919128352699409/3950816041"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        // json 시간표 데이터 입력
}
    override func viewWillAppear(_ animated: Bool) {
        checkUserData()
        print("viewwillappear")
        navigationBarHidden()
        checkTimeTable()
        readCourseDB()
        readTimeTable()

    }
    
    
    @IBAction func makeTimeTableBtnClicked(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    
    func checkUserData() {
        firstSceneView.isHidden = true
        timeTableView.isHidden = true
        timetable.isHidden = true
        let userData = realm.objects(userDB.self).count
        if userData > 0 {
            firstSceneView.isHidden = true
            timeTableView.isHidden = false
            timetable.isHidden = false
        } else {
            timeTableView.isHidden = true
            timetable.isHidden = true
            firstSceneView.isHidden = false
        }
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
        courseList.removeAll()
        var userData: String = UserDefaults.standard.string(forKey: "name") ?? ""
        let dataCount = realm.objects(userDB.self).count
        if dataCount != 0{
            let dataCheck = realm.objects(userDB.self).filter("timetableName == %s", userData)
            for getData in dataCheck{
                if getData.userCourseData.count != 0 {
                    for i in 0...getData.userCourseData.count-1 {
                        let appendData = ElliottEvent(courseId: getData.userCourseData[i].courseId, courseName: getData.userCourseData[i].courseName, roomName: getData.userCourseData[i].roomName, professor: getData.userCourseData[i].professor, courseDay: ElliotDay.init(rawValue: getData.userCourseData[i].courseDay)!, startTime: getData.userCourseData[i].startTime, endTime: getData.userCourseData[i].endTime, backgroundColor: randomColor(x: i))
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
            return UIColor(red: 0.6353, green: 0.6078, blue: 0.9961, alpha: 1.0) /* #a29bfe */

        case 1:
            return UIColor(red: 0.9922, green: 0.4745, blue: 0.6588, alpha: 1.0) /* #fd79a8 */

        case 2:
            return UIColor(red: 0.8824, green: 0.4392, blue: 0.3333, alpha: 1.0) /* #e17055 */

             /* #d6a2e8 */
        case 3:
            return UIColor(red: 0.4549, green: 0.7255, blue: 1, alpha: 1.0) /* #74b9ff */

        case 4:
            return UIColor(red: 0.9922, green: 0.7961, blue: 0.4314, alpha: 1.0) /* #fdcb6e */

        case 5:
            return UIColor(red: 0, green: 0.8078, blue: 0.7882, alpha: 1.0) /* #00cec9 */

        case 6:
            return UIColor(red: 0.3333, green: 0.9373, blue: 0.7686, alpha: 1.0) /* #55efc4 */

        case 7:
            return UIColor(red: 0.0353, green: 0.5176, blue: 0.8902, alpha: 1.0) /* #0984e3 */

        case 8:
            return UIColor(red: 0.9098, green: 0.2627, blue: 0.5765, alpha: 1.0) /* #e84393 */

        case 9:
            return UIColor(red: 0.4235, green: 0.3608, blue: 0.9059, alpha: 1.0) /* #6c5ce7 */

        case 10:
            return UIColor(red: 0.9804, green: 0.6941, blue: 0.6275, alpha: 1.0) /* #fab1a0 */

        default:
            return UIColor(red: 0.698, green: 0.7451, blue: 0.7647, alpha: 1.0) /* #b2bec3 */

    }
}
    
    @IBAction func testRemove(_ sender: Any) {
        
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
        
        let deleteCourse = selectedCourse.courseName
        let deleteProfessor = selectedCourse.professor
        let deleteCourseId = selectedCourse.courseId
        var courseDay = ""
        var deleteIndex: Int = courseList.firstIndex(where: { $0.courseName == "\(deleteCourse)" && $0.courseId == "\(deleteCourseId)"}) ?? 0

        
        
      
        let deleteDB = realm.objects(userDB.self).filter("timetableName == %s", userData)
        print(deleteIndex)
        print(deleteCourse)
        print(courseList.count)

            let alertController = UIAlertController(title: deleteCourse, message: deleteProfessor, preferredStyle: UIAlertController.Style.alert)

            let sendButton = UIAlertAction(title: "수정", style: .default, handler: { [self] (action) -> Void in
                courseList.removeAll(where: { $0.courseName == "\(deleteCourse)" && $0.professor == "\(deleteProfessor)" && $0.courseId == "\(deleteCourseId)" })
                
                let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
                let AD = UIApplication.shared.delegate as? AppDelegate
                infoVC.deleteIndex = deleteIndex
                infoVC.checkAdjust = 1
                infoVC.courseNameData = selectedCourse.courseName
                AD?.roomName = selectedCourse.roomName
                infoVC.roomNameData = selectedCourse.roomName
                infoVC.professorData = selectedCourse.professor
                infoVC.courseDayData = courseDay
                infoVC.numData = 3
                infoVC.classificationData = "-"
                infoVC.startTimeData = selectedCourse.startTime
                infoVC.endTimeData = selectedCourse.endTime
                
                infoVC.beforeTimeString = selectedCourse.startTime
               
            
                
                self.navigationController?.pushViewController(infoVC, animated: true)


            })
            
            let deleteButton = UIAlertAction(title: "삭제", style: .destructive, handler: { [self] (action) -> Void in
                courseList.removeAll(where: { $0.courseName == "\(deleteCourse)" && $0.professor == "\(deleteProfessor)" && $0.courseId == "\(deleteCourseId)" })
                print("Delete button tapped")
                
                for mydata in deleteDB{
                try! realm.write{
                    realm.delete(mydata.userCourseData[deleteIndex])
                    }

                }
                readTimeTable()

                
            })
            
            let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
            
            alertController.addAction(sendButton)
            alertController.addAction(deleteButton)
            alertController.addAction(cancelButton)
            self.navigationController!.present(alertController, animated: true, completion: nil)
          
        switch selectedCourse.courseDay{
        case .monday:
            courseDay = "월"
        case .tuesday:
            courseDay = "화"
        case .wednesday:
            courseDay = "수"
        case .thursday:
            courseDay = "목"
        case .friday:
            courseDay = "금"
        default:
            courseDay = "토"
            
        }

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
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }

}

