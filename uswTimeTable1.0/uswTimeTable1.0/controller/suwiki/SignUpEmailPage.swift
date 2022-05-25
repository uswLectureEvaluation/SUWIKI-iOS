//
//  SignUpEmailPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/24.
//

import UIKit

import Alamofire
import SwiftyJSON

class SignUpEmailPage: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    let loginModel = userModel()
    
    var userId = ""
    var userPwd = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func singUpBtnClicked(_ sender: Any) {
        let email = emailTextField.text ?? ""
        
        let url = "https://api.suwiki.kr/user/check-email"
        let parameters = [
            "email" : email
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data ?? "")
            print(json)
            if json["overlap"].boolValue == false {
                self.requestJoin(id: self.userId, pwd: self.userPwd, email: email)
            } else {
                self.showAlert(title: "중복된 이메일입니다 !")
            }
            
        }
    }
    
    func requestJoin(id: String, pwd: String, email: String){
        let url = "https://api.suwiki.kr/user/join"
        let parameters = [
            "loginId" : id,
            "password" : pwd,
            "email" : "\(email)@suwon.ac.kr"
        ]
        
        print(parameters)
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "completeVC") as! CompleteSignUpPage
            self.present(nextVC, animated: true, completion: nil)
            /*
            if response.response?.statusCode == 403 {
                self.showAlert(title: "블랙리스트 유저입니다.")
            } else if response.response?.statusCode == 400{
                self.showAlert(title: "이미 가입된 유저 이메일입니다.")
            } else {
                
            }
             */
                        
        }
        
    }
    
    
    
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "확인 버튼을 눌러주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true,completion: nil)
    }

}
