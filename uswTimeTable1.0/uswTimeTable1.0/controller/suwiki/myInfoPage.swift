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
    
    
    @IBOutlet weak var logoutPointPolicy: UIView!
    @IBOutlet weak var loginPointPolicy: UIView!
    
    @IBOutlet weak var logoutInformation: UIView!
    @IBOutlet weak var loginInformation: UIView!
    
    @IBOutlet weak var loginIdLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var userTotalPointLabel: UILabel!
    
    @IBOutlet weak var writtenEvalNumber: UILabel!
    @IBOutlet weak var writtenExamNumber: UILabel!
    @IBOutlet weak var viewExamNumber: UILabel!
    
    
    @IBOutlet weak var writtenEvalPoint: UILabel!
    @IBOutlet weak var writtenExamPoint: UILabel!
    @IBOutlet weak var viewExamPoint: UILabel!
    
    @IBOutlet weak var writtenPostBtn: UIButton!
    
    
    let keychain = KeychainSwift()
    
    var userInfo = MyInfo(loginId: "", email: "", point: 0, writtenEvaluation: 0, writtenExam: 0, viewExam: 0)
    
    override func viewDidLoad() {
        makeCornerRadius()
        navigationBarHidden()
        navigationBackSwipeMotion()
        super.viewDidLoad()
        loginInfoView.isHidden = true
        loginPointView.isHidden = true
        loginInformation.isHidden = true
        loginPointPolicy.isHidden = true
        writtenPostBtn.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInfoData()
        print("viewwillappear")
        print(keychain.get("AccessToken"))
        print(keychain.get("RefreshToken"))
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
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(nextVC, animated: true)
        
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
                
                print(json)
                
                var readUserData = MyInfo(loginId: json["loginId"].stringValue, email: json["email"].stringValue, point: json["point"].intValue, writtenEvaluation: json["writtenEvaluation"].intValue, writtenExam: json["writtenExam"].intValue, viewExam: json["viewExam"].intValue)
                
                self.userInfo = readUserData
                self.logoutInfoView.isHidden = true
                self.logoutPointPolicy.isHidden = true
                self.logoutInformation.isHidden = true
                
                self.viewUpdate()
                self.loginInfoView.isHidden = false
                self.loginPointView.isHidden = false
                self.loginInformation.isHidden = false
                self.loginPointPolicy.isHidden = false
                self.writtenPostBtn.isHidden = false
                
                
            }
        } else {
            loginInfoView.isHidden = true
            loginPointView.isHidden = true
            loginInformation.isHidden = true
            loginPointPolicy.isHidden = true
            writtenPostBtn.isHidden = true
            
            
            logoutInfoView.isHidden = false
            logoutPointPolicy.isHidden = false
            logoutInformation.isHidden = false
            
        }
    }
    
    func viewUpdate(){
        loginIdLabel.text = userInfo.loginId
        emailLabel.text = userInfo.email
        userTotalPointLabel.text = "\(userInfo.point)P"
        
        writtenEvalNumber.text = "\(userInfo.writtenEvaluation)"
        writtenExamNumber.text = "\(userInfo.writtenExam)"
        viewExamNumber.text = "\(userInfo.viewExam)"
        
        writtenEvalPoint.text = "+\(userInfo.writtenEvaluation * 10)"
        writtenExamPoint.text = "+\(userInfo.writtenExam * 20)"
        viewExamPoint.text = "-\(userInfo.viewExam * 20)"
        
    }
    
    func makeCornerRadius(){
        
        loginInformation.layer.cornerRadius = 12.0
        loginInformation.layer.borderWidth = 1.0
        loginInformation.layer.borderColor = UIColor.lightGray.cgColor
        
        loginPointPolicy.layer.cornerRadius = 12.0
        loginPointPolicy.layer.borderWidth = 1.0
        loginPointPolicy.layer.borderColor = UIColor.lightGray.cgColor
        
        loginInfoView.layer.cornerRadius = 12.0
        loginInfoView.layer.borderWidth = 1.0
        loginInfoView.layer.borderColor = UIColor.lightGray.cgColor
        
        loginPointView.layer.cornerRadius = 12.0
        loginPointView.layer.borderWidth = 1.0
        loginPointView.layer.borderColor = UIColor.lightGray.cgColor
        
        
        logoutInformation.layer.cornerRadius = 12.0
        logoutInformation.layer.borderWidth = 1.0
        logoutInformation.layer.borderColor = UIColor.lightGray.cgColor
        
        logoutPointPolicy.layer.cornerRadius = 12.0
        logoutPointPolicy.layer.borderWidth = 1.0
        logoutPointPolicy.layer.borderColor = UIColor.lightGray.cgColor
        
        logoutInfoView.layer.cornerRadius = 12.0
        logoutInfoView.layer.borderWidth = 1.0
        logoutInfoView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    @IBAction func writtenPostBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "writtenPostVC") as! writtenPostPage
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @IBAction func announcementBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "announcementVC") as! announcementPage
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func purchaseHistoryBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "purchaseVC") as! PurchaseHistoryPage
        self.present(nextVC, animated: true, completion: nil)
    }
    
    
}
