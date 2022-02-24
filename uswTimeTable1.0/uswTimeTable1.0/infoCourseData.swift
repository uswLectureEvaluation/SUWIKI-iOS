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
    
    // listCourseData에서 넘어오는 데이터들
    var courseIdData: String = ""
    var courseNameData = ""
    var roomNameData = ""
    var professorData = ""
    var courseDayData = ""
    var numData = 0
    var classificationData = ""
    var startTimeData = ""
    var endTimeData = ""
    
   // 현재 시간표 확인하기위한 장치
    var checkTimeTable: String = UserDefaults.standard.string(forKey: "name") ?? ""
    
    // courseDay String -> Int
    var changeDay = 0
    
    // 다양한 시간표를 넣어야하는ㄱ ㅕㅇ우
    var varietyDay = [Int]()
    var varietyStartTime = [String]()
    var varietyEndTime = [String]()
    var varietyRoomName = [String]()
    
    
    // 시간표 중복 확인 위한 변수들
    var getStartTime = ""
    var getEndTime = ""
    
    var getStartTimeArray = [Int]()
    var getEndTimeArray = [Int]()
    
    var checkGetStartTime = 0
    var checkGetEndTime = 0
    
    var checkNowStartTime = 0
    var checkNowEndTime = 0
    
    var setNum = 0 // 시간표 중복을 확인시켜주는 장치
    
    override func viewDidLoad() {
        
        checkDate() // courseDay String -> Int
        
        // 시간표 충돌 확인
        changeTimeToInt()
        userCourseDay()
        checkTimeCrash()
        getStartTimeArray.removeAll()
        getEndTimeArray.removeAll()
        
        resetVarietyArray()
        // 두가지 수업 들어올 시
        checkCoursePlaceTwo()
        // 하나의 장소, 여러가지 수업
        checkCourseHaveSpace()
        
        navigationBarHidden()
        navigationBackSwipeMotion()
        print(roomNameData)
        print(varietyDay)
        print(varietyRoomName)
        print(varietyStartTime)
        print(varietyEndTime)
        super.viewDidLoad()
        showCourseData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        checkDate() // courseDay String -> Int
        
        getStartTimeArray.removeAll()
        getEndTimeArray.removeAll()
        
        resetVarietyArray()
        
        // 시간표 충돌 확인
        changeTimeToInt()
        userCourseDay()
        checkTimeCrash()
        
        // 두가지 수업 들어올 시
        checkCoursePlaceTwo()
        checkCourseHaveSpace()
        
        print(roomNameData)
        print(varietyDay)
        print(varietyRoomName)
        print(varietyStartTime)
        print(varietyEndTime)
        navigationBarHidden()
        navigationBackSwipeMotion()
        
        showCourseData()

    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        
        if changeDay == 7 || setNum == 1 {
            showAlert()
        } else {
            if varietyDay.count > 1{ // checkCoursePlaceTwo()의 조건을 만족하면 삽입
                addVarietyCourse()
                
                
            } else if setNum == 1 { // 중복되는 시간표가 있다. --> 나중에 여러가지의 수업을 동시에 넣어야 하는 수업일 때 판단하는 로직 필요
                showAlert()
                
            } else {
                writeCourseMyRealm()
            }
        }
    }
        


    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }

    func userCourseDay(){ // 시간표 중복 확인을 위해 읽어오는 함수
        // 같은 요일에 두가지 이상의 수업이 있을 경우 추가가 됨.
        let userDB = realm.objects(userDB.self)
        for userData in userDB{
            for i in 0..<userData.userCourseData.count{
                if userData.userCourseData[i].courseDay == changeDay {
                    getStartTime = userData.userCourseData[i].startTime
                    getEndTime = userData.userCourseData[i].endTime
                    changeTimeToInt()
                    getStartTimeArray.append(checkGetStartTime)
                    getEndTimeArray.append(checkGetEndTime)
                }
            }
        }
    }
    
    func checkTimeCrash() { // 일반적인 시간표인 경우에 중복을 확인해주는 함수
        
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

    func checkCourseHaveSpace(){ // 괄호 안에 공백있는지 판별

        let checkRoomName: String = roomNameData
        let splitRoomName = checkRoomName.components(separatedBy: "(") // roomName & time 쪼갬 [0] = roomName, [1] = time
        let splitTime = splitRoomName[1].components(separatedBy: " ") // 월1,2 화3,4 --> "월1,2","화1,2"로 쪼개짐
        
        if splitTime.count > 1{

            if splitTime.count == 2{ // 수업이 두개다! 월1,2 화1,2 의 형태
                
                let firstTime = splitTime[0].components(separatedBy: ",") // 여러가지 시간 중 0번째에 있는 시간을 뜻함 --> 월1,2 화3,4 라면 월 1,2
                let firstCourseDay = firstTime[0].first ?? "토" // 요일이 저장!
                let secondTime = splitTime[1].components(separatedBy: ",")
                let secondCourseDay = secondTime[0].first ?? "토"
                
                changeDayToInt(checkDay: firstCourseDay)
                changeDayToInt(checkDay: secondCourseDay)
                
                let firstStartTime = firstTime[0].last ?? "0"
                changePeriodToStartTime(changePeriod: firstStartTime)
                
                if firstTime.count == 1{ // 1교시의 수업 시작 종료시간 동일
                    let firstEndTime = firstTime[0].last ?? "0" // 시작교시, 종료교시 동일^^
                    changePeriodToEndTime(changePeriod: firstEndTime)

                } else if firstTime.count == 2{ // 2교시의 수업, 시작 종료시간 상이
                    let firstEndTime = firstTime[1].first ?? "0"
                    changePeriodToEndTime(changePeriod: firstEndTime)
                 
                } else if firstTime.count == 3{ // 3교시의 수업
                    let firstEndTime = firstTime[2].first ?? "0"
                    changePeriodToEndTime(changePeriod: firstEndTime)
                }
                
                varietyRoomName.append(splitRoomName[0])
                
                let secondStartTime = secondTime[0].last ?? "토"
                changePeriodToStartTime(changePeriod: secondStartTime)
                
                if secondTime.count == 1{
                    let secondEndTime = secondTime[0].last ?? "0"
                    changePeriodToEndTime(changePeriod: secondEndTime)
                } else if secondTime.count == 2{
                    let secondEndTime = secondTime[1].first ?? "0"
                    changePeriodToEndTime(changePeriod: secondEndTime)
                } else if secondTime.count == 3{
                    let secondEndTime = secondTime[2].first ?? "0"
                    changePeriodToEndTime(changePeriod: secondEndTime)
                } else if secondTime.count == 4{
                    let secondEndTime = secondTime[3].first ?? "0"
                    changePeriodToEndTime(changePeriod: secondEndTime)
                }
                
                varietyRoomName.append(splitRoomName[0])

                
            } else if splitTime.count == 3 { // count 2개가 끝.
                
                let firstTime = splitTime[0].components(separatedBy: ",") // 여러가지 시간 중 0번째에 있는 시간을 뜻함 --> 월1,2 화3,4 라면 월 1,2
                let firstCourseDay = firstTime[0].first ?? "토" // 요일이 저장!
                let secondTime = splitTime[1].components(separatedBy: ",")
                let secondCourseDay = secondTime[0].first ?? "토"
                let thirdTime = splitTime[2].components(separatedBy: ",")
                let thirdCourseDay = thirdTime[0].first ?? "토"
                
                let firstStartTime = firstTime[0].last ?? "0"
                changePeriodToStartTime(changePeriod: firstStartTime)

                if firstTime.count == 1 {
                    let firstEndTime = firstTime[0].last ?? "0"
                    changePeriodToEndTime(changePeriod: firstEndTime)
                } else if firstTime.count == 2 {
                    let firstEndTime = firstTime[1].first ?? "0"
                    changePeriodToEndTime(changePeriod: firstEndTime)
                }
                varietyRoomName.append(splitRoomName[0])

                
                let secondStartTime = secondTime[0].last ?? "0"
                changePeriodToStartTime(changePeriod: secondStartTime)

                if secondTime.count == 1 {
                    let secondEndTime = secondTime[0].last ?? "0"
                    changePeriodToEndTime(changePeriod: secondEndTime)
                } else if secondTime.count == 2{
                    let secondEndTime = secondTime[1].first ?? "0"
                    changePeriodToEndTime(changePeriod: secondEndTime)
                }
                varietyRoomName.append(splitRoomName[0])

                
                let thirdStartTime = thirdTime[0].last ?? "0"
                changePeriodToStartTime(changePeriod: thirdStartTime)

                if thirdTime.count == 1 {
                    let thirdEndTime = thirdTime[0].last ?? "0"
                    changePeriodToEndTime(changePeriod: thirdEndTime)
                } else if thirdTime.count == 2 {
                    let thirdEndTime = thirdTime[1].first ?? "0"
                    changePeriodToEndTime(changePeriod: thirdEndTime)
                }
                varietyRoomName.append(splitRoomName[0])

                
                changeDayToInt(checkDay: firstCourseDay)
                changeDayToInt(checkDay: secondCourseDay)
                changeDayToInt(checkDay: thirdCourseDay)
                
                
                
                
                
            }

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

         
        }
    }
    
    func addVarietyCourse() {
        let readUserDB = realm.objects(userDB.self)
        for userData in readUserDB{
                if userData.timetableName == checkTimeTable{
                    for i in 0..<varietyDay.count{
                        let courseDB = UserCourse() // 이라ㅜㅁㄴ룸 무메ㅜ
                        let courseCount = realm.objects(UserCourse.self).count
                        realm.beginWrite()
                        courseDB.courseId = "A\(courseCount)"
                        courseDB.courseName = courseNameData
                        courseDB.roomName = varietyRoomName[i]
                        courseDB.courseDay = varietyDay[i]
                        courseDB.professor = professorData
                        courseDB.startTime = varietyStartTime[i]
                        courseDB.endTime = varietyEndTime[i]
                        courseDB.courseCount = courseCount
                        userData.userCourseData.append(courseDB)
                        realm.add(courseDB)
                        realm.add(userData)
                        try! realm.commitWrite()
                }
            }
        }
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
    

    
    func showAlert() {
        let alert = UIAlertController(title:"죄송해요..ㅠㅠ 추가할 수 없어요", message: "확인버튼을 눌러주시기 바랍니다", preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true,completion: nil)
    }
    
    func showCourseData(){ // 시간표 정보 보여주기
        courseNameTxt.text = courseNameData
        roomNameTxt.text = roomNameData
        professorTxt.text = professorData
        myView.layer.cornerRadius = 12.0
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func writeCourseMyRealm(){ // 시간표 삽입
        realm.beginWrite()
        let readUserDB = realm.objects(userDB.self)
        let courseData = UserCourse()
        var courseCount = realm.objects(UserCourse.self).count
        for userData in readUserDB{
            if userData.timetableName == checkTimeTable{
                courseData.courseId = "A\(courseCount)"
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
    
    func resetVarietyArray(){ // 다른 강의 누를 때 데이터 초기화 위함
        varietyDay.removeAll()
        varietyStartTime.removeAll()
        varietyEndTime.removeAll()
        varietyRoomName.removeAll()
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
    


