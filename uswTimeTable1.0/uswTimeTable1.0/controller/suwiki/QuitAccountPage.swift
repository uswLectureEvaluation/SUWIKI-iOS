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
    
    
    
    override func viewDidLoad() {
        
        quitBtn.layer.borderWidth = 1.0
        quitBtn.layer.cornerRadius = 13.0
        quitBtn.layer.borderColor = UIColor.white.cgColor
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .none
        
        super.viewDidLoad()
        
    }
    
    //MARK: btnAction
    
    @IBAction func quitBtnClicked(_ sender: Any) {
    }
    
    

}
