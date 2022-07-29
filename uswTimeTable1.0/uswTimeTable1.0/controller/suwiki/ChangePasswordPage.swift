//
//  ChangePasswordPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/07/25.
//

import UIKit

class ChangePasswordPage: UIViewController {

    
    @IBOutlet weak var presentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var presentBottomLine: UIView!
    @IBOutlet weak var newBottomLine: UIView!
    
    let loginModel = userModel()
    
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)
    
    var addTextFieldLengthCheck: Bool = false
    var addTextFieldTypeCheck: Bool = false
    
    var equalPassword: Bool = false
    var equalPasswordView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentPasswordTextField.isSecureTextEntry = true
        presentPasswordTextField.textContentType = .none
        
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.textContentType = .none

        presentPasswordTextField.addTarget(self,
                                           action: #selector(passwordTextTypeCheck),
                                           for: .touchDown)
        presentPasswordTextField.addTarget(self,
                                           action: #selector(passwordTextTypeCheck),
                                           for: .editingChanged)
        // Do any additional setup after loading the view.
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
            
            if addTextFieldLengthCheck == false {
                
                addTextFieldLengthCheck = true
                presentLabel.text = "8자 이상 입력하세요"
                presentLabel.textColor = colorLiteralPurple
                presentLabel.font = UIFont(name: "Pretendard", size: 12)
                presentLabel.tag = 100
                self.view.addSubview(presentLabel)
                
            }
            
        } else { // 8자 이상 입력 시
            
            addTextFieldLengthCheck = false
            
            if loginModel.isValidPassword(pwd: pwd) { // 비밀번호 정규식에 부합한 경우
                
                if let removeable = self.view.viewWithTag(100) {
                    removeable.removeFromSuperview()
                }
                
                if let removeable = self.view.viewWithTag(101) {
                    removeable.removeFromSuperview()
                }
                
                presentBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
                
            } else { // 비밀번호 정규식에 부합하지 않은 경우
                
                if let removeable = self.view.viewWithTag(100) {
                    removeable.removeFromSuperview()
                }
                
                presentBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
                
                if addTextFieldTypeCheck == false {
                    addTextFieldTypeCheck = true
                    presentTypeLabel.text = "영문, 숫자, 특수문자를 포함하세요."
                    presentTypeLabel.textColor = colorLiteralPurple
                    presentTypeLabel.font = UIFont(name: "Pretendard", size: 12)
                    presentTypeLabel.tag = 101
                    self.view.addSubview(presentTypeLabel)
        
                }
            }
        }
    }
    
    @objc func newPasswordTypeCheck(_ sender: UITextField) {
        guard let pwd = presentPasswordTextField.text, !pwd.isEmpty else { return }
        
        let newTypeLabel = UILabel(frame: CGRect(x: 20,
                                                     y: newBottomLine.frame.maxY + 2,
                                                     width: 200,
                                                     height: 18))
        
        if newPasswordTextField.text == presentPasswordTextField.text {
            equalPasswordView = false
            equalPassword = true
            newBottomLine.layer.backgroundColor = colorLiteralBlue.cgColor
            
            if let removeable = self.view.viewWithTag(102) {
                removeable.removeFromSuperview()
            }
            
        } else {
            equalPassword = false
            newBottomLine.layer.backgroundColor = colorLiteralPurple.cgColor
            
            if equalPasswordView == false {
                equalPasswordView = true
                newTypeLabel.text = "비밀번호가 일치하지 않습니다."
                newTypeLabel.textColor = colorLiteralPurple
                newTypeLabel.font = UIFont(name: "Pretendard", size: 12)
                newTypeLabel.tag = 102
                self.view.addSubview(newTypeLabel)
            }
            
        }
    }
    
    
    
}
