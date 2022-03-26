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
    
    @IBAction func testBtn(_ sender: Any) {
        guard let id = idTextField.text, !id.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
                
        if loginModel.isValidId(id: id){
            if let removable = self.view.viewWithTag(100) {
                removable.removeFromSuperview()
            }
        }
        else {
            let emailLabel = UILabel(frame: CGRect(x: 68, y: 350, width: 279, height: 45))
            emailLabel.text = "이메일 형식을 확인해 주세요"
            emailLabel.textColor = UIColor.red
            emailLabel.tag = 100
            self.view.addSubview(emailLabel)
        } // 이메일 형식 오류
            
        if loginModel.isValidPassword(pwd: password){
            if let removable = self.view.viewWithTag(101) {
                removable.removeFromSuperview()
            }
        }
    
        else{
            let passwordLabel = UILabel(frame: CGRect(x: 68, y: 435, width: 279, height: 45))
            passwordLabel.text = "비밀번호 형식을 확인해 주세요"
            passwordLabel.textColor = UIColor.red
            passwordLabel.tag = 101
                
            self.view.addSubview(passwordLabel)
        } // 비밀번호 형식 오류
            
        if loginModel.isValidId(id: id) && loginModel.isValidPassword(pwd: password) {
            let loginSuccess: Bool = loginCheck(id: id, pwd: password)
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
                loginFailLabel.tag = 102
                    
                self.view.addSubview(loginFailLabel)
            }
        }
    }
    
    func loginCheck(id: String, pwd: String) -> Bool {
        for user in loginModel.users {
            if user.id == id && user.password == pwd {
                return true // 로그인 성공
            }
        }
        return false
    }
    /* 서버에 계정 post
    func postAccount(){
        let url = "https://api.suwiki.kr/user/login"
        let parameters = [
            "loginId" : "김도현",
            "password" : "p"
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            if var value = response.value{
                var json = JSON(response.value!)
                print(json)
            }
        }
    }
    */
    

    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
    }
}
