//
//  listTimeTable.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/05.
//

import UIKit
import RealmSwift
class listTimeTable: UIViewController {
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    func render() {
        let CDB = realm.objects(testCourseData.self)
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
