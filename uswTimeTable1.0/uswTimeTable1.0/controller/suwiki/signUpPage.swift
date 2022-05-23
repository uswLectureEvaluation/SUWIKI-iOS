//
//  signUpPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/21.
//

import UIKit

import Alamofire
import SwiftyJSON


class signUpPage: UIViewController {

    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    @IBOutlet var idTextFieldBottomLine: UIView!
    @IBOutlet var passwordTextFieldBottomLine: UIView!
    @IBOutlet var passwordCheckTextFieldBottomLine: UIView!
    
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)

    
    let loginModel = userModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func overLapBtnClicked(_ sender: Any) {
        guard let id = idTextField.text, !id.isEmpty else { return }

        
        if loginModel.isValidId(id: id){ // 형식 통과 시 api로 확인 후 alert 띄워주기
            let url = "https://api.suwiki.kr/user/check-id"
            let parameters = [
                "loginId" : id
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
                let data = response.data
                let json = JSON(data ?? "")
                print(json)
                if json["overlap"].boolValue == false {
                    self.showAlert(title: "사용 가능한 아이디입니다 !")
                } else {
                    self.showAlert(title: "중복된 아이디입니다 !")
                }
                
                
            }
            
            
            
            
        } else { // 아이디 형식 잘못된 경우 출력
            showAlert(title: "아이디 형식이 잘못 되었어요 !")
        }
    }
    


    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "확인 버튼을 눌러주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true,completion: nil)
    }
    
    
}
