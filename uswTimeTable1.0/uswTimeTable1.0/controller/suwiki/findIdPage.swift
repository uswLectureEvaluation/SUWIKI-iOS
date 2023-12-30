//
//  findIdPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/02.
//

import UIKit
import Alamofire
import SwiftyJSON

class findIdPage: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        
        sendBtn.layer.borderColor = UIColor.white.cgColor
        sendBtn.layer.borderWidth = 1.0
        sendBtn.layer.cornerRadius = 13.0
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendBtnClicked(_ sender: Any) {
        let url = "https://api.kr"
        
        
        let parameters = [
            "email" : "\(idTextField.text!)@suwon.ac.kr"
        ]
        showToast(message: "진행중 ...")
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            
            let checkStatus = Int(response.response!.statusCode)
            

            
            if checkStatus == 400 {
                
                let alert = UIAlertController(title:"없는 계정이거나, 잘못 입력하셨습니다.",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title:"아이디가 메일로 전송되었습니다.",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
     
            }
        }
    // 1242 2688, 1242 2208
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: sendBtn.frame.minY - 50, width: 150, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.font = UIFont(name: "Pretendard", size: 14)
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
}
