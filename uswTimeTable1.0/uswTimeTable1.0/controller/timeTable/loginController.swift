//
//  loginController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class loginController: UIViewController {

    
    var loginModel = userModel()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton (_ sender: Any) {
        guard let id = idTextField.text, !id.isEmpty else { return }
        guard let pwd = passwordTextField.text, !pwd.isEmpty else { return }
                
        if loginModel.isValidId(id: id) == false{
            let emailLabel = UILabel(frame: CGRect(x: 68, y: 350, width: 279, height: 45))
            emailLabel.text = "아이디 형식을 확인해 주세요"
            emailLabel.textColor = UIColor.red
            self.view.addSubview(emailLabel)
        } // 아이디 형식 오류
            
        if loginModel.isValidPassword(pwd: pwd) == false{
            let passwordLabel = UILabel(frame: CGRect(x: 68, y: 435, width: 279, height: 45))
            passwordLabel.text = "비밀번호 형식을 확인해 주세요"
            passwordLabel.textColor = UIColor.red
            self.view.addSubview(passwordLabel)
            
        } // 비밀번호 형식 오류
            
        if loginModel.isValidId(id: id) && loginModel.isValidPassword(pwd: pwd) { // 형식이 맞을 경우 로그인 확인
            let loginSuccess: Bool = loginCheck(id: id, pwd: pwd)
            
            if loginSuccess {
                print("로그인 성공")
                if let removable = self.view.viewWithTag(102) {
                    removable.removeFromSuperview()
                }
            }
            
            else {
                print("로그인 실패")
                let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                loginFailLabel.textColor = UIColor.red
                    
                self.view.addSubview(loginFailLabel)
            }
        }
    }
    
    func loginCheck(id: String, pwd: String) -> Bool {
        postAccount(id: id, pwd: pwd)
    }
    
    func postAccount(id: String, pwd: String) -> Bool{
        var checkValue = 0
        let url = "https://api.suwiki.kr/user/login"
        let parameters = [
            "loginId" : id,
            "password" : pwd
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            if var value = response.value{
                if JSON(value)["AccessToken"][0] != nil{
                    print("로그인 성공")
                    print(value)
                    checkValue = 1
                    //로그인 성공
                } else {
                    print("로그인 실패")
                    print(value)
                    checkValue = 0
                }
            }
        }
        
        if checkValue == 1{
            return true
        }
        return false
}
    

    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
    }
}
