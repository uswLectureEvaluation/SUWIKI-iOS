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

    var addPasswordLabel = false
    var addPasswordCheckLabel = false
    
    let loginModel = userModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        passwordTextField.addTarget(self, action: #selector(passwordTextTypeCheck), for: .editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(passwordCheckTextTypeCheck), for: .editingChanged)
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
    
    
    @objc func passwordTextTypeCheck(_ sender: UITextField){
        let passwordLabel = UILabel(frame: CGRect(x: 16, y: passwordTextFieldBottomLine.frame.maxY + 2, width: 120, height: 18))

        if passwordTextField.text?.count ?? 0 < 8 { // if문 내부에 정규식 true 반환할 경우 추가 필요
            
            passwordTextFieldBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            if addPasswordLabel == false {
                print("addpasswdLabel")
                addPasswordLabel = true
                passwordLabel.text = "8자 이상 입력하세요."
                passwordLabel.textColor = colorLiteralPurple
                passwordLabel.font = passwordLabel.font.withSize(12)
                passwordLabel.tag = 100
                self.view.addSubview(passwordLabel)
            
            }
            
        } else {
            if let removeable = self.view.viewWithTag(100) {
                removeable.removeFromSuperview()
                addPasswordLabel = false
            }
            passwordTextFieldBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
        }
    }
    
    @objc func passwordCheckTextTypeCheck(_ sender: UITextField){
        let passwordCheckLabel = UILabel(frame: CGRect(x: 16, y: passwordCheckTextFieldBottomLine.frame.maxY + 2, width: 190, height: 18))
        
        
        if passwordTextField.text == passwordCheckTextField.text {
            passwordCheckTextFieldBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
            
            if let removeable = self.view.viewWithTag(101) {
                
                removeable.removeFromSuperview()
                addPasswordCheckLabel = false
                
            }

        } else {
            
            if addPasswordCheckLabel == false {
                
                addPasswordCheckLabel = true
                passwordCheckLabel.text = "비밀번호가 일치하지 않습니다."
                passwordCheckLabel.textColor = colorLiteralPurple
                passwordCheckLabel.font = passwordCheckLabel.font.withSize(12)
                passwordCheckLabel.tag = 101
                self.view.addSubview(passwordCheckLabel)
                
            }

            passwordCheckTextFieldBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
        }
      
    }
    
}
