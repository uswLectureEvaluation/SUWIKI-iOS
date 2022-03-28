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
    
    var fireBaseArray1: Array<externalData> = []
    
    var fireBaseArray2: Array<externalData> = []
    var startArray: Array<String> = []
    var boolCheck: Bool = false
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
        
        let insideDB = CourseData()
            uswFireDB.getData { (error, snapshot) in
                for data in snapshot.children{
                    var dataSnapshot = data as? DataSnapshot
                    var value = dataSnapshot?.value as? NSDictionary
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
                    self.fireBaseArray1.append(readData)
                    print(value)
            }
                print(self.fireBaseArray1[3].courseName)
                self.boolCheck = true
                try! self.realm.write{
                for i in 0..<Int(snapshot.childrenCount){
                    insideDB.startTime = self.fireBaseArray1[i].startTime
                    insideDB.endTime = self.fireBaseArray1[i].endTime
                    insideDB.roomName = self.fireBaseArray1[i].roomName
                    insideDB.courseName = self.fireBaseArray1[i].courseName
                    insideDB.courseDay = self.fireBaseArray1[i].courseDay
                    insideDB.professor = self.fireBaseArray1[i].professor
                    insideDB.classNum = self.fireBaseArray1[i].classNum
                    insideDB.major = self.fireBaseArray1[i].major
                    insideDB.credit = self.fireBaseArray1[i].credit
                    insideDB.classification = self.fireBaseArray1[i].classfication
                    insideDB.num = self.fireBaseArray1[i].num
                    self.realm.add(insideDB, update: .all)
                    print("\(i)")
                }
                }
                

                print(Realm.Configuration.defaultConfiguration.fileURL!)
                
                // insideDB.startTime = self.fireBaseArray1.startTime
        }
        
        
        
            /*
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

            }
             */
        
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
                            if i > countDB-3{
                        }

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

