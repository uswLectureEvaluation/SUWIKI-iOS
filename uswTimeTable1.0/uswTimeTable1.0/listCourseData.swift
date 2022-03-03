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
    @IBOutlet weak var choiceNumDropDown: UILabel!
    
    
    var uswCourse: Array<Course> = []
    
    var courseData = [String]()
    let dropDown1 = DropDown()
    let numList = ["전체", "1", "2", "3", "4"] // 기존 수업 정보
    let majorList = ["전체", "인문학부", "국어국문학", "외국어학부", "영어영문학", "프랑스어문학", "러시아어문학", "일어일문학", "중어중문학", "법·행정학부", "법학", "행정학", "미디어커뮤니케이션학과", "행정학과(야)", "소방행정학과(야)", "경영학부", "경영", "글로벌비즈니스", "회계", "경제학부", "경제금융", "국제개발협력", "호텔관광학부",  "호텔경영", "외식경영", "관광경영", "바이오화학산업학부", "바이오싸이언스", "바이오공학 및 마케팅", "융합화학산업", "건설환경에너지공학부", "건설환경공학", "환경에너지공학", "건축도시부동산학부", "건축학", "정보보호", "화학공학·신소재공학부"]
    
    
    var filteredUswCourse: Array<Course> = []
    
    
    
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
        dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.choiceNumDropDown.text = numList[index]
            self.choiceNumDropDown.font = UIFont(name: "system", size: 17)
            self.choiceNumDropDown.textColor = .black
            self.choiceNumDropDown.textAlignment = .center
           
            if choiceNumDropDown.text == "1" {
                removeArray()
                selectNumData(checkNum: 1)
            } else if choiceNumDropDown.text == "2" {
                removeArray()
                print(choiceNumDropDown.text!)
                selectNumData(checkNum: 2)
            } else if choiceNumDropDown.text! == "3" {
                removeArray()
                print(choiceNumDropDown.text!)
                selectNumData(checkNum: 3)
            } else if choiceNumDropDown.text! == "4" {
                removeArray()
                print(choiceNumDropDown.text!)
                selectNumData(checkNum: 4)
            } else if choiceNumDropDown.text! == "전체"{
                removeArray()
                readFirstData()
            }
                        
        }// Do any additional setup after loading the view.
    }
    
    
    @IBAction func numBtnClicked(_ sender: Any) {
        dropDown1.show()

    }
    
    func removeArray() {
        uswCourse.removeAll()
        filteredUswCourse.removeAll()
    }
    

    // 함수 내부에 인자로 text를 받아와서 비교
    
    
    func selectNumData(checkNum: Int){
        let courseDB = realm.objects(CourseData.self)
        for i in 0...courseDB.count-1{
            if courseDB[i].num == checkNum {
                var readCourse = Course(courseName: courseDB[i].courseName, roomName: courseDB[i].roomName, professor: courseDB[i].professor, major: courseDB[i].major, classification: courseDB[i].classification, courseDay: courseDB[i].courseDay, startTime: courseDB[i].startTime, endTime: courseDB[i].endTime, num: courseDB[i].num)
                uswCourse.append(readCourse)
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
            guard let text = searchBar.text else {return false}
            return course.courseName.contains(text)
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

