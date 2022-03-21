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
    override func viewDidLoad() {
        super.viewDidLoad()
        number1Text.text = "1. 해당 앱은 수원대 학생을 위하여 만들어진\n앱입니다.  사용하시다 불편사항이 있으시다면\n언제든지 sozohoy@gmail.com 으로 연락\n주세요 !"
        number1Text.font = UIFont.systemFont(ofSize: 19)
        number2Text.text = "2. 하반기에는 강의평가 앱도 출시 될 예정\n입니다! 이어서 출시되는 앱도 많은 관심\n부탁드려요!"
        number2Text.font = UIFont.systemFont(ofSize: 19)
        number3Text.text = "3. iOS 개발자를 찾고 있습니다! 앱 개발에\n관심있는 분들은 언제든지 위의 메일로 연락\n주세요!"
        number3Text.font = UIFont.systemFont(ofSize: 19)
        // Do any additional setup after loading the view.
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
