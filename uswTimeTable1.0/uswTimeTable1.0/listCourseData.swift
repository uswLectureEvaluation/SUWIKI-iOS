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
        for i in 0...2003{
            readCN = courseDB[i].courseName
            readRN = courseDB[i].roomName
            readPR = courseDB[i].professor
            courseName.append(readCN)
            roomName.append(readRN)
            professor.append(readPR)
            tableView?.reloadData()
        }
 
        print(professor)
        print(courseName)
        print(roomName)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCell
        cell.courseTxtField.text = courseName[indexPath.row]
        cell.roomTxtField.text = roomName[indexPath.row]
        cell.professorTxtField.text = professor[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}


class customCell: UITableViewCell {
    @IBOutlet weak var courseTxtField: UILabel!
    @IBOutlet weak var roomTxtField: UILabel!
    @IBOutlet weak var professorTxtField: UILabel!
    
}
