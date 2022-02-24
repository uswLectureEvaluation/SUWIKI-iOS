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
    var checkTimeTable: String = UserDefaults.standard.string(forKey: "name") ?? ""
    
    var changeDay = 0
    
    var varietyDay = [Int]()
    var varietyStartTime = [String]()
    var varietyEndTime = [String]()
    var varietyRoomName = [String]()
    
    
    var checkUserDay = [Int]()
    
    var getStartTime = ""
    var getEndTime = ""
    
    var getStartTimeArray = [Int]()
    var getEndTimeArray = [Int]()
    
    var checkGetStartTime = 0
    var checkGetEndTime = 0
    
    var checkNowStartTime = 0
    var checkNowEndTime = 0
    
    var setNum = 0
    
    

    
    
    override func viewDidLoad() {
        
        checkDate()
        changeTimeToInt()
        userCourseDay()
        checkTimeCrash()
        
        checkCoursePlaceTwo()
        
        
        
        navigationBarHidden()
        navigationBackSwipeMotion()
        
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
        
        if changeDay == 7 || setNum == 1 {
            let alert = UIAlertController(title:"죄송해요..ㅠㅠ 추가할 수 없어요",
                message: "확인버튼을 눌러주시기 바랍니다",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            present(alert,animated: true,completion: nil)

        } else {
            if varietyDay.count > 1{
                addVarietyCourse()
                print("variety")
            }
            
            else if setNum == 1 {
                let alert = UIAlertController(title:"죄송해요..ㅠㅠ 추가할 수 없어요", message: "확인버튼을 눌러주시기 바랍니다", preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                present(alert,animated: true,completion: nil)
                
                // 여기서 다른 함수로 조건을 달아줘야 할듯
            } else {
                realm.beginWrite()
                let readUserDB = realm.objects(userDB.self)
                let courseData = UserCourse()
                var courseCount = realm.objects(UserCourse.self).count
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
                        print("ee")
                    }
                }
                try! realm.commitWrite()
                let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
                self.navigationController?.pushViewController(showVC, animated: true)
                }
            }
        }
        


    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }

    func userCourseDay(){ // 월1,2,3 같은 시간표의 경우
        getStartTimeArray.removeAll()
        // 같은 요일에 두가지 이상의 수업이 있을 경우 추가가 됨.
        let userDB = realm.objects(userDB.self)
        for userData in userDB{
            for i in 0..<userData.userCourseData.count{
                if userData.userCourseData[i].courseDay == changeDay {
                    print(userData.userCourseData[i].courseName)
                    getStartTime = userData.userCourseData[i].startTime
                    getEndTime = userData.userCourseData[i].endTime
                    changeTimeToInt()
                    getStartTimeArray.append(checkGetStartTime)
                    getEndTimeArray.append(checkGetEndTime)
                    print(getStartTimeArray)
                }
            }
        }
    }
    
    func checkTimeCrash() { // 그냥 시간표를 추가해주는 경우 ex 월 1,2,3
        if getStartTimeArray.count == 0{
            setNum = 0
            print("Case0")
            
        } else if getStartTimeArray.count == 1{
            if checkGetStartTime < checkNowStartTime && checkGetEndTime > checkNowStartTime{ // 추가할 시간표의 시작시간이 존재하는 시간표의 사이에 있다.
                setNum = 1
            } else if checkGetStartTime < checkNowEndTime && checkGetEndTime > checkNowEndTime{ // 추가할 시간표 끝 시간이 존재 시간표 사이에 있다
                setNum = 1
            } else if checkGetStartTime == checkNowStartTime && checkGetEndTime == checkNowEndTime {
                setNum = 1
            } else {
                setNum = 0
            }
            print("Case1")
            
        } else if getStartTimeArray.count > 1 {
            for i in 0..<getStartTimeArray.count{
                if getStartTimeArray[i] < checkNowStartTime && getEndTimeArray[i] > checkNowStartTime{ // 추가할 시간표의 시작시간이 존재하는 시간표의 사이에 있다.
                    setNum = 1
                    break
                } else if getStartTimeArray[i] < checkNowEndTime && getEndTimeArray[i] > checkNowEndTime{ // 추가할 시간표 끝 시간이 존재 시간표 사이에 있다
                    setNum = 1
                    break
                } else if getStartTimeArray[i] == checkNowStartTime && getEndTimeArray[i] == checkNowEndTime {
                    setNum = 1
                    break
                } else {
                    setNum = 0
                }
            }
            print("Case2")

        }
    }

    func checkCoursePlaceTwo() {
        let checkRoomName: String = roomNameData
        if checkRoomName.components(separatedBy: "),").count > 1 { // 장소가 두개인 경우 varietyDay는 1개이다.
            // 삭제해주는 과정 필요
            
            let splitRoomName = checkRoomName.components(separatedBy: "),")
            
            
            let splitFirstRoomName = splitRoomName[0].components(separatedBy: "(") // firstRoom[0] == roomName, [1] == 화 3,4
            let firstRoomCourseDay = splitFirstRoomName[1].first ?? "토" // 요일
            let firstTime = splitFirstRoomName[1].components(separatedBy: ",") // 시간
            let firstStartTime = firstTime[0].last ?? "0" // 마지막 글자 화1 -> 1
            let firstEndTime = firstTime[1].first ?? "0" // ,4로 쪼개졌기에 4가 출ㄹ력
            varietyRoomName.append(splitFirstRoomName[0])
            changeDayToInt(checkDay: firstRoomCourseDay)
            changePeriodToStartTime(changePeriod: firstStartTime)
            changePeriodToEndTime(changePeriod: firstEndTime)
            
            let splitSecondRoomName = splitRoomName[1].components(separatedBy: "(")  // secondRoom[0] == roomName, [1] == 화 1,2
            
            let secondRoomCourseDay = splitSecondRoomName[1].first ?? "토"
            let secondTime = splitSecondRoomName[1].components(separatedBy: ",")
            let secondStartTime = secondTime[0].last ?? "0"
            let secondEndTime = secondTime[1].first ?? "0"
            changeDayToInt(checkDay: secondRoomCourseDay)
            changePeriodToStartTime(changePeriod: secondStartTime)
            changePeriodToEndTime(changePeriod: secondEndTime)
            varietyRoomName.append(splitSecondRoomName[0])

            print(varietyRoomName)
            print(varietyDay)
            print(varietyStartTime)
            print(varietyEndTime)
            print(courseDayData)
        }
    }
    
    func addVarietyCourse() {
        realm.beginWrite()

        let readUserDB = realm.objects(userDB.self)
        let courseData = UserCourse()
        print(varietyDay.count)
        for i in 0..<varietyDay.count{
            for userData in readUserDB{
                if userData.timetableName == checkTimeTable{
                    courseData.courseId = "-"
                    courseData.courseName = courseNameData
                    courseData.roomName = varietyRoomName[i]
                    courseData.courseDay = varietyDay[i]
                    courseData.professor = professorData
                    courseData.startTime = varietyStartTime[i]
                    courseData.endTime = varietyEndTime[i]
                    courseData.courseCount = i
                    userData.userCourseData.append(courseData)
                    realm.add(courseData)
                    realm.add(userData)
                    print("\(i) 번째 삽입")
                    print("ee")
                }
            }

    }
        try! realm.commitWrite()

       let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
       self.navigationController?.pushViewController(showVC, animated: true)
        
    }
    
    
    
    func changeDayToInt(checkDay: Character){
        switch checkDay{
        case "월":
            varietyDay.append(1)
        case "화":
            varietyDay.append(2)
        case "수":
            varietyDay.append(3)
        case "목":
            varietyDay.append(4)
        case "금":
            varietyDay.append(5)
        default:
            varietyDay.append(7)
        }
    }
    
    
    func changePeriodToStartTime(changePeriod: Character){
        switch changePeriod{
        case "1":
            varietyStartTime.append("9:30")
        case "2":
            varietyStartTime.append("10:30")
        case "3":
            varietyStartTime.append("11:30")
        case "4":
            varietyStartTime.append("12:30")
        case "5":
            varietyStartTime.append("13:30")
        case "6":
            varietyStartTime.append("14:30")
        case "7":
            varietyStartTime.append("15:30")
        case "8":
            varietyStartTime.append("16:30")
        case "9":
            varietyStartTime.append("17:30")
        default:
            varietyStartTime.append("0")
        }
    }
    
    func changePeriodToEndTime(changePeriod: Character){
        switch changePeriod{
        case "1":
            varietyEndTime.append("10:20")
        case "2":
            varietyEndTime.append("11:20")
        case "3":
            varietyEndTime.append("12:20")
        case "4":
            varietyEndTime.append("13:20")
        case "5":
            varietyEndTime.append("14:20")
        case "6":
            varietyEndTime.append("15:20")
        case "7":
            varietyEndTime.append("16:20")
        case "8":
            varietyEndTime.append("17:20")
        case "9":
            varietyEndTime.append("18:20")
        default:
            varietyEndTime.append("0")
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
        case "temp":
            changeDay = 0
        default:
            changeDay = 7
        }
        
    }
    
    func changeTimeToInt(){
        switch startTimeData{
        case "9:30": checkNowStartTime = 930
        case "10:30": checkNowStartTime = 1030
        case "11:30": checkNowStartTime = 1130
        case "12:30": checkNowStartTime = 1230
        case "13:30": checkNowStartTime = 1330
        case "14:30": checkNowStartTime = 1430
        case "15:30": checkNowStartTime = 1530
        case "16:30": checkNowStartTime = 1630
        case "17:30": checkNowStartTime = 1730
        case "18:30": checkNowStartTime = 1830
        case "19:30": checkNowStartTime = 1930
        case "20:30": checkNowStartTime = 2030
        case "21:30": checkNowStartTime = 2130
        default:
            checkNowStartTime = 0
        }
        
        
        switch endTimeData{
        case "10:20": checkNowEndTime = 1020
        case "11:20": checkNowEndTime = 1120
        case "12:20": checkNowEndTime = 1220
        case "13:20": checkNowEndTime = 1320
        case "14:20": checkNowEndTime = 1420
        case "15:20": checkNowEndTime = 1520
        case "16:20": checkNowEndTime = 1620
        case "17:20": checkNowEndTime = 1720
        case "18:20": checkNowEndTime = 1820
        case "19:20": checkNowEndTime = 1920
        case "20:20": checkNowEndTime = 2020
        case "21:20": checkNowEndTime = 2120
        case "22:20": checkNowEndTime = 2220
            
        default:
            checkNowEndTime = 0
        }
        
        switch getStartTime{
        case "9:30": checkGetStartTime = 930
        case "10:30": checkGetStartTime = 1030
        case "11:30": checkGetStartTime = 1130
        case "12:30": checkGetStartTime = 1230
        case "13:30": checkGetStartTime = 1330
        case "14:30": checkGetStartTime = 1430
        case "15:30": checkGetStartTime = 1530
        case "16:30": checkGetStartTime = 1630
        case "17:30": checkGetStartTime = 1730
        case "18:30": checkGetStartTime = 1830
        case "19:30": checkGetStartTime = 1930
        case "20:30": checkGetStartTime = 2030
        case "21:30": checkGetStartTime = 2130
        default:
            checkGetStartTime = 0
        }
        
        
        switch getEndTime{
        case "10:20": checkGetEndTime = 1020
        case "11:20": checkGetEndTime = 1120
        case "12:20": checkGetEndTime = 1220
        case "13:20": checkGetEndTime = 1320
        case "14:20": checkGetEndTime = 1420
        case "15:20": checkGetEndTime = 1520
        case "16:20": checkGetEndTime = 1620
        case "17:20": checkGetEndTime = 1720
        case "18:20": checkGetEndTime = 1820
        case "19:20": checkGetEndTime = 1920
        case "20:20": checkGetEndTime = 2020
        case "21:20": checkGetEndTime = 2120
        case "22:20": checkGetEndTime = 2220
            
        default:
            checkGetEndTime = 0
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
    


