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
    
    @IBOutlet weak var timeTableCornerView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var timetable: Elliotable!
    @IBOutlet weak var timeTableNameTxt: UILabel!
    @IBOutlet weak var timeTableView: UIView!
    
    @IBOutlet weak var firstSceneView: UIView!
    
    let dayString: [String] = ["월", "화", "수", "목", "금"]
    
    var courseList: [ElliottEvent] = []// 시간표 강의 아이템
    
   
    
    var timeTableName = ""
    
    
    override func viewDidLoad() {
        timeTableCornerView.layer.cornerRadius = 13.0
        timeTableCornerView.layer.borderWidth = 1.0
        timeTableCornerView.layer.borderColor = UIColor.systemGray6.cgColor
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
        timeTableCornerView.layer.cornerRadius = 13.0
        timeTableCornerView.layer.borderWidth = 1.0
        timeTableCornerView.layer.borderColor = UIColor.systemGray6.cgColor
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
        firstSceneView.isHidden = false
        timeTableCornerView.isHidden = false
        timeTableView.isHidden = false
        timetable.isHidden = false
        let userData = realm.objects(userDB.self).count
        print("\(userData)test")
        if userData > 0 {
            firstSceneView.isHidden = true
            timeTableView.isHidden = false
            timeTableCornerView.isHidden = false
            timetable.isHidden = false
        } else {
            timetable.isHidden = true
            timeTableView.isHidden = true
            timeTableCornerView.isHidden = true
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
        timetable.courseItemTextSize = 11
        timetable.courseTextAlignment = .left

        timetable.borderCornerRadius = 24
        timetable.roomNameFontSize = 9

        timetable.courseItemHeight = 70.0
        timetable.symbolFontSize = 14
        timetable.symbolTimeFontSize = 12
        timetable.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        timetable.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        timetable.isFullBorder = false // 시간표 겉 테두리
    
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
            return UIColor(red: 0.5255, green: 0.8078, blue: 0.7569, alpha: 1.0)
        case 1:
            return UIColor(red: 0.4039, green: 0.5686, blue: 0.9922, alpha: 1.0) /* #6791fd */
        case 2:
            return UIColor(red: 0.1569, green: 0.6824, blue: 0.5882, alpha: 1.0) /* #28ae96 */

        case 3:
            return UIColor(red: 0.6902, green: 0.851, blue: 0.5451, alpha: 1.0) /* #b0d98b */
        case 4:
            return UIColor(red: 0.9608, green: 0.7804, blue: 0.5647, alpha: 1.0) /* #f5c790 */
        case 5:
            return UIColor(red: 0.9529, green: 0.5686, blue: 0.5098, alpha: 1.0) /* #f39182 */
        case 6:
            return UIColor(red: 0.6824, green: 0.4, blue: 1, alpha: 1.0) /* #ae66ff */
        case 7:
            return UIColor(red: 0.549, green: 0.6118, blue: 0.9686, alpha: 1.0) /* #8c9cf7 */
        case 8:
            return UIColor(red: 0.7608, green: 0.7569, blue: 0.7412, alpha: 1.0) /* #c2c1bd */
        case 9:
            return UIColor(red: 0.9608, green: 0.7373, blue: 0.3137, alpha: 1.0) /* #f5bc50 */
        case 10:
            return UIColor(red: 0.4431, green: 0.2784, blue: 0.6235, alpha: 1.0) /* #71479f */
        default:
            return UIColor(red: 0.5255, green: 0.8078, blue: 0.7569, alpha: 1.0) /* #86cec1 */

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

