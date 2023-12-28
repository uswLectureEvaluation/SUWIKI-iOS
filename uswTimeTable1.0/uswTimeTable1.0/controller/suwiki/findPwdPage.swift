//
//  findPwdPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/02.
//

import UIKit
import Alamofire
import SwiftyJSON

class findPwdPage: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        
        sendBtn.layer.borderWidth = 1.0
        sendBtn.layer.cornerRadius = 13.0
        sendBtn.layer.borderColor = UIColor.white.cgColor
        
        
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }
    


    @IBAction func sendBtnClicked(_ sender: Any) {
        let url = "https://api.kr"
        let parameters = [
            "loginId" : "\(idTextField.text!)",
            "email" : "\(emailTextField.text!)@suwon.ac.kr"
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            let checkStatus = Int(response.response!.statusCode)
            print(JSON(response.data))
            if checkStatus == 400{
                let alert = UIAlertController(title:"없는 계정이거나, 잘못 입력하셨습니다.",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title:"임시 비밀번호가 메일로 전송되었습니다.",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
          
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
}
