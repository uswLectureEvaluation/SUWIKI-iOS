//
//  QuitAccountPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/07/29.
//

import UIKit

class QuitAccountPage: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var idBottomLine: UIView!
    @IBOutlet weak var passwordBottomLine: UIView!
    @IBOutlet weak var quitBtn: UIButton!
    
    //MARK: properties
    
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
        passwordTextField.textContentType = .none
        
        idTextField.addTarget(self,
                              action: #selector(idTextFieldTypeCheck),
                              for: .editingChanged)
        passwordTextField.addTarget(self,
                                    action: #selector(passwordTextFieldTypeCheck),
                                    for: .editingChanged)
        
        super.viewDidLoad()
        
    }
    
    //MARK: btnAction
    
    @IBAction func quitBtnClicked(_ sender: Any) {
    }
    
    
    
    //MARK: objc function
    
    @objc func idTextFieldTypeCheck(_ sender: UITextField){
        guard let id = idTextField.text, !id.isEmpty else { return }
        let idLabel = UILabel(frame: CGRect(x: 16,
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
        let pwdlabel = UILabel(frame: CGRect(x: 16,
                                            y: passwordBottomLine.frame.maxY + 2,
                                            width: 200,
                                            height: 18))
        
        if loginmodel.isValidPassword(pwd: pwd){
            
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

}
