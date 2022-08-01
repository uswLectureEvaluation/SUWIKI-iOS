//
//  CompleteSignUpPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/24.
//

import UIKit

import SafariServices

class CompleteSignUpPage: UIViewController {

    
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var checkEmailBtn: UIButton!
    
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarHidden()
        
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.borderColor = colorLiteralBlue.cgColor
        loginBtn.layer.cornerRadius = 13.0
        
        checkEmailBtn.layer.borderWidth = 1.0
        checkEmailBtn.layer.borderColor = UIColor.white.cgColor
        checkEmailBtn.layer.cornerRadius = 13.0
        // Do any additional setup after loading the view.
    }


    @IBAction func loginBtnClicked(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkEmailBtnClicked(_ sender: Any) {
        let url = NSURL(string: "https://portal.suwon.ac.kr/enview/")
        let portalSafariView: SFSafariViewController = SFSafariViewController(url: url as! URL)
        self.present(portalSafariView, animated: true, completion: nil)
    }
    
    func navigationBarHidden() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
    


    
}
