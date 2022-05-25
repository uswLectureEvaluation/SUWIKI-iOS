//
//  CompleteSignUpPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/24.
//

import UIKit

class CompleteSignUpPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarHidden()
        
        // Do any additional setup after loading the view.
    }


    @IBAction func loginBtnClicked(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkEmailBtnClicked(_ sender: Any) {
    }
    
    func navigationBarHidden() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
    


    
}
