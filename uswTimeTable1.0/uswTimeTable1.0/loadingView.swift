//
//  loadingView.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/17.
//

import UIKit
import RealmSwift
import FirebaseDatabase


class loadingView: UIViewController {

    let realm = try! Realm()

    private let uswFireDB = Database.database(url: "https://schedulecheck-4ece8-default-rtdb.firebaseio.com/").reference()

    override func viewDidLoad() {
        print("data 받는 화면")
        getExternalData()
        checkLoadData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkLoadData(){
        uswFireDB.observe(.value) { snapshot in
            let realmCount = self.realm.objects(CourseData.self).count
            let fireBaseCount = Int(snapshot.childrenCount)
            if realmCount == fireBaseCount{
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "first") as! firstSceneCheck
                self.navigationController?.pushViewController(firstVC, animated: true)
            }
        }
        
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
                        print("\(i)")
                        try! realm.write{
                            realm.add(insideDB)
                        }
                    }
                }
            }
        }
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
