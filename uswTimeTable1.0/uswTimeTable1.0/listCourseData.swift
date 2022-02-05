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
    
    var courseId = [String]()
    var courseName = [String]()
    var searchCourseName = [String]()
    var roomName = [String]()
    var professor = [String]()
    var startTime = [String]()
    var endTime = [String]()
    var major = [String]()
    var classification = [String]()
    var num = [Int]()
    var courseData = [String]()
    let dropDown1 = DropDown()
    let numList = ["1", "2", "3", "4"]
    var checkTimeTable = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(checkTimeTable)
        searchBar.delegate = self
        readFirstData()
        searchCourseName = courseName
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
        courseId.removeAll()
        startTime.removeAll()
        endTime.removeAll()
        courseName.removeAll()
        roomName.removeAll()
        professor.removeAll()
        major.removeAll()
        classification.removeAll()
        num.removeAll()
    }
    
    func selectNumData(checkNum: Int){
        let courseDB = realm.objects(testCourseData.self)
        let readCnt = courseDB[0].dbCnt
        var readCI = String() // courseid
        var readCN = String() // coursename
        var readRN = String() // roomname
        var readPR = String() // professor
        var readMJ = String() // major
        var readCF = String() // classfication
        var readNM = Int() // num
        var readST = String() // starttime
        var readET = String() // endtime
        for i in 0...readCnt{
            if courseDB[i].num == checkNum {
                readCI = courseDB[i].courseId
                readCN = courseDB[i].courseName
                readRN = courseDB[i].roomName
                readPR = courseDB[i].professor
                readMJ = courseDB[i].major
                readCF = courseDB[i].classification
                readNM = courseDB[i].num
                readST = courseDB[i].startTime
                readET = courseDB[i].endTime
                courseId.append(readCI)
                startTime.append(readST)
                endTime.append(readET)
                courseName.append(readCN)
                roomName.append(readRN)
                professor.append(readPR)
                major.append(readMJ)
                classification.append(readCF)
                num.append(readNM)
                tableView?.reloadData()
            }
        }
    }
    
    func readFirstData(){
        let courseDB = realm.objects(testCourseData.self)
        let readCnt = courseDB[0].dbCnt
        var readCI = String()
        var readCN = String()
        var readRN = String()
        var readPR = String()
        var readCF = String()
        var readNM = Int()
        var readMJ = String()
        var readST = String() // starttime
        var readET = String() // endtime
        for i in 0...readCnt{
            readCI = courseDB[i].courseId
            readCN = courseDB[i].courseName
            readRN = courseDB[i].roomName
            readPR = courseDB[i].professor
            readMJ = courseDB[i].major
            readCF = courseDB[i].classification
            readNM = courseDB[i].num
            readST = courseDB[i].startTime
            readET = courseDB[i].endTime
            courseId.append(readCI)
            startTime.append(readST)
            endTime.append(readET)
            courseName.append(readCN)
            roomName.append(readRN)
            professor.append(readPR)
            major.append(readMJ)
            classification.append(readCF)
            num.append(readNM)
            tableView?.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.courseTxtField.text = courseName[indexPath.row]
        cell.roomTxtField.text = roomName[indexPath.row]
        cell.professorTxtField.text = professor[indexPath.row]
        cell.numTxtField.text = "\(num[indexPath.row])학년,"
        cell.classTxtField.text = "\(classification[indexPath.row]),"
        cell.majorTxtField.text = major[indexPath.row]
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
        infoVC.courseName = courseName[indexPath.row]
        infoVC.roomName = roomName[indexPath.row]
        infoVC.professor = professor[indexPath.row]
        infoVC.courseId = courseId[indexPath.row]
        infoVC.startTime = startTime[indexPath.row]
        infoVC.endTime = endTime[indexPath.row]
        infoVC.checkTimeTable = self.checkTimeTable
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCourseName = []
        if searchText == "" {
            searchCourseName = courseName
        }
        
        for searchCN in courseName {
            
            if searchCN.lowercased().contains(searchText.lowercased()){
                searchCourseName.append(searchCN)
            }
        }
        self.tableView.reloadData()
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
