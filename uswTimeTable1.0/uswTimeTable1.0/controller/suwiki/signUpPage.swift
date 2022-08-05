//
//  signUpPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/21.
//

import UIKit

import Alamofire
import SafariServices
import SwiftyJSON
import SwiftUI


class signUpPage: UIViewController {

    
    @IBOutlet weak var overLapBtn: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    @IBOutlet var idTextFieldBottomLine: UIView!
    @IBOutlet var passwordTextFieldBottomLine: UIView!
    @IBOutlet var passwordCheckTextFieldBottomLine: UIView!
    

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var checkBoxBtn: UIImageView!
    
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)

    var idTypeCheck: Bool = false
    
    var addPasswordLabel = false
    var addPasswordTypeLabel = false
    var addPasswordCheckLabel = false
    
    var checkPasswordEqual = false
    var overLapCheck = false
    
    var checkBoxBool = false
    
    let loginModel = userModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overLapBtn.layer.cornerRadius = 8.0
        overLapBtn.layer.borderColor = UIColor.white.cgColor
        overLapBtn.layer.borderWidth = 1.0
        
        nextBtn.layer.cornerRadius = 13.0
        nextBtn.layer.borderWidth = 1.0
        nextBtn.layer.borderColor = UIColor.white.cgColor
        
        idTextField.addTarget(self, action: #selector(idTextFieldChangeCheck), for: .editingChanged)
        idTextField.addTarget(self, action: #selector(idTextFieldTypeCheck), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextTypeCheck), for: .editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(passwordCheckTextTypeCheck), for: .editingChanged)
        
        passwordTextField.isSecureTextEntry = true
        passwordCheckTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
        passwordCheckTextField.textContentType = .oneTimeCode

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func passwordBtnClicked(_ sender: Any) {
        
        if passwordTextField.isSecureTextEntry {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
        
    }
    
    @IBAction func passwordCheckBtnClicked(_ sender: Any) {
        
        if passwordCheckTextField.isSecureTextEntry {
            passwordCheckTextField.isSecureTextEntry = false
        } else {
            passwordCheckTextField.isSecureTextEntry = true
        }
    
    }
    
    @IBAction func serviceBtnClicked(_ sender: Any) {
        let url = NSURL(string: "https://sites.google.com/view/suwiki-policy-terms/")
        let serviceSafariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(serviceSafariView, animated: true, completion: nil)
    }
    
    @IBAction func privacyBtnClicked(_ sender: Any) {
        let url = NSURL(string: "https://sites.google.com/view/suwiki-policy-privacy")
        let privacySafariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(privacySafariView, animated: true, completion: nil)
    }
    
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        let id = idTextField.text ?? ""
        let pwd = passwordTextField.text ?? ""
        
        if overLapCheck == false {
            showAlert(title: "중복확인을 해주세요!")
        } else if loginModel.isValidId(id: id) == false{
            showAlert(title: "아이디 형식이 올바르지 않습니다.")
        } else if loginModel.isValidPassword(pwd: pwd) == false{
            showAlert(title: "비밀번호 형식이 올바르지 않습니다.")
        } else if passwordTextField.text != passwordCheckTextField.text {
            showAlert(title: "비밀번호가 일치하지 않습니다.")
            passwordTextFieldBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            passwordCheckTextFieldBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
        } else if checkBoxBool == false{
            showAlert(title: "약관에 동의해주세요!")
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "signEmailVC") as! SignUpEmailPage
            nextVC.userId = id
            nextVC.userPwd = pwd
            
            self.present(nextVC, animated: true, completion: nil)
        }

        
    }
    
    
    @IBAction func checkboxBtnClicked(_ sender: Any) {
        if checkBoxBool == true {
            checkBoxBool = false
            checkBoxBtn.image = UIImage(systemName: "square")
            checkBoxBtn.tintColor = .lightGray
        } else if checkBoxBool == false{
            checkBoxBool = true
            checkBoxBtn.image = UIImage(systemName: "checkmark.square.fill")
            checkBoxBtn.tintColor = colorLiteralBlue
        }
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
                    self.overLapCheck = true
                    self.overLapBtn.layer.borderColor = UIColor.lightGray.cgColor
                    self.overLapBtn.backgroundColor = .white
                    self.overLapBtn.tintColor = .lightGray
                    
                } else {
                    self.showAlert(title: "중복된 아이디입니다 !")
                    self.overLapCheck = false
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
    
    @objc func idTextFieldTypeCheck(_ sender: UITextField){
        guard let id = idTextField.text, !id.isEmpty else { return }
        
        let idLabel = UILabel(frame: CGRect(x: 16,
                                            y: idTextFieldBottomLine.frame.maxY + 2,
                                            width: 200,
                                            height: 18))
        
        if loginModel.isValidId(id: id){
            idTypeCheck = false
            idTextFieldBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
            
            if let removeable = self.view.viewWithTag(120){
                removeable.removeFromSuperview()
            }
            
        } else {
            idTextFieldBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            if idTypeCheck == false{
                idTypeCheck = true
                idLabel.text = "아이디 형식이 올바르지 않습니다."
                idLabel.textColor = colorLiteralPurple
                idLabel.font = idLabel.font.withSize(12)
                idLabel.tag = 120
                self.view.addSubview(idLabel)
                
                
            }
            
        }
        
        
    }
    
    @objc func idTextFieldChangeCheck(_ sender: UITextField){
        if overLapCheck == true {
            overLapBtn.layer.borderColor = UIColor.white.cgColor
            overLapBtn.backgroundColor = colorLiteralBlue
            overLapBtn.tintColor = .white
        }
        
        overLapCheck = false
        
    }
    
    
    @objc func passwordTextTypeCheck(_ sender: UITextField){
        guard let pwd = passwordTextField.text, !pwd.isEmpty else { return }

        let passwordLabel = UILabel(frame: CGRect(x: 16, y: passwordTextFieldBottomLine.frame.maxY + 2, width: 120, height: 18))
        let passwordTypeLabel = UILabel(frame: CGRect(x: 16, y: passwordTextFieldBottomLine.frame.maxY + 2, width: 200, height: 18))
        
        // changePassword()

        if passwordCheckTextField.text?.count ?? 0 > 8 {
            if passwordTextField.text == passwordCheckTextField.text {
                checkPasswordEqual = true
                
                passwordCheckTextFieldBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
                
                if let removeable = self.view.viewWithTag(101) {
                    
                    removeable.removeFromSuperview()
                    addPasswordCheckLabel = false
                    
                }
            }
        }

        
        
        if passwordTextField.text?.count ?? 0 < 8 { // if문 내부에 정규식 true 반환할 경우 추가 필요
            addPasswordTypeLabel = false // 정규식 부합한 이후 다시 8글자 아래로 수정한 이후 다시 입력할 경우

            if let removeable = self.view.viewWithTag(102) {
                removeable.removeFromSuperview()
            }
            
            passwordTextFieldBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            if addPasswordLabel == false { // 1회 실행 시
                
                addPasswordLabel = true
                passwordLabel.text = "8자 이상 입력하세요."
                passwordLabel.textColor = colorLiteralPurple
                passwordLabel.font = passwordLabel.font.withSize(12)
                passwordLabel.tag = 100
                self.view.addSubview(passwordLabel)
            
            }
            
        } else { // 8글자 이상일 경우
            addPasswordLabel = false

            if loginModel.isValidPassword(pwd: pwd){ // 정규식에 부합한 경우
                print("true")
                addPasswordTypeLabel = false // 8자 이상 입력한 이후 정규식 부합한 이후에 지웠을 때 다시 False

                if let removeable = self.view.viewWithTag(100) {
                    removeable.removeFromSuperview()
                }
                if let removeable = self.view.viewWithTag(102) {
                    removeable.removeFromSuperview()
                }
                
                passwordTextFieldBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
                
            } else { // 아닌경우
                print("false")
                if let removeable = self.view.viewWithTag(100) {
                    removeable.removeFromSuperview()
                }
                passwordTextFieldBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor

                // addPasswordLabel은 최초 작성시의 텍스트 8자 이하를 체크하기 위한 변수
                // addPasswordTypeLabel은 텍스트 변화를 체크해주는 변수이다. 즉, addPasswordCheck가 False가 되기 위해서는 텍스트 입력이 진행되어야 하고, 그 이유는 정규식에 부합하지 않을 경우 true가 되는데, addSubView를 중복으로 하여 뷰가 remove 되지 않고 남아있는것을 방지하기 위한 flag
                
                if addPasswordTypeLabel == false {
                    
                    addPasswordTypeLabel = true
                    passwordTypeLabel.text = "영문, 숫자, 특수문자를 포함하세요."
                    passwordTypeLabel.textColor = colorLiteralPurple
                    passwordTypeLabel.font = passwordTypeLabel.font.withSize(12)
                    passwordTypeLabel.tag = 102
                    self.view.addSubview(passwordTypeLabel)
                    
                }
                
            }
        }
    }
    
    
    @objc func passwordCheckTextTypeCheck(_ sender: UITextField){ // 비밀번호 일치 판별
        let passwordCheckLabel = UILabel(frame: CGRect(x: 16, y: passwordCheckTextFieldBottomLine.frame.maxY + 2, width: 190, height: 18))
        
        
        if passwordTextField.text == passwordCheckTextField.text {
            
            checkPasswordEqual = true
            
            passwordCheckTextFieldBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
            
            if let removeable = self.view.viewWithTag(101) {
                
                removeable.removeFromSuperview()
                addPasswordCheckLabel = false
                
            }
            
            
            
        } else {
            
            checkPasswordEqual = false
            
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
    
    func changePassword() {
        let passwordCheckLabel = UILabel(frame: CGRect(x: 16, y: passwordCheckTextFieldBottomLine.frame.maxY + 2, width: 190, height: 18))
        if passwordTextField.text == passwordCheckTextField.text {
            
            checkPasswordEqual = true
            
            passwordCheckTextFieldBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
            
            if let removeable = self.view.viewWithTag(101) {
                
                removeable.removeFromSuperview()
                addPasswordCheckLabel = false
                
            }
            
            
            
        } else {
            
            checkPasswordEqual = false
            
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
}
