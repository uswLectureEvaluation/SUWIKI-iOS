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

    let bottomLine1 = CALayer()
    let bottomLine2 = CALayer()

    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)
    
    
    var checkBoxBool = false
    
    @IBOutlet weak var checkBoxBtn: UIImageView!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        keychain.clear()
        self.navigationItem.hidesBackButton = true
        
        print(UserDefaults.standard.string(forKey: "id"))
        print(UserDefaults.standard.string(forKey: "pwd"))

        
        idTextField.addTarget(self, action: #selector(idTextFieldClicked), for: .touchDown)
        idTextField.addTarget(self, action: #selector(idTextFieldClicked), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldClicked), for: .touchDown)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldClicked), for: .editingChanged)
        
        passwordTextField.isSecureTextEntry = true
        //cell.adjustBtn.addTarget(self, action: #selector(adjustEvaluationBtnClicked), for: .touchUpInside)
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func autoLoginBtnClicked(_ sender: Any) {
        if checkBoxBool == true {
            UserDefaults.standard.set(false, forKey: "autoLogin")
            checkBoxBool = false
            checkBoxBtn.image = UIImage(systemName: "square")
            checkBoxBtn.tintColor = .lightGray
        } else if checkBoxBool == false{
            UserDefaults.standard.set(true, forKey: "autoLogin")
            checkBoxBool = true
            checkBoxBtn.image = UIImage(systemName: "checkmark.square.fill")
            checkBoxBtn.tintColor = colorLiteralBlue
        }
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

    @IBAction func passwordCheckBtnClicked(_ sender: Any) {
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
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
            
            print(json)
            print(parameters)
            
            if accessToken != "" {
 
                print("로그인 성공")
                self.keychain.set(accessToken, forKey: "AccessToken")
                self.keychain.set(refreshToken, forKey: "RefreshToken")

                
                print(self.keychain.get("AccessToken") ?? "")
                print(self.keychain.get("RefreshToken") ?? "")
                
                self.dismiss(animated: true, completion: nil)
                
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
        self.present(findIdVC, animated: true, completion: nil)
    }
    
    @IBAction func findPwdBtnClicked(_ sender: Any) {
        let findPwdVC = self.storyboard?.instantiateViewController(withIdentifier: "findPwdVC") as! findPwdPage
        self.navigationController?.pushViewController(findPwdVC, animated: true)
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpPage
        self.present(signUpVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(signUpVC, animated: true)
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
