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

    
    

}
