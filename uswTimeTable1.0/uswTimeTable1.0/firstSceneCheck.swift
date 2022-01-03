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
        // Do any additional setup after loading the view.
    }
    

<<<<<<< HEAD
    @IBAction func newBtnClicked(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
=======
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
>>>>>>> 08467a317439c6856127195161d1aaf046ab3fc9
    */

}
