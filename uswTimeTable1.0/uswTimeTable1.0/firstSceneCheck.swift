//
//  firstSceneCheck.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/02.
//

import UIKit
import RealmSwift
import Elliotable
import FirebaseDatabase

class firstSceneCheck: UIViewController {
   
    let realm = try! Realm()
    
    
    private let uswFireDB = Database.database(url: "https://schedulecheck-4ece8-default-rtdb.firebaseio.com/").reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        //getExternalData()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        readDBData()
    //    save()
}

    @IBAction func newBtnClicked(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    
    func readDBData(){
        weak var TxtField: UITextField!
        realm.beginWrite()
        let testDB = realm.objects(testCourseData.self)
        for testValue in testDB{
            let courseIdData = testValue.courseId
            TxtField.text = courseIdData
            print(TxtField.text)
        }
        try! realm.commitWrite()
    }
    
    func checkInsideDB(){
        let reDB = realm.objects(testCourseData.self)
        let countRDB = reDB.count
        uswFireDB.observe(.value) { snapshot in
            let countFDB = Int(snapshot.childrenCount)
            if countRDB == countFDB {
                self.getExternalData()
                print("success, check ur DB")
            } else {
                print("already have")
            }
        }
 
    }

    func getExternalData(){
        uswFireDB.observe(.value) { snapshot in
            let countDB = Int(snapshot.childrenCount)
            for i in 0...countDB {
                let insideDB = testCourseData()
                self.uswFireDB.child("\(i)").observeSingleEvent(of: .value) { [self] snapshot in
                    let value = snapshot.value as? NSDictionary
                    insideDB.startTime = value?["startTime"] as? String ?? ""
                    insideDB.endTime = value?["endTime"] as? String ?? ""
                    insideDB.roomName = value?["roomName"] as? String ?? ""
                    insideDB.professor = value?["professor"] as? String ?? ""
                    insideDB.classification = value?["classification"] as? String ?? ""
                    insideDB.courseId = value?["courseId"] as? String ?? ""
                    insideDB.num = value?["num"] as? Int ?? 0
                    insideDB.courseName = value?["courseName"] as? String ?? ""
                    insideDB.classNum = value?["classNum"] as? String ?? ""
                    insideDB.major = value?["major"] as? String ?? ""
                    insideDB.credit = value?["credit"] as? Int ?? 0
                    insideDB.time = value?["time"] as? String ?? ""
                    insideDB.courseDay = value?["courseDay"] as? String ?? ""
                    print("check ur db\(i)")
                    try! self.realm.write{
                        self.realm.add(insideDB)
                    }
                }
            }
            
        }
    }
    
}
