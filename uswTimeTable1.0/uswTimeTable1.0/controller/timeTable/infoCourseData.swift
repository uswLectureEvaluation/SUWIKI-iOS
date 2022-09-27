//
//  infoCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/02/03.
//

import UIKit
import RealmSwift
import Elliotable
import DropDown

class infoCourseData: UIViewController{

    let realm = try! Realm()
    
    @IBOutlet weak var classificationTxt: UILabel!
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
    
    
    var beforeTimeString = ""
    var beforeTimeInt = 0
    
    
    var deleteIndex = 0
    
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
    var getCourseDay: Int = 0
    
    var getStartTimeArray = [Int]()
    var getEndTimeArray = [Int]()
    var getCourseDayArray = [Int]()
    
    var nowStartTimeArray = [Int]()
    var nowEndTimeArray = [Int]()
    var nowCourseDay = [Int]()

    
    var checkGetStartTime = 0
    var checkGetEndTime = 0
    
    var checkNowStartTime = 0
    var checkNowEndTime = 0
    
    
    var setNum = 0 // 시간표 중복을 확인시켜주는 장치
    var checkAdjust = 0 // 시간표 수정을 확인하는 장치
    
    override func viewDidLoad() {

        print(checkTimeTable)
        print("deleteIndex\(deleteIndex)")
        print("checkAdjust\(checkAdjust)")
        print(getCourseDayArray)
        
        
        navigationBarHidden()

        super.viewDidLoad()
        showCourseData()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        readADData()
        print("viewwill")
        print(roomNameData)
        showCourseData()

        
        navigationBarHidden()
        navigationBackSwipeMotion()

        super.viewDidLoad()
    }
    
    
    
    

    @IBAction func adjustBtn(_ sender: Any) {
        if varietyDay.count == 0{
            
            guard let adVC =  self.storyboard?.instantiateViewController(withIdentifier: "adVC") as? adjustCourseData else {return}
            // 불러오는 함수. identifier는 뷰컨트롤러의 storyboard ID.
            adVC.roomNameData = roomNameData
            adVC.classificationData = classificationData
            adVC.numData = numData
            adVC.professorData = professorData
            adVC.courseDayData = courseDayData
            adVC.courseNameData = courseNameData
            adVC.startTimeData = startTimeData
            adVC.endTimeData = endTimeData
            adVC.modalPresentationStyle = .fullScreen
            self.present(adVC, animated: true, completion: nil)

            
            
           
            
            
        } else {
            showAlert(title: "여러수업은 수정할 수 없어요!")
        }
        // 수업이 하나인 경우에만, 수정이 가능하도록
        // showTimeTable에서 넘어온 데이터의 경우 checkAdjust == 1 이 되기 때문에, DB 삭제해주는 로직을 addBtn에서 생성 else 평소대로 진행
        // 팝업으로 띄우게
        // 만약 수정버튼을 showtimetable에서 누른다면 리스트 먼저 삭제시킴 --> DB에는 데이터 존재하기 때문에.
        // 만약 수정 완료시킨다 --> 기존 데이터 != 수정 데이터 해서 수정 된거 확인하고, 기존 데이터 DB에 있을시 확인하는 로직으로 showTimeTable -> 뭐 이런식으로 하면 될듯
        // courseDay를 변경할 경우가 있나..? --> x로 하자.
        // changeTimeToInt로 해주어야 할듯.
        // "\(x.text):30" "\(y.text):20"
        
    }
    
    func readADData(){
        let AD = UIApplication.shared.delegate as? AppDelegate
        
        if let roomName = AD?.roomName{
            roomNameData = roomName
        }
        if let startTime = AD?.startTime{
            startTimeData = startTime
        }
        if let endTime = AD?.endTime{
            endTimeData = endTime
        }
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        let listVC = self.storyboard?.instantiateViewController(withIdentifier: "listVC") as! listCourseData
        self.navigationController?.pushViewController(listVC, animated: true)
        
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        //
        // 시간표 충돌 확인
        
        let deleteDB = realm.objects(userDB.self).filter("timetableName == %s", checkTimeTable)
        print(deleteDB)
        
        if checkAdjust == 1{ // 해당 부분 로직 필요
            
            removeAllArray()
            checkDate() // 1차적인 시간표 들어올 시
            changeTimeToInt() // 형변환(기존 시간표와의 비교 위함)
            checkCoursePlaceTwo() // 두가지 수업 들어올 시
            checkCourseHaveSpace() // 두가지 수업에 공백 있을 시
            userCourseDay() // 가지고 있는 수업 데이터 불러오기(중복확인 위함)
 
            if getStartTimeArray.count == 1{
                print(getStartTimeArray)
                print(getEndTimeArray)
                for userData in deleteDB{
                    try! realm.write{
                        realm.delete(userData.userCourseData[deleteIndex])
                    }
                }
            } else if getStartTimeArray.count > 1{
                print(getStartTimeArray)
                print(getEndTimeArray)
                var deleteGetIndex = getStartTimeArray.firstIndex(of: beforeTimeInt) ?? 0
                getStartTimeArray.remove(at: deleteGetIndex)
                getEndTimeArray.remove(at: deleteGetIndex)
                checkTimeCrash()
                
                print(getStartTimeArray)
                print(getEndTimeArray)
                if setNum == 1{
                    showAlert(title: "시간표가 중복되었어요!")
                } else {
                    for userData in deleteDB{
                        try! realm.write{
                            realm.delete(userData.userCourseData[deleteIndex])
                        }
                    }
                }
            }
            
            
        } else {
            removeAllArray()
            checkDate() // 1차적인 시간표 들어올 시
            changeTimeToInt() // 형변환(기존 시간표와의 비교 위함)
            checkCoursePlaceTwo() // 두가지 수업 들어올 시
            checkCourseHaveSpace() // 두가지 수업에 공백 있을 시
            userCourseDay() // 가지고 있는 수업 데이터 불러오기(중복확인 위함)
            checkTimeCrash()
        }
        
        if changeDay == 7 || varietyDay.contains(7) || changeDay == 0 || varietyDay.contains(0) { // 시간표 토요일 (이러닝 같은 수업)
            showAlert(title: "이러닝은 추가할 수 없어요!")
            
        } else if setNum == 1 { // 시간표 중복
            showAlert(title: "시간표가 중복되었어요!")
            
        } else { // 시간표 중복 로직에 안걸렸을 때
            if varietyDay.count > 1{ // checkCoursePlaceTwo()의 조건을 만족하면 삽입
                addVarietyCourse()
                
            } else if setNum == 1 { // 중복되는 시간표가 있다. --> 나중에 여러가지의 수업을 동시에 넣어야 하는 수업일 때 판단하는 로직 필요
                showAlert(title: "시간표가 중복되었어요!")
                
            } else if varietyDay.count == 0 {
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
        if nowStartTimeArray.count == 0 {
            let userDB = realm.objects(userDB.self).filter("timetableName == %s", checkTimeTable)
            for userData in userDB{
                for i in 0..<userData.userCourseData.count{ // getCourseDay == newcourseday 동일조건시 비교 인덱스로 확인
                    if userData.userCourseData[i].courseDay == changeDay {
                        getStartTime = userData.userCourseData[i].startTime
                        getEndTime = userData.userCourseData[i].endTime
                        changeTimeToInt()
                        getStartTimeArray.append(checkGetStartTime)
                        getEndTimeArray.append(checkGetEndTime)
                    }
                }
            }
            print("read0")
        } else if nowStartTimeArray.count == 2{
            if varietyDay[0] == varietyDay[1]{
                readCourse1()
                print("read1")
            } else {
                readCourse2()
                print("read2")
            }
        } else if nowStartTimeArray.count == 3{
            readCoruse3()
        }
        // 변경된 string -> Int 후에 nowStartTimeArray에 삽입
    }
    
    func readCourse1() { // 물리학 및 실험
        let userDB = realm.objects(userDB.self).filter("timetableName == %s", checkTimeTable)
        for userData in userDB{
            for i in 0..<userData.userCourseData.count{
                if userData.userCourseData[i].courseDay == varietyDay[0] {
                    print("readCourse1")
                    getStartTime = userData.userCourseData[i].startTime
                    getEndTime = userData.userCourseData[i].endTime
                    changeTimeToInt()
                    getStartTimeArray.append(checkGetStartTime)
                    getEndTimeArray.append(checkGetEndTime)
                }
            }
        }
    }
    
    func readCourse2() { // 관현악
        let userDB = realm.objects(userDB.self).filter("timetableName == %s", checkTimeTable)
            for userData in userDB{
                for i in 0..<userData.userCourseData.count{
                    for j in 0...1{
                        print("check \(varietyDay[j])")
                        if userData.userCourseData[i].courseDay == varietyDay[j] {
                            getStartTime = userData.userCourseData[i].startTime
                            getEndTime = userData.userCourseData[i].endTime
                            getCourseDay = userData.userCourseData[i].courseDay
                            changeTimeToInt()
                            print(getCourseDay)
                            getCourseDayArray.append(getCourseDay)
                            getStartTimeArray.append(checkGetStartTime)
                            getEndTimeArray.append(checkGetEndTime)
                            
                    }
                }
            }
        }
    }
    
    func readCoruse3() { // 관현악합주 3
        let userDB = realm.objects(userDB.self).filter("timetableName == %s", checkTimeTable)
        for userData in userDB{
            for i in 0..<userData.userCourseData.count{
                for j in 0...2{
                    if userData.userCourseData[i].courseDay == varietyDay[j] {
                        getStartTime = userData.userCourseData[i].startTime
                        getEndTime = userData.userCourseData[i].endTime
                        getCourseDay = userData.userCourseData[i].courseDay
                        changeTimeToInt()
                        print(getCourseDay)
                        getCourseDayArray.append(getCourseDay)
                        getStartTimeArray.append(checkGetStartTime)
                        getEndTimeArray.append(checkGetEndTime)
                        
                    }
                }
            }
        }
    }
    
    func checkTimeCrash() { // 일반적인 시간표인 경우에 중복을 확인해주는 함수
        setNum = 0 
        if nowStartTimeArray.count == 0{
            if getStartTimeArray.count == 0{
                setNum = 0
                print("Case0")
                
            } else if getStartTimeArray.count == 1{
                if getStartTimeArray[0] < checkNowStartTime && getEndTimeArray[0] > checkNowStartTime{ // 추가할 시간표의 시작시간이 존재하는 시간표의 사이에 있다.
                    setNum = 1
                } else if getStartTimeArray[0] < checkNowEndTime && getEndTimeArray[0] > checkNowEndTime{ // 추가할 시간표 끝 시간이 존재 시간표 사이에 있다
                    setNum = 1
                } else if getStartTimeArray[0] == checkNowStartTime || getEndTimeArray[0] == checkNowEndTime {
                    setNum = 1
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
                    } else if getStartTimeArray[i] == checkNowStartTime || getEndTimeArray[i] == checkNowEndTime { // a or b 로 해줘야 함.
                        setNum = 1
                        break
                    }
                }
                print("Case2")

            }
        } else if nowStartTimeArray.count == 2{
            if varietyDay[0] == varietyDay[1]{ // 물리학 및 실험
                print("물리학")
                for i in 0..<getStartTimeArray.count{
                    for j in 0..<nowStartTimeArray.count{
                        if getStartTimeArray[i] < nowStartTimeArray[j] && getEndTimeArray[i] > nowStartTimeArray[j]{ // 추가할 시간표의 시작시간이 존재하는 시간표의 사이에 있다.
                            setNum = 1
                            break
                        } else if getStartTimeArray[i] < nowEndTimeArray[j] && getEndTimeArray[i] > nowEndTimeArray[j]{ // 추가할 시간표 끝 시간이 존재 시간표 사이에 있다
                            setNum = 1
                            break
                        } else if getStartTimeArray[i] == nowStartTimeArray[j] || getEndTimeArray[i] == nowEndTimeArray[j] {
                            setNum = 1
                            print("들어가야하는곳")
                            break
                        }
                    }
                    if setNum == 1 {
                        break
                    }
                }
                
                
            }
            
            else if varietyDay[0] != varietyDay[1] { // 관현악
                for i in 0..<getStartTimeArray.count{
                    print("관현악")
                    if getCourseDayArray.count == 0{
                        setNum = 0
                    } else if varietyDay[0] == getCourseDayArray[i]{
                        if getStartTimeArray[i] < nowStartTimeArray[0] && getEndTimeArray[i] > nowStartTimeArray[0] {
                            setNum = 1
                            break
                        } else if getStartTimeArray[i] < nowEndTimeArray[0] && getEndTimeArray[i] > nowEndTimeArray[0]{
                            setNum = 1
                            break
                        } else if getStartTimeArray[i] == nowStartTimeArray[0] || getEndTimeArray[i] == nowEndTimeArray[0] {
                            setNum = 1
                            break
                        }
                
                    } else if varietyDay[1] == getCourseDayArray[i]{
                        if getStartTimeArray[i] < nowStartTimeArray[1] && getEndTimeArray[i] > nowStartTimeArray[1] {
                            setNum = 1
                            break
                        } else if getStartTimeArray[i] < nowEndTimeArray[1] && getEndTimeArray[i] > nowEndTimeArray[1]{
                            setNum = 1
                            break
                        } else if getStartTimeArray[i] == nowStartTimeArray[1] || getEndTimeArray[i] == nowEndTimeArray[1] {
                            setNum = 1
                            break
                        }
                    }
                }
            }
                
        } else if nowStartTimeArray.count == 3{
            print("nowstarttime3")      // 월 5,6 화 5,6 수 5,6 같은 경우
            for i in 0..<getCourseDayArray.count{
                if getCourseDayArray.count == 0{
                    setNum = 0
                    
                } else if varietyDay[0] == getCourseDayArray[i]{
                    if getStartTimeArray[i] < nowStartTimeArray[0] && getEndTimeArray[i] > nowStartTimeArray[0] {
                        setNum = 1
                        break
                    } else if getStartTimeArray[i] < nowEndTimeArray[0] && getEndTimeArray[i] > nowEndTimeArray[0]{
                        setNum = 1
                        break
                    } else if getStartTimeArray[i] == nowStartTimeArray[0] || getEndTimeArray[i] == nowEndTimeArray[0] {
                        setNum = 1
                        break
                    }
                    
                } else if varietyDay[1] == getCourseDayArray[i]{
                    if getStartTimeArray[i] < nowStartTimeArray[1] && getEndTimeArray[i] > nowStartTimeArray[1] {
                        setNum = 1
                        break
                    } else if getStartTimeArray[i] < nowEndTimeArray[1] && getEndTimeArray[i] > nowEndTimeArray[1]{
                        setNum = 1
                        break
                    } else if getStartTimeArray[i] == nowStartTimeArray[1] || getEndTimeArray[i] == nowEndTimeArray[1] {
                        setNum = 1
                        break
                    }
                    
                } else if varietyDay[2] == getCourseDayArray[i]{
                    if getStartTimeArray[i] < nowStartTimeArray[2] && getEndTimeArray[i] > nowStartTimeArray[2] {
                        setNum = 1
                        break
                    } else if getStartTimeArray[i] < nowEndTimeArray[2] && getEndTimeArray[i] > nowEndTimeArray[2]{
                        setNum = 1
                        break
                    } else if getStartTimeArray[i] == nowStartTimeArray[2] || getEndTimeArray[i] == nowEndTimeArray[2] {
                        setNum = 1
                        break
                        
                    }
                }
            }
        }
    }


    func checkCourseHaveSpace(){ // 괄호 안에 공백있는지 판별

        let checkRoomName: String = roomNameData
        let splitRoomName = checkRoomName.components(separatedBy: "(") // roomName & time 쪼갬 [0] = roomName, [1] = time
        if splitRoomName.count != 1{
            let splitTime = splitRoomName[1].components(separatedBy: " ") // 월1,2 화3,4 --> "월1,2","화1,2"로 쪼개짐
            if splitTime.count > 1{

                if splitTime.count == 2{ // 수업이 두개다! 월1,2 화1,2 의 형태
                    
                    let firstTime = splitTime[0].components(separatedBy: ",") // 여러가지 시간 중 0번째에 있는 시간을 뜻함 --> 월1,2 화3,4 라면 월 1,2
                    let firstCourseDay = firstTime[0].first  ?? "토" // 요일이 저장!

                    print(splitTime[1].components(separatedBy: ","))
                    let secondTime = splitTime[1].components(separatedBy: ",")
                    let secondCourseDay = secondTime[0].first ?? "토"
                     
                    // 인덱스로 해보자..
                    changeDayToInt(checkDay: firstCourseDay)
                    changeDayToInt(checkDay: secondCourseDay)
                    
                    let firstStartTime = firstTime[0].dropFirst() // startTime
                    
                    changePeriodToStartTime(changePeriod: String(firstStartTime))

                    
                    if firstTime.count == 1{ // 1교시의 수업 시작 종료시간 동일
                        let firstEndTime = firstTime[0].dropFirst() // 시작교시, 종료교시 동일^^
                        changePeriodToEndTime(changePeriod: String(firstEndTime))


                    } else if firstTime.count == 2{ // 2교시의 수업, 시작 종료시간 상이
                        let firstEndTime = firstTime[1]
                        changePeriodToEndTime(changePeriod: String(firstEndTime))
                        
                    } else if firstTime.count == 3{ // 3교시의 수업
                        let firstEndTime = firstTime[2]
                        changePeriodToEndTime(changePeriod: String(firstEndTime))

                    }
                    
                    varietyRoomName.append(splitRoomName[0])
                    
                    let secondStartTime = secondTime[0].dropFirst()
                    if secondTime.count == 1{
                        let startTime = secondStartTime.dropLast()
                        changePeriodToStartTime(changePeriod: String(startTime))
                    }// secondStartTime
                    
                    changePeriodToStartTime(changePeriod: String(secondStartTime))
                    
                    if secondTime.count == 1{
                        let Endtime = secondTime[0].dropFirst()
                        let secondEndTime = Endtime.dropLast()
                        changePeriodToEndTime(changePeriod: String(secondEndTime))


                    } else if secondTime.count == 2{
                        let secondEndTime = secondTime[1].dropLast()
                        changePeriodToEndTime(changePeriod: String(secondEndTime))


                    } else if secondTime.count == 3{
                        let secondEndTime = secondTime[2].dropLast()
                        changePeriodToEndTime(changePeriod: String(secondEndTime))
                    } else if secondTime.count == 4{
                        let secondEndTime = secondTime[3].dropLast()
                        changePeriodToEndTime(changePeriod: String(secondEndTime))
                    } else if secondTime.count == 5{
                        let secondEndTime = secondTime[4].dropLast()
                        changePeriodToEndTime(changePeriod: String(secondEndTime))
                    } else if secondTime.count == 6{
                        let secondEndTime = secondTime[5].dropLast()
                        changePeriodToEndTime(changePeriod: String(secondEndTime))
                    }
                    varietyRoomName.append(splitRoomName[0])

                    
                } else if splitTime.count == 3 { // count 2개가 끝.
                    
                    let firstTime = splitTime[0].components(separatedBy: ",") // 여러가지 시간 중 0번째에 있는 시간을 뜻함 --> 월1,2 화3,4 라면 월 1,2
                    let firstCourseDay = firstTime[0].first ?? "토" // 요일이 저장!
                    let secondTime = splitTime[1].components(separatedBy: ",")
                    let secondCourseDay = secondTime[0].first ?? "토"
                    let thirdTime = splitTime[2].components(separatedBy: ",")
                    let thirdCourseDay = thirdTime[0].first ?? "토"
                    
                    let firstStartTime = firstTime[0].dropFirst()
                    changePeriodToStartTime(changePeriod: String(firstStartTime))

                    if firstTime.count == 1 {
                        let firstEndTime = firstTime[0].dropFirst()
                        changePeriodToEndTime(changePeriod: String(firstEndTime))
                    } else if firstTime.count == 2 {
                        let firstEndTime = firstTime[1]
                        changePeriodToEndTime(changePeriod: String(firstEndTime))
                    }
                    
                    varietyRoomName.append(splitRoomName[0])
                    

                    
                    let secondStartTime = secondTime[0].dropFirst()
                    changePeriodToStartTime(changePeriod: String(secondStartTime))

                    if secondTime.count == 1 {
                        let secondEndTime = secondTime[0].dropFirst()
                        changePeriodToEndTime(changePeriod: String(secondEndTime))
                    } else if secondTime.count == 2{
                        let secondEndTime = secondTime[1]
                        changePeriodToEndTime(changePeriod: String(secondEndTime))
                    }
                    
                    varietyRoomName.append(splitRoomName[0])

                    
                    let thirdStartTime = thirdTime[0].dropFirst()
                    changePeriodToStartTime(changePeriod: String(thirdStartTime))

                    if thirdTime.count == 1 {
                        let thirdEndTime = thirdTime[0].dropLast()
                        changePeriodToEndTime(changePeriod: String(thirdEndTime))
                    } else if thirdTime.count == 2 {
                        let thirdEndTime = thirdTime[1].dropLast()
                        changePeriodToEndTime(changePeriod: String(thirdEndTime))
                    }
                    
                    varietyRoomName.append(splitRoomName[0])

                    
                    changeDayToInt(checkDay: firstCourseDay)
                    changeDayToInt(checkDay: secondCourseDay)
                    changeDayToInt(checkDay: thirdCourseDay)
                    
                    
                    
                    
                }
               
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
            let firstStartTime = firstTime[0].dropFirst() // 마지막 글자 화1 -> 1
            let firstEndTime = firstTime[1] // ,4로 쪼개졌기에 4가 출ㄹ력
            varietyRoomName.append(splitFirstRoomName[0])
            changeDayToInt(checkDay: firstRoomCourseDay)
            changePeriodToStartTime(changePeriod: String(firstStartTime))
            changePeriodToEndTime(changePeriod: String(firstEndTime))
            
            let splitSecondRoomName = splitRoomName[1].components(separatedBy: "(")  // secondRoom[0] == roomName, [1] == 화 1,2
            
            let secondRoomCourseDay = splitSecondRoomName[1].first ?? "토"
            let secondTime = splitSecondRoomName[1].components(separatedBy: ",")
            if secondTime.count != 3{
                let secondStartTime = secondTime[0].dropFirst()
                let secondEndTime = secondTime[1].dropLast()
                changePeriodToStartTime(changePeriod: String(secondStartTime))
                changePeriodToEndTime(changePeriod: String(secondEndTime))
            } else if secondTime.count == 3 {
                let secondStartTime = secondTime[0].dropFirst()
                let secondEndTime = secondTime[2].dropLast()
                changePeriodToStartTime(changePeriod: String(secondStartTime))
                changePeriodToEndTime(changePeriod: String(secondEndTime))
            }
            print(secondTime)
            changeDayToInt(checkDay: secondRoomCourseDay)
            
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
                        courseDB.courseId = "\(Int.random(in: 0...50000))"
                        courseDB.courseName = courseNameData
                        courseDB.roomName = varietyRoomName[i]
                        courseDB.courseDay = nowCourseDay[i]
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
    
    func writeCourseMyRealm(){ // 시간표 삽입
        realm.beginWrite()
        let readUserDB = realm.objects(userDB.self)
        let courseData = UserCourse()
        let courseCount = realm.objects(UserCourse.self).count
        for userData in readUserDB{
            if userData.timetableName == checkTimeTable{
                courseData.courseId = "\(Int.random(in: 0...50000))"
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
    
    
    
    func changeDayToInt(checkDay: Character){
        
        switch checkDay{
        case "월":
            varietyDay.append(1)
            nowCourseDay.append(1)
        case "화":
            varietyDay.append(2)
            nowCourseDay.append(2)

        case "수":
            varietyDay.append(3)
            nowCourseDay.append(3)

        case "목":
            varietyDay.append(4)
            nowCourseDay.append(4)

        case "금":
            varietyDay.append(5)
            nowCourseDay.append(5)

        default:
            varietyDay.append(7)
            nowCourseDay.append(7)

        }
        print(varietyDay)
        print(nowCourseDay)
    }
    
    
    func changePeriodToStartTime(changePeriod: String){
        switch changePeriod{
        case "1":
            varietyStartTime.append("9:30")
            nowStartTimeArray.append(930)
        case "2":
            varietyStartTime.append("10:30")
            nowStartTimeArray.append(1030)
        case "3":
            varietyStartTime.append("11:30")
            nowStartTimeArray.append(1130)
        case "4":
            varietyStartTime.append("12:30")
            nowStartTimeArray.append(1230)
        case "5":
            varietyStartTime.append("13:30")
            nowStartTimeArray.append(1330)
        case "6":
            varietyStartTime.append("14:30")
            nowStartTimeArray.append(1430)
        case "7":
            varietyStartTime.append("15:30")
            nowStartTimeArray.append(1530)
        case "8":
            varietyStartTime.append("16:30")
            nowStartTimeArray.append(1630)
        case "9":
            varietyStartTime.append("17:30")
            nowStartTimeArray.append(1730)
        case "10":
            varietyStartTime.append("18:30")
            nowStartTimeArray.append(1830)
        case "11":
            varietyStartTime.append("19:30")
            nowStartTimeArray.append(1930)
        case "12":
            varietyStartTime.append("20:30")
            nowStartTimeArray.append(2030)
        default:
            varietyStartTime.append("0")
        }
    }
    
    func changePeriodToEndTime(changePeriod: String){
        switch changePeriod{
        case "1":
            varietyEndTime.append("10:20")
            nowEndTimeArray.append(1020)
        case "2":
            varietyEndTime.append("11:20")
            nowEndTimeArray.append(1120)
        case "3":
            varietyEndTime.append("12:20")
            nowEndTimeArray.append(1220)
        case "4":
            varietyEndTime.append("13:20")
            nowEndTimeArray.append(1320)
        case "5":
            varietyEndTime.append("14:20")
            nowEndTimeArray.append(1420)
        case "6":
            varietyEndTime.append("15:20")
            nowEndTimeArray.append(1520)
        case "7":
            varietyEndTime.append("16:20")
            nowEndTimeArray.append(1620)
        case "8":
            varietyEndTime.append("17:20")
            nowEndTimeArray.append(1720)
        case "9":
            varietyEndTime.append("18:20")
            nowEndTimeArray.append(1820)
        case "10":
            varietyEndTime.append("19:20")
            nowEndTimeArray.append(1920)
        case "11":
            varietyEndTime.append("20:20")
            nowEndTimeArray.append(2020)
        case "12":
            varietyEndTime.append("21:20")
            nowEndTimeArray.append(2120)
        case "13":
            varietyEndTime.append("22:20")
            nowEndTimeArray.append(2220)
        case "14":
            varietyEndTime.append("23:20")
            nowEndTimeArray.append(2320)
        case "15":
            varietyEndTime.append("24:00")
            nowEndTimeArray.append(2400)

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
    
    func removeAllArray(){
        varietyStartTime.removeAll()
        varietyEndTime.removeAll()
        varietyRoomName.removeAll()
        varietyDay.removeAll()
        getStartTimeArray.removeAll()
        getEndTimeArray.removeAll()
        getCourseDayArray.removeAll()
        nowCourseDay.removeAll()
        nowStartTimeArray.removeAll()
        nowEndTimeArray.removeAll()
        
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "확인 버튼을 눌러주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true,completion: nil)
    }
    
    func showCourseData(){ // 시간표 정보 보여주기
        courseNameTxt.text = courseNameData
        roomNameTxt.text = roomNameData
        professorTxt.text = professorData
        classificationTxt.text = classificationData
        myView.layer.cornerRadius = 12.0
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    

    
    func changeTimeToInt(){
        switch startTimeData{
        case "09:30": checkNowStartTime = 930
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
        
        switch beforeTimeString{
        case "9:30": beforeTimeInt = 930
        case "10:30": beforeTimeInt = 1030
        case "11:30": beforeTimeInt = 1130
        case "12:30": beforeTimeInt = 1230
        case "13:30": beforeTimeInt = 1330
        case "14:30": beforeTimeInt = 1430
        case "15:30": beforeTimeInt = 1530
        case "16:30": beforeTimeInt = 1630
        case "17:30": beforeTimeInt = 1730
        case "18:30": beforeTimeInt = 1830
        case "19:30": beforeTimeInt = 1930
        case "20:30": beforeTimeInt = 2030
        case "21:30": beforeTimeInt = 2130
        default:
            beforeTimeInt = 0
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
    


