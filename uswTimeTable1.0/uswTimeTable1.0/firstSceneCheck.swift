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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
     //    save()
}

    @IBAction func newBtnClicked(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    
}
