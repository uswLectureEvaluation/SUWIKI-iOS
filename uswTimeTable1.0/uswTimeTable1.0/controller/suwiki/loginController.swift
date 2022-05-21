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
import SwiftUI


// 로그인 된 경우 메인페이지로 이동
class loginController: UIViewController {

    
    @IBOutlet weak var idTextFieldLine: UIView!
    @IBOutlet var passwordTextFieldLine: UIView!
    
    let keychain = KeychainSwift()
    let loginModel = userModel()
    var useAutoLogin = 0

    let bottomLine1 = CALayer()
    let bottomLine2 = CALayer()

    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)

    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        keychain.clear()
        self.navigationItem.hidesBackButton = true
        
        print(UserDefaults.standard.string(forKey: "id"))
        print(UserDefaults.standard.string(forKey: "pwd"))
        if (UserDefaults.standard.value(forKey: "id") != nil) == true{
            useAutoLogin = 1
            loginCheck(id: UserDefaults.standard.string(forKey: "id")!, pwd: UserDefaults.standard.string(forKey: "pwd")!)
        }
        
        idTextField.addTarget(self, action: #selector(idTextFieldClicked), for: .touchDown)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldClicked), for: .touchDown)
        
        //cell.adjustBtn.addTarget(self, action: #selector(adjustEvaluationBtnClicked), for: .touchUpInside)
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        /*
        bottomLine1.frame = CGRect(x: 0, y: idTextField.frame.size.height + 16, width: idTextField.frame.width, height: 1)
        bottomLine1.borderColor = UIColor.systemGray2.cgColor
        bottomLine1.borderWidth = 1.0
        idTextField.borderStyle = .none
        idTextField.layer.addSublayer(bottomLine1)
        
        bottomLine2.frame = CGRect(x: 0, y: passwordTextField.frame.size.height + 16, width: passwordTextField.frame.width, height: 1)
        bottomLine2.borderColor = UIColor.systemGray2.cgColor
        bottomLine2.borderWidth = 1.0
        passwordTextField.borderStyle = .none
        passwordTextField.layer.addSublayer(bottomLine2)
        */
    }
    
    
    @IBAction func loginButton (_ sender: Any) {
        guard let id = idTextField.text, !id.isEmpty else { return }
        guard let pwd = passwordTextField.text, !pwd.isEmpty else { return }

        let emailLabel = UILabel(frame: CGRect(x: 30, y: idTextField.frame.maxY+5, width: 279, height: 25))
        let passwordLabel = UILabel(frame: CGRect(x: 30, y: passwordTextField.frame.maxY+5, width: 279, height: 25))
        
    
        if loginModel.isValidId(id: id){
            if let removeable = self.view.viewWithTag(100){
                removeable.removeFromSuperview()
                idTextFieldLine.layer.backgroundColor = UIColor.lightGray.cgColor
            }
        } else {
            emailLabel.isHidden = false
            emailLabel.text = "아이디 형식을 확인해 주세요"
            emailLabel.textColor = UIColor.red
            emailLabel.tag = 100
            idTextFieldLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            self.view.addSubview(emailLabel)
        } // 아이디 형식 오류
            
        if loginModel.isValidPassword(pwd: pwd){
            if let removeable = self.view.viewWithTag(101){
                removeable.removeFromSuperview()
                passwordTextFieldLine.layer.backgroundColor = UIColor.lightGray.cgColor
            }
        } else {
            passwordLabel.isHidden = false
            passwordLabel.text = "비밀번호 형식을 확인해 주세요"
            passwordLabel.textColor = UIColor.red
            passwordLabel.tag = 101
            passwordTextFieldLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            self.view.addSubview(passwordLabel)
        } // 비밀번호 형식 오류
            
        if loginModel.isValidId(id: id) && loginModel.isValidPassword(pwd: pwd) { // 형식이 맞을 경우 로그인 확인
            loginCheck(id: id, pwd: pwd)
        }
        
    }

    
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
                if self.useAutoLogin == 1 || (UserDefaults.standard.value(forKey: "id") == nil) == true{
                    UserDefaults.standard.set(id, forKey: "id")
                    UserDefaults.standard.set(pwd, forKey: "pwd")
                }
                print("로그인 성공")
                self.keychain.set(accessToken, forKey: "AccessToken")
                self.keychain.set(refreshToken, forKey: "RefreshToken")

                
                print(self.keychain.get("AccessToken") ?? "")
                print(self.keychain.get("RefreshToken") ?? "")
                
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "homePageVC") as! suwikiHomePage
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            } else { // 이후에 alert로 수정 예정
                print("로그인 실패")
                let loginFailLabel = UILabel(frame: CGRect(x: 30, y: self.loginBtn.frame.minY - 5, width: 279, height: 45))
                loginFailLabel.text = "아이디나 비밀번호가 다릅니다."
                loginFailLabel.textColor = UIColor.red
                self.view.addSubview(loginFailLabel)
            }
        }
    }
    
    @IBAction func findIdBtnClicked(_ sender: Any) {
        let findIdVC = self.storyboard?.instantiateViewController(withIdentifier: "findIdVC") as! findIdPage
        self.navigationController?.pushViewController(findIdVC, animated: true)
    }
    
    @IBAction func findPwdBtnClicked(_ sender: Any) {
        let findPwdVC = self.storyboard?.instantiateViewController(withIdentifier: "findPwdVC") as! findPwdPage
        self.navigationController?.pushViewController(findPwdVC, animated: true)
    }
    
    @objc func didEndOnExit(_ sender: UITextField) {
        if idTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    @objc func idTextFieldClicked(_ sender: UITextField){
        idTextFieldLine.layer.backgroundColor = colorLiteralBlue.cgColor
        passwordTextFieldLine.layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
    @objc func passwordTextFieldClicked(_ sender: UITextField) {
        idTextFieldLine.layer.backgroundColor = UIColor.lightGray.cgColor
        passwordTextFieldLine.layer.backgroundColor = colorLiteralBlue.cgColor
    }
    
}
