//
//  announcementView.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/21.
//

import UIKit

class announcementView: UIViewController {
    

    @IBOutlet weak var number1Text: UILabel!
    @IBOutlet weak var number2Text: UILabel!
    @IBOutlet weak var number3Text: UILabel!
    let pasteBoard = UIPasteboard.general
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClicked(_ sender: Any) {
        pasteBoard.string = "100009448355 토스뱅크"
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
