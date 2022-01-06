//
//  firstSceneCheck.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/02.
//

import UIKit
import RealmSwift
import Elliotable

class firstSceneCheck: UIViewController {
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        save()
}
    func save(){
        let timetableDB = databaseList()
        timetableDB.courseId = "c01"
        timetableDB.courseName = "dataFu"
        timetableDB.roomName = "B201"
        timetableDB.professor = "joe"
        timetableDB.startTime = "11:00"
        timetableDB.endTime = "12:00"
        print(timetableDB.courseId)
        try! realm.write {
            realm.add(timetableDB)
        }
}
    
    

    @IBAction func newBtnClicked(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    
}
