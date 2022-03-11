//
//  listCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/25.
//

import UIKit
import RealmSwift
import Realm
import DropDown

class listCourseData: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var numDropDown: UIView!
    @IBOutlet weak var majorDropDown: UIView!
    @IBOutlet weak var choiceNumDropDown: UILabel!

    @IBOutlet weak var choiceMajorDropDown: UILabel!
    
    
    var uswCourse: Array<Course> = []
    
    var courseData = [String]()
    let dropDown1 = DropDown()
    let numList = ["전체", "1", "2", "3", "4"] // 기존 수업 정보
    
    let dropDown2 = DropDown()
    let majorList = ["전체", "인문학부", "국어국문학", "외국어학부", "영어영문학", "프랑스어문학", "러시아어문학", "일어일문학", "중어중문학", "법·행정학부", "법학", "행정학", "미디어커뮤니케이션학과", "행정학과(야)", "소방행정학과(야)", "경영학부", "경영", "글로벌비즈니스", "회계", "경제학부", "경제금융", "국제개발협력", "호텔관광학부",  "호텔경영", "외식경영", "관광경영", "바이오화학산업학부", "바이오싸이언스", "바이오공학 및 마케팅", "융합화학산업", "건설환경에너지공학부", "건설환경공학", "환경에너지공학", "건축도시부동산학부", "건축학", "도시부동산학", "산업및기계공학부", "산업공학", "기계공학", "전자재료공학부", "전자재료공학", "전자물리", "전기전자공학부", "전기공학", "전자공학","화학공학·신소재공학부", "신소재공학", "화학공학", "컴퓨터학부", "컴퓨터SW", "미디어SW", "정보통신학부", "정보보호", "정보통신", "데이터과학부", "간호학과", "아동가족복지학과", "의류학과", "식품영양학과", "스포츠과학부", "체육학", "레저스포츠", "운동건강관리", "조형예술학부", "회화", "조소", "디자인학부", "커뮤니케이션디자인", "패션디자인", "공예디자인", "작곡과", "성악과", "피아노과", "관현악과", "국악과", "문화예술학부", "영화영상", "연극", "무용", "문화콘텐츠테크놀러지", "자유전공학부"]
     
    
    var filteredUswCourse: Array<Course> = []
    
    var numData = 0
    var majorData = ""
    
    var checkTimeTable: String = UserDefaults.standard.string(forKey: "name") ?? ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        searchBar.delegate = self
        navigationBarHidden()
        navigationBackSwipeMotion()
        readFirstData()
        filteredUswCourse = uswCourse
        
        
        dropDown1.anchorView = numDropDown
        dropDown1.dataSource = numList
        dropDown1.bottomOffset = CGPoint(x: 0, y:(dropDown1.anchorView?.plainView.bounds.height)!)
        dropDown1.direction = .bottom
        dropDown1.textFont = UIFont.systemFont(ofSize: 15)

        dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
            //print("Selected item: \(item) at index: \(index)")
            self.choiceNumDropDown.text = numList[index]
            self.choiceNumDropDown.font = UIFont.systemFont(ofSize: 15)
            self.choiceNumDropDown.textColor = .black
            self.choiceNumDropDown.textAlignment = .center
            
            if choiceNumDropDown.text != "전체" {
                numData = Int(choiceNumDropDown.text ?? "1") ?? 1
            } else if choiceNumDropDown.text! == "전체"{
                numData = 6
            }
            print(numData)

            print(majorData)
            
            if numData == 6 && majorData == "전체" {
               removeArray()
               readFirstData()
            } else if numData != 0 && majorData != "" {
                selectedData(numData: numData, majorData: majorData)
            } else if numData != 0 || majorData == "전체" || majorData == "" {
                numCheck()
            }
        }

        
        dropDown2.anchorView = majorDropDown
        dropDown2.dataSource = majorList
        dropDown2.bottomOffset = CGPoint(x: 0, y:(dropDown2.anchorView?.plainView.bounds.height)!)
        dropDown2.direction = .bottom
        dropDown2.textFont = UIFont.systemFont(ofSize: 15)
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
            // print("Selected item: \(item) at index: \(index)")
            self.choiceMajorDropDown.text = majorList[index]
            self.choiceMajorDropDown.font = UIFont.systemFont(ofSize: 12)
            self.choiceMajorDropDown.textColor = .black
            self.choiceMajorDropDown.textAlignment = .center
            
            if choiceMajorDropDown.text != "전체"{
                majorData = choiceMajorDropDown.text ?? "전체"
            } else if choiceMajorDropDown.text == "전체"{
                majorData = "전체"
            }
            print(numData)

            print(majorData)
            
            if numData == 6 && majorData == "전체" {
                removeArray()
                readFirstData()
            } else if numData != 0 && majorData != "" {
                selectedData(numData: numData, majorData: majorData)
            } else if majorData != "" || numData == 6 || numData == 0{
                majorCheck()
            }
            
        }
        
        

        // Do any addit// Do any additional setup after loading the view.
    }
    
    // 자바, ICT개론, 데이터베이스, 데이터통신, 정보보호개론
    
    @IBAction func numBtnClicked(_ sender: Any) {
        dropDown1.show()
        
    }
    
    @IBAction func majorBtnClicked(_ sender: Any) {
        dropDown2.show()
    }
    func removeArray() {
        uswCourse.removeAll()
        filteredUswCourse.removeAll()
    }
    
    
    func numCheck(){
        if numData != 6{
            selectNumData(numData: numData)
        } else if numData == 6{
            removeArray()
            readFirstData()
        }
    }
    
    func majorCheck(){
        if majorData != "전체" {
            selectMajorData(majorData: majorData)
        } else if majorData == "전체" {
            removeArray()
            readFirstData()
        }
        
            //

    }
    // 함수 내부에 인자로 text를 받아와서 비교
    func selectMajorData(majorData: String){
        removeArray()
        let courseDB = realm.objects(CourseData.self)
        for i in 0..<courseDB.count-1{
            if courseDB[i].major == majorData{
                var readCourse = Course(courseName: courseDB[i].courseName, roomName: courseDB[i].roomName, professor: courseDB[i].professor, major: courseDB[i].major, classification: courseDB[i].classification, courseDay: courseDB[i].courseDay, startTime: courseDB[i].startTime, endTime: courseDB[i].endTime, num: courseDB[i].num)
                uswCourse.append(readCourse)
            }
        }
        filteredUswCourse = uswCourse
        tableView?.reloadData()
        tableView?.beginUpdates()
        tableView.endUpdates()
    }
    
    
    func selectNumData(numData: Int){
        removeArray()
        let courseDB = realm.objects(CourseData.self)
        for i in 0...courseDB.count-1{
            if courseDB[i].num == numData {
                var readCourse = Course(courseName: courseDB[i].courseName, roomName: courseDB[i].roomName, professor: courseDB[i].professor, major: courseDB[i].major, classification: courseDB[i].classification, courseDay: courseDB[i].courseDay, startTime: courseDB[i].startTime, endTime: courseDB[i].endTime, num: courseDB[i].num)
                uswCourse.append(readCourse)
            }
        }
        filteredUswCourse = uswCourse
        tableView?.reloadData()
        tableView?.beginUpdates()
        tableView.endUpdates()
    }
    
    func selectedData(numData: Int, majorData: String) {
        removeArray()
        let courseDB = realm.objects(CourseData.self)
        if numData == 6{
            for i in 0..<courseDB.count-1{
                if courseDB[i].major == majorData{
                    var readCourse = Course(courseName: courseDB[i].courseName, roomName: courseDB[i].roomName, professor: courseDB[i].professor, major: courseDB[i].major, classification: courseDB[i].classification, courseDay: courseDB[i].courseDay, startTime: courseDB[i].startTime, endTime: courseDB[i].endTime, num: courseDB[i].num)
                    uswCourse.append(readCourse)
                }
            }
        } else if majorData == "전체" { // 애는 됨
            for i in 0...courseDB.count-1{
                if courseDB[i].num == numData {
                    var readCourse = Course(courseName: courseDB[i].courseName, roomName: courseDB[i].roomName, professor: courseDB[i].professor, major: courseDB[i].major, classification: courseDB[i].classification, courseDay: courseDB[i].courseDay, startTime: courseDB[i].startTime, endTime: courseDB[i].endTime, num: courseDB[i].num)
                    uswCourse.append(readCourse)
                }
            }
        } else {
            for i in 0...courseDB.count-1{
                if courseDB[i].num == numData && courseDB[i].major == majorData {
                    var readCourse = Course(courseName: courseDB[i].courseName, roomName: courseDB[i].roomName, professor: courseDB[i].professor, major: courseDB[i].major, classification: courseDB[i].classification, courseDay: courseDB[i].courseDay, startTime: courseDB[i].startTime, endTime: courseDB[i].endTime, num: courseDB[i].num)
                    uswCourse.append(readCourse)
                }
            }
        }
        
        filteredUswCourse = uswCourse
        tableView?.reloadData()
        tableView?.beginUpdates()
        tableView.endUpdates()
    }
    
    func readFirstData(){
        let courseDB = realm.objects(CourseData.self)
        for i in 0...courseDB.count-1{
            var readCourse = Course(courseName: courseDB[i].courseName, roomName: courseDB[i].roomName, professor: courseDB[i].professor, major: courseDB[i].major, classification: courseDB[i].classification, courseDay: courseDB[i].courseDay, startTime: courseDB[i].startTime, endTime: courseDB[i].endTime, num: courseDB[i].num)
            uswCourse.append(readCourse)
        }
        filteredUswCourse = uswCourse
        tableView?.reloadData()
        tableView?.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUswCourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.courseTxtField.text = filteredUswCourse[indexPath.row].courseName
        cell.roomTxtField.text = filteredUswCourse[indexPath.row].roomName
        cell.professorTxtField.text = filteredUswCourse[indexPath.row].professor
        cell.numTxtField.text = "\(filteredUswCourse[indexPath.row].num)학년,"
        cell.classTxtField.text = "\(filteredUswCourse[indexPath.row].classification),"
        cell.majorTxtField.text = filteredUswCourse[indexPath.row].major

        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
        
        infoVC.courseNameData = filteredUswCourse[indexPath.row].courseName
        infoVC.roomNameData = filteredUswCourse[indexPath.row].roomName
        infoVC.professorData = filteredUswCourse[indexPath.row].professor
        infoVC.numData = filteredUswCourse[indexPath.row].num
        infoVC.courseDayData = filteredUswCourse[indexPath.row].courseDay
        infoVC.startTimeData = filteredUswCourse[indexPath.row].startTime
        infoVC.endTimeData = filteredUswCourse[indexPath.row].endTime
        infoVC.classificationData = filteredUswCourse[indexPath.row].classification
        infoVC.checkTimeTable = self.checkTimeTable
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUswCourse = uswCourse.filter({ course -> Bool in
            if let text = searchBar.text {
                if course.courseName.contains(text){
                    return course.courseName.contains(text)
                } else if course.major.contains(text){
                    return course.major.contains(text)
                } else {
                    return false
                }
        } else {return false}
        })
       
        
        
        self.tableView.reloadData()
        tableView?.beginUpdates()
        tableView.endUpdates()
    }
  
    
    
    

}


class customCell: UITableViewCell {
    @IBOutlet weak var courseTxtField: UILabel!
    @IBOutlet weak var roomTxtField: UILabel!
    @IBOutlet weak var professorTxtField: UILabel!
    @IBOutlet weak var majorTxtField: UILabel!
    @IBOutlet weak var numTxtField: UILabel!
    @IBOutlet weak var classTxtField: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 12.0
}
}

