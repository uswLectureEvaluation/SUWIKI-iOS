//
//  QuitAccountPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/07/29.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class QuitAccountPage: UIViewController, UITextFieldDelegate {

    //MARK: IBOutlet
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var idBottomLine: UIView!
    @IBOutlet weak var passwordBottomLine: UIView!
    @IBOutlet weak var quitBtn: UIButton!
    
    //MARK: properties
    let keychain = KeychainSwift()
    let loginmodel = userModel()
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)
    var idTypeCheck: Bool = false
    var pwdTypeCheck: Bool = false
    
    override func viewDidLoad() {
        
        quitBtn.layer.borderWidth = 1.0
        quitBtn.layer.cornerRadius = 13.0
        quitBtn.layer.borderColor = UIColor.white.cgColor
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .oneTimeCode
        
        idTextField.addTarget(self,
                              action: #selector(idTextFieldTypeCheck),
                              for: .editingChanged)
        passwordTextField.addTarget(self,
                                    action: #selector(passwordTextFieldTypeCheck),
                                    for: .editingChanged)
        
        self.idTextField.delegate = self
        self.passwordTextField.delegate = self
        
        super.viewDidLoad()
        
    }
    
    //MARK: btnAction
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func quitBtnClicked(_ sender: Any) {
        
        guard let id = idTextField.text, !id.isEmpty else {
            let alert = UIAlertController(title:"입력하신 정보가 올바르지 않습니다.",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
            return }
        guard let pwd = passwordTextField.text, !pwd.isEmpty else {
            let alert = UIAlertController(title:"입력하신 정보가 올바르지 않습니다.",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
            return }
        
        let url = "https://api.suwiki.kr/user/quit"
        
        let parameters = [
            "loginId" : id,
            "password" : pwd
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        if loginmodel.isValidId(id: idTextField.text!) &&
            loginmodel.isValidPassword(pwd: passwordTextField.text!) {
            let quitAlert = UIAlertController(title: "회원 탈퇴",
                                              message: "탈퇴 하시겠어요?",
                                              preferredStyle: UIAlertController.Style.alert)
            
            let deleteButton = UIAlertAction(title: "탈퇴",
                                             style: .destructive,
                                             handler: { [self] (action) -> Void in
                AF.request(url,
                           method: .post,
                           parameters: parameters,
                           encoding: JSONEncoding.default,
                           headers: headers,
                           interceptor: BaseInterceptor()).validate().responseJSON { response in
                    
                    if response.response?.statusCode == 200 {
                        self.keychain.clear()
                        UserDefaults.standard.set(false, forKey: "autoLogin")
                        
                        let alert = UIAlertController(title:"회원탈퇴 되었습니다.",
                            message: "확인을 눌러주세요!",
                            preferredStyle: UIAlertController.Style.alert)
                        let cancle = UIAlertAction(title: "확인", style: .default, handler: { [self]
                            (action) -> Void in
                            self.dismiss(animated: true)
                            self.dismiss(animated: true)
                        })
                        alert.addAction(cancle)
                        self.present(alert, animated: true, completion: nil)

                    } else {

                        let alert = UIAlertController(title:"입력하신 정보가 일치하지 않습니다.",
                            message: "확인을 눌러주세요!",
                            preferredStyle: UIAlertController.Style.alert)
                        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                        alert.addAction(cancle)
                        self.present(alert, animated: true, completion: nil)

                    }
                }

                
            })
            
            let cancelButton = UIAlertAction(title: "취소",
                                             style: .cancel,
                                             handler: { (action) -> Void in
            })
            
            quitAlert.addAction(deleteButton)
            quitAlert.addAction(cancelButton)
            self.present(quitAlert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title:"입력정보가 올바르지 않습니다.",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func passwordBtnClicked(_ sender: Any) {
        if passwordTextField.isSecureTextEntry{
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    //MARK: objc function
    
    @objc func idTextFieldTypeCheck(_ sender: UITextField){
        guard let id = idTextField.text, !id.isEmpty else { return }
        let idLabel = UILabel(frame: CGRect(x: 20,
                                            y: idBottomLine.frame.maxY + 2,
                                            width: 200,
                                            height: 18))
        
        if loginmodel.isValidId(id: id){
            idTypeCheck = false
            idBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
            
            if let removeable = self.view.viewWithTag(130){
                removeable.removeFromSuperview()
            }
            
        } else {
            idBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            if idTypeCheck == false {
                idTypeCheck = true
                idLabel.text = "아이디 형식이 올바르지 않습니다."
                idLabel.textColor = colorLiteralPurple
                idLabel.font = idLabel.font.withSize(12)
                idLabel.tag = 130
                self.view.addSubview(idLabel)
                
            }
        }
    }
    
    @objc func passwordTextFieldTypeCheck(_ sender: UITextField){
        guard let pwd = passwordTextField.text, !pwd.isEmpty else { return }
        let pwdlabel = UILabel(frame: CGRect(x: 20,
                                            y: passwordBottomLine.frame.maxY + 2,
                                            width: 200,
                                            height: 18))
        
        if loginmodel.isValidPassword(pwd: pwd){
            passwordBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
            pwdTypeCheck = false
            
            if let removeable = self.view.viewWithTag(131){
                removeable.removeFromSuperview()
            }
            
        } else {
            passwordBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            if pwdTypeCheck == false {
                pwdTypeCheck = true
                pwdlabel.text = "영문, 숫자, 특수문자를 포함하세요."
                pwdlabel.textColor = colorLiteralPurple
                pwdlabel.font = pwdlabel.font.withSize(12)
                pwdlabel.tag = 131
                self.view.addSubview(pwdlabel)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    //MARK: etc.
    
//    private func showToast(message : String) {
//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75,
//                                               y: nextBtn.frame.maxY,
//                                               width: 150,
//                                               height: 35))
//            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//            toastLabel.textColor = UIColor.white
//            toastLabel.font = UIFont(name: "Pretendard", size: 12)
//            toastLabel.textAlignment = .center;
//            toastLabel.text = message
//            toastLabel.alpha = 1.0
//            toastLabel.layer.cornerRadius = 10;
//            toastLabel.clipsToBounds = true
//            self.view.addSubview(toastLabel)
//            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
//                 toastLabel.alpha = 0.0
//            }, completion: {(isCompleted) in
//                toastLabel.removeFromSuperview()
//            })
//        }

}
