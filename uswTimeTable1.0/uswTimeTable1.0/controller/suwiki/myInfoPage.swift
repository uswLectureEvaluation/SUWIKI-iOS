//
//  myInfoPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/11.
//

import UIKit

import Alamofire
import SafariServices
import SwiftyJSON
import KeychainSwift
import GoogleMobileAds

class myInfoPage: UIViewController {

    @IBOutlet weak var loginInfoView: UIView!
    @IBOutlet weak var loginPointView: UIView!
    @IBOutlet weak var logoutInfoView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
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
    @IBOutlet weak var loginBtn: UIButton!
    
    
    let keychain = KeychainSwift()
    
    var userInfo = MyInfo(loginId: "", email: "", point: 0, writtenEvaluation: 0, writtenExam: 0, viewExam: 0)
    
    override func viewDidLoad() {
        makeCornerRadius()
        navigationBarHidden()
        navigationBackSwipeMotion()
        super.viewDidLoad()
        imageView.isHidden = false
        loginInfoView.isHidden = true
        loginPointView.isHidden = true
        loginInformation.isHidden = true
        loginPointPolicy.isHidden = true
        writtenPostBtn.isHidden = true
        logoutInfoView.isHidden = false
        logoutPointPolicy.isHidden = false
        logoutInformation.isHidden = false
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
    
    @IBAction func feedbackBtnClicked(_ sender: Any) {let url = NSURL(string: "https://forms.gle/tZByKoN6rJCysvNz6")
        let feedbackSafariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(feedbackSafariView, animated: true, completion: nil)
    }
    
    @IBAction func askBtnClicked(_ sender: Any) {
//        NSURL(string: "https://forms.gle/tZByKoN6rJCysvNz6")
//        let askSafariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
//        self.present(askSafariView, animated: true, completion: nil)
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
                
                if response.response?.statusCode != 500 {
                    print(json)
                    
                    var readUserData = MyInfo(loginId: json["loginId"].stringValue, email: json["email"].stringValue, point: json["point"].intValue, writtenEvaluation: json["writtenEvaluation"].intValue, writtenExam: json["writtenExam"].intValue, viewExam: json["viewExam"].intValue)
                    
                    self.userInfo = readUserData
                    self.logoutInfoView.isHidden = true
                    self.logoutPointPolicy.isHidden = true
                    self.logoutInformation.isHidden = true
                    self.imageView.isHidden = true
                    
                    
                    self.viewUpdate()
                    self.loginInfoView.isHidden = false
                    self.loginPointView.isHidden = false
                    self.loginInformation.isHidden = false
                    self.loginPointPolicy.isHidden = false
                    self.writtenPostBtn.isHidden = false
                    
                } else {
                    
                    self.loginInfoView.isHidden = true
                    self.loginPointView.isHidden = true
                    self.loginInformation.isHidden = true
                    self.loginPointPolicy.isHidden = true
                    self.writtenPostBtn.isHidden = true
                    
                    
                    self.logoutInfoView.isHidden = false
                    self.logoutPointPolicy.isHidden = false
                    self.logoutInformation.isHidden = false
                    
                }
                
            }
        } else {
            
            loginInfoView.isHidden = true
            loginPointView.isHidden = true
            loginInformation.isHidden = true
            loginPointPolicy.isHidden = true
            writtenPostBtn.isHidden = true
            
            imageView.isHidden = false
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
        
    
        
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.cornerRadius = 10.0
        
        writtenPostBtn.layer.borderWidth = 1.0
        writtenPostBtn.layer.borderColor = UIColor.white.cgColor
        writtenPostBtn.layer.cornerRadius = 10.0
        
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
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        
        let logoutAlert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠어요?", preferredStyle: UIAlertController.Style.alert)
        
        let logoutButton = UIAlertAction(title: "로그아웃", style: .destructive, handler: { [self] (action) -> Void in
            keychain.clear()
            UserDefaults.standard.set(false, forKey: "autoLogin")
            viewDidLoad()
        })
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        logoutAlert.addAction(logoutButton)
        logoutAlert.addAction(cancelButton)
        present(logoutAlert, animated: true, completion: nil)

    }
    
    @IBAction func writtenPostBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "writtenPostVC") as! writtenPostPage
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    
    @IBAction func announcementBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "announcementVC") as! announcementPage
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func purchaseHistoryBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "purchaseVC") as! PurchaseHistoryPage
        present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func passwordChangeBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "changePasswdVC") as! ChangePasswordPage
        present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func quitAccountPageBtnClicked(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "QuitVC") as! QuitAccountPage
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true, completion: nil)
    }
    
    
}
