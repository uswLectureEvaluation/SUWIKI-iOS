//
//  listCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/25.
//

import UIKit
import RealmSwift

class listCourseData: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    

    
    var courseName = [String]()
    var roomName = [String]()
    var professor = [String]()
    var major = [String]()
    var classification = [String]()
    var num = [Int]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        readData()

                // Do any additional setup after loading the view.
    }
    
    func readData(){
        let courseDB = realm.objects(testCourseData.self)
        var readCN = String()
        var readRN = String()
        var readPR = String()
        var readMJ = String()
        var readCF = String()
        var readNM = Int()
        for i in 0...2003{
            readCN = courseDB[i].courseName
            readRN = courseDB[i].roomName
            readPR = courseDB[i].professor
            readMJ = courseDB[i].major
            readCF = courseDB[i].classification
            readNM = courseDB[i].num
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134.0
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
