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
    
    @IBOutlet weak var myView: UIView!
    
    private let uswFireDB = Database.database(url: "https://schedulecheck-4ece8-default-rtdb.firebaseio.com/").reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getExternalData()
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.layer.cornerRadius = 8.0
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // try! realm.commitWrite()
    //    save()
}

    @IBAction func newBtnClicked(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }

    
    
    func getExternalData(){
        uswFireDB.observe(.value) { snapshot in
            let countDB = Int(snapshot.childrenCount)
            let checkRealm = self.realm.objects(CourseData.self)
            if countDB != checkRealm.count-1{
                try! self.realm.write{
                    self.realm.delete(checkRealm)
                }
                for i in 0...countDB {
                    let insideDB = CourseData()
                    self.uswFireDB.child("\(i)").observeSingleEvent(of: .value) { [self] snapshot in
                        let value = snapshot.value as? NSDictionary
                        insideDB.startTime = value?["startTime"] as? String ?? " "
                        insideDB.endTime = value?["endTime"] as? String ?? " "
                        insideDB.roomName = value?["roomName"] as? String ?? " "
                        insideDB.professor = value?["professor"] as? String ?? " "
                        insideDB.classification = value?["classification"] as? String ?? " "
                        insideDB.num = value?["num"] as? Int ?? 0
                        insideDB.courseName = value?["courseName"] as? String ?? " "
                        insideDB.classNum = value?["classNum"] as? String ?? " "
                        insideDB.major = value?["major"] as? String ?? " "
                        insideDB.credit = value?["credit"] as? Int ?? 0
                        insideDB.courseDay = value?["courseDay"] as? String ?? " "
                        print("check ur db\(i)")
                        try! realm.write{
                            realm.add(insideDB)
                        }
            
                    }
                }
            }
        }
    }

}
