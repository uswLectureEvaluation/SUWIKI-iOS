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
        navigationBarHidden()
        myView.layer.borderWidth = 1.0
        myView.layer.borderColor = UIColor.lightGray.cgColor
        myView.layer.cornerRadius = 8.0
        checkUserData()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // try! realm.commitWrite()
    //    save()
}
    func checkUserData(){
        let userData = realm.objects(userDB.self).count
        if userData > 0 {
            let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
            self.navigationController?.pushViewController(showVC, animated: true)
        }
    }
    
    
    @IBAction func newBtnClicked(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }

    func checkLoadData(){
        uswFireDB.observe(.value) { snapshot in
            let realmCount = self.realm.objects(CourseData.self).count
            let fireBaseCount = Int(snapshot.childrenCount)
            print(fireBaseCount)
            print(realmCount-1)
            /*
            if realmCount-1 == fireBaseCount{
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "first") as! firstSceneCheck
                self.navigationController?.pushViewController(firstVC, animated: true)
            }
             */
        }
        
    }
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    

}
