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
    var numData = 0
    var classificationData = ""
    var startTimeData = ""
    var endTimeData = ""
    var courseDayData = 1 // courseDay, backgroundColor는 테스트 후 데이터 삽입 예정
    var backgroundColor = UIColor.purple
    var checkTimeTable = ""

    
    var courseItems: String {
        return "courseId: \(self.courseIdData), courseName: \(self.courseNameData), roomName: \(self.roomNameData), professor: \(self.professorData), courseDay: ElliotDay.init(rawValue: \(self.numData))!, startTime: \(self.startTimeData), endTime: \(self.endTimeData), backgroundColor: UIColor.systemBlue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(courseItems)
        courseNameTxt.text = courseNameData
        roomNameTxt.text = roomNameData
        professorTxt.text = professorData
        myView.layer.cornerRadius = 12.0
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtnClicked(_ sender: Any) {
        let readUserDB = realm.objects(userDB.self)
        
        for userData in readUserDB{
            if userData.timetableName == checkTimeTable{
                print(checkTimeTable)
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            }
        }
        // realm.add(readUserDB)
    }
    


    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
