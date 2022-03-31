//
//  loginController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift

class loginController: UIViewController {

    
    let keychain = KeychainSwift()
    let loginModel = userModel()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        keychain.clear()
        self.navigationItem.hidesBackButton = true
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
            loginCheck(id: id, pwd: pwd)
        }
        
    }
    
    /*
    func loginCheck(id: String, pwd: String) -> Bool {
        postAccount(id: id, pwd: pwd)
    }
     */
    
    func loginCheck(id: String, pwd: String){

        let url = "https://api.suwiki.kr/user/login"
        let parameters = [
            "loginId" : id,
            "password" : pwd
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            
            let data = response.data
            let json = JSON(data!)
            let accessToken = json["AccessToken"].stringValue
            let refreshToken = json["RefreshToken"].stringValue
        
            if accessToken != "" {
                
                print("로그인 성공")
                self.keychain.set(accessToken, forKey: "AccessToken")
                self.keychain.set(refreshToken, forKey: "RefreshToken")

                
                print(self.keychain.get("AccessToken") ?? "")
                print(self.keychain.get("RefreshToken") ?? "")
                
                let tapbarVC = self.storyboard?.instantiateViewController(withIdentifier: "tapbarVC") as! tabBarController
                self.navigationController?.pushViewController(tapbarVC, animated: true)
                
            } else { // 이후에 alert로 수정 예정
                print("로그인 실패")
                let loginFailLabel = UILabel(frame: CGRect(x: 68, y: 510, width: 279, height: 45))
                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                loginFailLabel.textColor = UIColor.red
                self.view.addSubview(loginFailLabel)
            }

        }
        
             

}
    

    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
    }
}
