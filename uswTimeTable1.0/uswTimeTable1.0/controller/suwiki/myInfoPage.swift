//
//  myInfoPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/11.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class myInfoPage: UIViewController {

    @IBOutlet weak var loginInfoView: UIView!
    @IBOutlet weak var loginPointView: UIView!
    @IBOutlet weak var logoutInfoView: UIView!
    
    
    @IBOutlet weak var loginIdLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var userTotalPointLabel: UILabel!
    
    let keychain = KeychainSwift()
    
    var userInfo = MyInfo(loginId: "", email: "", point: 0, writtenEvaluation: 0, writtenExam: 0, viewExam: 0)
    
    override func viewDidLoad() {
        navigationBarHidden()
        navigationBackSwipeMotion()
        super.viewDidLoad()
        loginInfoView.isHidden = true
        loginPointView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInfoData()
    }
    
    // UserDefaults.standard.removeObject(forKey: "id")
    // UserDefaults.standard.removeObject(forKey: "pwd")
    
    @IBAction func testLogout(_ sender: Any) {
        keychain.clear()
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pwd")
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginController
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
    
    func getInfoData(){
        if let accessToken = keychain.get("AccessToken"){
            
            let url = "https://api.suwiki.kr/user/my-page"
            let headers: HTTPHeaders = [
                "Authorization" : String(accessToken)
            ]
            
            AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
                let data = response.data
                let json = JSON(data!)
                
                var readUserData = MyInfo(loginId: json["loginId"].stringValue, email: json["email"].stringValue, point: json["point"].intValue, writtenEvaluation: json["writtenEvaluation"].intValue, writtenExam: json["writtenExam"].intValue, viewExam: json["viewExam"].intValue)
                
                self.userInfo = readUserData
                self.logoutInfoView.isHidden = true
                
                self.viewUpdate()
                self.loginInfoView.isHidden = false
                self.loginPointView.isHidden = false
            }
        } else {
            loginInfoView.isHidden = true
            loginPointView.isHidden = true
            logoutInfoView.isHidden = false
        }
    }
    
    func viewUpdate(){
        loginIdLabel.text = userInfo.loginId
        emailLabel.text = userInfo.email
        userTotalPointLabel.text = "\(userInfo.point)P"
    }
    

}
