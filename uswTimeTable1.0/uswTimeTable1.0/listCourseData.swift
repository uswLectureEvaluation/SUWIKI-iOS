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
    
    var courseName = [String]()
    var roomName = [String]()
    var professor = [String]()
    var startTime = [String]()
    var endTime = [String]()
    var major = [String]()
    var classification = [String]()
    var num = [Int]()
    var courseDay = [String]()
    var courseData = [String]()
    let dropDown1 = DropDown()
    let numList = ["1", "2", "3", "4"] // 기존 수업 정보
    
    
    var filteredCourseName = [String]() // 검색시 사용
    var filteredRoomName = [String]()
    var filteredProfessor = [String]()
    var filteredStartTime = [String]()
    var filteredEndTime = [String]()
    var filteredClassification = [String]()
    var filteredNum = [Int]()
    var filteredMajor = [String]()
    
    
    var checkTimeTable: String = UserDefaults.standard.string(forKey: "name") ?? ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        filteredData()
        searchBar.delegate = self
        
        navigationBarHidden()
        navigationBackSwipeMotion()
        print(checkTimeTable)
        readFirstData()
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
           
            if choiceNumDropDown.text! == "1"{
                removeArray()
                print(choiceNumDropDown.text!)
                selectNumData(checkNum: 1)
            } else if choiceNumDropDown.text! == "2" {
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
            }
        }// Do any additional setup after loading the view.
    }
    
    
    @IBAction func numBtnClicked(_ sender: Any) {
        dropDown1.show()

    }
    
    func removeArray() {
        startTime.removeAll()
        endTime.removeAll()
        courseName.removeAll()
        roomName.removeAll()
        professor.removeAll()
        major.removeAll()
        classification.removeAll()
        courseDay.removeAll()
        num.removeAll()
    }
    
    func filteredData() {
        filteredCourseName = courseName
        filteredRoomName = roomName
        filteredNum = num
        filteredMajor = major
        filteredProfessor = professor
        filteredClassification = classification
        filteredStartTime = startTime
        filteredEndTime = endTime
    }
    func selectNumData(checkNum: Int){

        let courseDB = realm.objects(CourseData.self)
        var readCN = String() // coursename
        var readRN = String() // roomname
        var readPR = String() // professor
        var readMJ = String() // major
        var readCF = String() // classfication
        var readNM = Int() // num
        var readST = String() // starttime
        var readET = String() // endtime
        var readCD = String()
        for i in 0...courseDB.count-1{
            if courseDB[i].num == checkNum {
                readCN = courseDB[i].courseName
                readRN = courseDB[i].roomName
                readPR = courseDB[i].professor
                readMJ = courseDB[i].major
                readCF = courseDB[i].classification
                readNM = courseDB[i].num
                readST = courseDB[i].startTime
                readET = courseDB[i].endTime
                readCD = courseDB[i].courseDay
                startTime.append(readST)
                endTime.append(readET)
                courseName.append(readCN)
                roomName.append(readRN)
                professor.append(readPR)
                major.append(readMJ)
                classification.append(readCF)
                num.append(readNM)
                courseDay.append(readCD)
                tableView?.reloadData()
               
            }
        }
        tableView?.beginUpdates()
        tableView.endUpdates()
    }
    
    func readFirstData(){
        let courseDB = realm.objects(CourseData.self)
        var readCI = String()
        var readCN = String()
        var readRN = String()
        var readPR = String()
        var readCF = String()
        var readNM = Int()
        var readMJ = String()
        var readST = String() // starttime
        var readET = String() // endtime
        var readCD = String()
        for i in 0...courseDB.count-1{
            readCN = courseDB[i].courseName
            readRN = courseDB[i].roomName
            readPR = courseDB[i].professor
            readMJ = courseDB[i].major
            readCF = courseDB[i].classification
            readNM = courseDB[i].num
            readST = courseDB[i].startTime
            readET = courseDB[i].endTime
            readCD = courseDB[i].courseDay
            startTime.append(readST)
            endTime.append(readET)
            courseName.append(readCN)
            roomName.append(readRN)
            professor.append(readPR)
            major.append(readMJ)
            classification.append(readCF)
            num.append(readNM)
            courseDay.append(readCD)
            tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCourseName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.courseTxtField.text = filteredCourseName[indexPath.row]
        cell.roomTxtField.text = filteredRoomName[indexPath.row]
        cell.professorTxtField.text = filteredProfessor[indexPath.row]
        cell.numTxtField.text = "\(filteredNum[indexPath.row])학년,"
        cell.classTxtField.text = "\(filteredClassification[indexPath.row]),"
        cell.majorTxtField.text = filteredMajor[indexPath.row]
        cell.myView.layer.borderWidth = 1.0
        cell.myView.layer.borderColor = UIColor.lightGray.cgColor
        cell.myView.layer.cornerRadius = 12.0
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
        infoVC.courseNameData = courseName[indexPath.row]
        infoVC.roomNameData = roomName[indexPath.row]
        infoVC.professorData = professor[indexPath.row]
        infoVC.numData = num[indexPath.row]
        infoVC.courseDayData = courseDay[indexPath.row]
        infoVC.startTimeData = startTime[indexPath.row]
        infoVC.endTimeData = endTime[indexPath.row]
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
        filteredEmpty()
        
        if searchText == "" {
            filteredData()
        } else {
            for searchData in courseName{
                
                if searchData.lowercased().contains(searchText.lowercased()){
                    filteredCourseName.append(searchText)
                }
                    
            }
        }
        
        self.tableView.reloadData()
    }
    
    func filteredEmpty(){
        filteredCourseName = []
        filteredRoomName = []
        filteredNum = []
        filteredMajor = []
        filteredProfessor = []
        filteredClassification = []
        filteredStartTime = []
        filteredEndTime = []
    }
    
    
    

}


class customCell: UITableViewCell {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var courseTxtField: UILabel!
    @IBOutlet weak var roomTxtField: UILabel!
    @IBOutlet weak var professorTxtField: UILabel!
    @IBOutlet weak var majorTxtField: UILabel!
    @IBOutlet weak var numTxtField: UILabel!
    @IBOutlet weak var classTxtField: UILabel!
    
}
