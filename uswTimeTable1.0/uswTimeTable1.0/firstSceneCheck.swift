//
//  firstSceneCheck.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/02.
//

import UIKit

class firstSceneCheck: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            if UserDefaults.standard.bool(forKey: "userLogin") == true{
            let showTimeTable = self.storyboard?.instantiateViewController(withIdentifier: "showTimeTable") as! showTimeTable
            self.navigationController?.pushViewController(showTimeTable, animated: true)
            }
    }


        
    
    @IBAction func newBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "uswMakeSchedule") as! uswMakeSchedule
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

}
