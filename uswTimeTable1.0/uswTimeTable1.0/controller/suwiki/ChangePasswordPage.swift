//
//  ChangePasswordPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/07/25.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift


class ChangePasswordPage: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var presentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var presentBottomLine: UIView!
    @IBOutlet weak var newBottomLine: UIView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    let loginModel = userModel()
    let keychain = KeychainSwift()
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)
    
    var addTextFieldLengthCheck: Bool = false
    var addTextFieldTypeCheck: Bool = false

    var addNewTextFieldLengthCheck: Bool = false
    var addNewTextFieldTypeCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentPasswordTextField.isSecureTextEntry = true
        presentPasswordTextField.textContentType = .oneTimeCode
        
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.textContentType = .oneTimeCode

        nextBtn.layer.cornerRadius = 13.0
        nextBtn.layer.borderColor = UIColor.white.cgColor
        nextBtn.layer.borderWidth = 1.0
        
        presentPasswordTextField.addTarget(self,
                                           action: #selector(passwordTextTypeCheck),
                                           for: .touchDown)
        presentPasswordTextField.addTarget(self,
                                           action: #selector(passwordTextTypeCheck),
                                           for: .editingChanged)
        newPasswordTextField.addTarget(self,
                                       action: #selector(newPasswordTextTypeCheck),
                                       for: .touchDown)
        newPasswordTextField.addTarget(self,
                                       action: #selector(newPasswordTextTypeCheck),
                                       for: .editingChanged)
        
        self.presentPasswordTextField.delegate = self
        self.newPasswordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - btnAction
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func nextBtnClicked(_ sender: Any) {
        let prePassword = presentPasswordTextField.text ?? ""
        let newPassword = newPasswordTextField.text ?? ""
        
        if loginModel.isValidPassword(pwd: prePassword) == false ||
            loginModel.isValidPassword(pwd: newPassword) == false{
            showAlert(title: "비밀번호 형식이 올바르지 않습니다.")
        } else if presentPasswordTextField.text == newPasswordTextField.text {
            showAlert(title: "기존 비밀번호와 일치합니다.")
        } else {
            resetPassword(prePassword: prePassword, newPassword: newPassword)
            showToast(message: "변경 진행중...")
        }
    }
    
    @IBAction func presentPasswordBtnClicked(_ sender: Any) {
        
        if presentPasswordTextField.isSecureTextEntry{
            presentPasswordTextField.isSecureTextEntry = false
        } else {
            presentPasswordTextField.isSecureTextEntry = true
        }
        
    }
    
    @IBAction func newPasswordBtnClicked(_ sender: Any) {
        
        if newPasswordTextField.isSecureTextEntry{
            newPasswordTextField.isSecureTextEntry = false
        } else {
            newPasswordTextField.isSecureTextEntry = true
        }
        
    }
    
    //MARK: - API Function
    
    private func resetPassword(prePassword: String, newPassword: String) {
        let url = "https://api.suwiki.kr/user/reset-pw"
        
        let parameters = [
            "prePassword" : prePassword,
            "newPassword" : newPassword
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: BaseInterceptor()).validate().responseJSON { response in
            
            print(JSON(response.data))
            
            if response.response?.statusCode == 400 {
                self.showAlert(title: "기존 비밀번호가 일치하지 않습니다.")
            } else {
                self.showToast(message: "변경 완료!")
                self.dismiss(animated: true)
                
            }
        }
    }
    
    //MARK: - objc passwordChange
    
    @objc func passwordTextTypeCheck(_ sender: UITextField) {
        guard let pwd = presentPasswordTextField.text, !pwd.isEmpty else { return }
        
        let presentLabel = UILabel(frame: CGRect(x: 20,
                                                 y: presentBottomLine.frame.maxY + 2,
                                                 width: 120,
                                                 height: 18))
        let presentTypeLabel = UILabel(frame: CGRect(x: 20,
                                                     y: presentBottomLine.frame.maxY + 2,
                                                     width: 200,
                                                     height: 18)) // 정규식 레이블
        
        if presentPasswordTextField.text?.count ?? 0 < 8 { // 비밀번호 8자 이하 입력 시
            
            addTextFieldTypeCheck = false
            
            presentBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            if let removeable = self.view.viewWithTag(111) {
                removeable.removeFromSuperview()
            }
            
            if addTextFieldLengthCheck == false {
                
                addTextFieldLengthCheck = true
                presentLabel.text = "8자 이상 입력하세요"
                presentLabel.textColor = colorLiteralPurple
                presentLabel.font = UIFont(name: "Pretendard", size: 12)
                presentLabel.tag = 110
                self.view.addSubview(presentLabel)
                
            }
            
        } else { // 8자 이상 입력 시
            
            addTextFieldLengthCheck = false
            
            
            if loginModel.isValidPassword(pwd: pwd) { // 비밀번호 정규식에 부합한 경우
                    
                addTextFieldTypeCheck = false
                
                if let removeable = self.view.viewWithTag(110) {
                    removeable.removeFromSuperview()
                }
                
                if let removeable = self.view.viewWithTag(111) {
                    removeable.removeFromSuperview()
                }
                
                presentBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
                
            } else { // 비밀번호 정규식에 부합하지 않은 경우
                
                if let removeable = self.view.viewWithTag(110) {
                    removeable.removeFromSuperview()
                }
                
                presentBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
                
                if addTextFieldTypeCheck == false {
                    addTextFieldTypeCheck = true
                    presentTypeLabel.text = "영문, 숫자, 특수문자를 포함하세요."
                    presentTypeLabel.textColor = colorLiteralPurple
                    presentTypeLabel.font = UIFont(name: "Pretendard", size: 12)
                    presentTypeLabel.tag = 111
                    self.view.addSubview(presentTypeLabel)
        
                }
            }
        }
    }
    
    @objc func newPasswordTextTypeCheck(_ sender: UITextField) {
        guard let pwd = newPasswordTextField.text, !pwd.isEmpty else { return }
        
        
        let newlabel =  UILabel(frame: CGRect(x: 20,
                                              y: newBottomLine.frame.maxY + 2,
                                              width: 200,
                                              height: 18))
 
        let newTypeLabel = UILabel(frame: CGRect(x: 20,
                                                     y: newBottomLine.frame.maxY + 2,
                                                     width: 200,
                                                     height: 18))
        
        if newPasswordTextField.text?.count ?? 0 < 8 { // 비밀번호 8자 이하 입력 시
            
            addNewTextFieldTypeCheck = false
            
            newBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            if let removeable = self.view.viewWithTag(115) {
                removeable.removeFromSuperview()
            }
            
            if addNewTextFieldLengthCheck == false {
                
                addNewTextFieldLengthCheck = true
                newlabel.text = "8자 이상 입력하세요"
                newlabel.textColor = colorLiteralPurple
                newlabel.font = UIFont(name: "Pretendard", size: 12)
                newlabel.tag = 114
                self.view.addSubview(newlabel)
                
            }
            
        } else { // 8자 이상 입력 시
            
            addNewTextFieldLengthCheck = false
            
            if loginModel.isValidPassword(pwd: pwd) { // 비밀번호 정규식에 부합한 경우
                addNewTextFieldTypeCheck = false
                
                if let removeable = self.view.viewWithTag(114) {
                    removeable.removeFromSuperview()
                }
                
                if let removeable = self.view.viewWithTag(115) {
                    removeable.removeFromSuperview()
                }
                
                newBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
                
            } else { // 비밀번호 정규식에 부합하지 않은 경우
                
                if let removeable = self.view.viewWithTag(114) {
                    removeable.removeFromSuperview()
                }
                
                newBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
                
                if addNewTextFieldTypeCheck == false {
                    addNewTextFieldTypeCheck = true
                    newTypeLabel.text = "영문, 숫자, 특수문자를 포함하세요."
                    newTypeLabel.textColor = colorLiteralPurple
                    newTypeLabel.font = UIFont(name: "Pretendard", size: 12)
                    newTypeLabel.tag = 115
                    self.view.addSubview(newTypeLabel)
        
                }
            }
        }
    }
    
    //MARK: etc.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == presentPasswordTextField {
            newPasswordTextField.becomeFirstResponder()
        } else {
            newPasswordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    private func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75,
                                               y: nextBtn.frame.maxY,
                                               width: 150,
                                               height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.font = UIFont(name: "Pretendard", size: 12)
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: "확인 버튼을 눌러주세요!",
                                      preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true,completion: nil)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    
}
