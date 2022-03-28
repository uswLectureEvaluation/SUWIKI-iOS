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
    var fireBaseArray: Array<externalData> = []
    var startArray: Array<String> = []
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var percentageView: UILabel!
    
    @IBOutlet weak var loadingGif: UIImageView!
    private let uswFireDB = Database.database(url: "https://schedulecheck-4ece8-default-rtdb.firebaseio.com/").reference()

    var countDB = 0

    
    // var uswCourse: Array<Course> = []
    
    
    
    override func viewDidLoad() {
        print("data 받는 화면")
        let loadGif = UIImage.gifImageWithName("loading")
        loadingGif.image = loadGif
        getExternalData()
        super.viewDidLoad()
        progressView.setProgress(0, animated: false)
        // Do any additional setup after loading the view.
    }
    

    func getExternalData(){
        uswFireDB.queryOrderedByKey().observeSingleEvent(of: .value) { snapshot in
            let countDB = Int(snapshot.childrenCount)
            let checkRealm = self.realm.objects(CourseData.self)
            
            for i in 0...countDB {
                self.uswFireDB.child("\(i)").observeSingleEvent(of: .value) { [self] snapshot in
                    let value = snapshot.value as? NSDictionary
                    
                    var startTime = value?["startTime"] as? String ?? " "
                    var endTime = value?["endTime"] as? String ?? " "
                    var classNum = value?["classNum"] as? String ?? " "
                    var classfication = value?["classification"] as? String ?? " "
                    var courseDay = value?["courseDay"] as? String ?? " "
                    var credit = value?["credit"] as? Int ?? 0
                    var courseName = value?["courseName"] as? String ?? " "
                    var major = value?["major"] as? String ?? " "
                    var num = value?["num"] as? Int ?? 0
                    var professor = value?["professor"] as? String ?? " "
                    var roomName = value?["roomName"] as? String ?? " "
                   
                   
                    var readData = externalData(classNum: classNum, classification: classfication, courseDay: courseDay, courseName: courseName, credit: credit, endTime: endTime, major: major, num: num, professor: professor, roomName: roomName, startTime: startTime)
                    

                    
                    fireBaseArray.append(readData)
                }
                print(self.startArray)

            }
        }
        /*
        uswFireDB.observe(.value) { snapshot in
            self.countDB = Int(snapshot.childrenCount)
        }
        print(countDB)
        
        */
        
        // uswFireDB.child(<#T##pathString: String##String#>)
        
        /*
       
        */
            
        
             
        /*
        uswFireDB.observe(.value) { [self] snapshot in
            
            let countDB = Int(snapshot.childrenCount)
            let checkRealm = self.realm.objects(CourseData.self)
            
            if countDB != checkRealm.count-1{
                // DB 데이터 변경 되었을 경우 일괄 삭제 후 추가
                try! realm.write{
                    realm.delete(checkRealm)
                }
                let insideDB = CourseData()
                    for i in 0...countDB {
                        
                        self.uswFireDB.child("\(i)").observeSingleEvent(of: .value) { snapshot in
                            let value = snapshot.value as? NSDictionary
                            insideDB.startTime = value?["startTime"] as? String ?? " "
                            insideDB.endTime = value?["endTime"] as? String ?? " "
                            insideDB.roomName = value?["roomName"] as? String ?? " " // timtSmryCn
                            insideDB.professor = value?["professor"] as? String ?? " " // reprPrfsEnoNm
                            insideDB.classification = value?["classification"] as? String ?? " " // facDvnm
                            insideDB.num = value?["num"] as? Int ?? 0
                            insideDB.courseName = value?["courseName"] as? String ?? " "
                            insideDB.classNum = value?["classNum"] as? String ?? " "
                            insideDB.major = value?["major"] as? String ?? " "
                            insideDB.credit = value?["credit"] as? Int ?? 0
                            insideDB.courseDay = value?["courseDay"] as? String ?? " "
                            
                        }

                    }
                try! realm.write{
                    self.realm.add(insideDB)

                }
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "firstVC") as! firstSceneCheck
                self.navigationController?.pushViewController(firstVC, animated: true)
                }
            
            
                
                else if checkRealm.count == 0{
                let insideDB = CourseData()
            
                
                
                    for i in 0...countDB {
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
                        }

                            
                    }
                try! realm.write{
                    realm.add(insideDB)
                }
                
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "firstVC") as! firstSceneCheck
                self.navigationController?.pushViewController(firstVC, animated: true)
                }
         }
                */
                   
              

            
        }
}

