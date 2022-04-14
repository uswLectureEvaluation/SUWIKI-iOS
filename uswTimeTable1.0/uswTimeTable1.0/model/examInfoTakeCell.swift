//
//  examInfoTakeCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/12.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift

class examInfoTakeCell: UITableViewCell {
    
    let keychain = KeychainSwift()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func takeInfoBtnClicked(_ sender: Any) {
        let AD = UIApplication.shared.delegate as? AppDelegate
        let lectureId = Int(AD?.lectureId ?? 0)
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]

        let url = "https://api.suwiki.kr/exam-posts/buyExamInfo/?lectureId=\(lectureId)"
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let data = response.response?.statusCode
            if Int(data!) == 200{
                print("success")
                
            } else if Int(data!) == 403{
                print("fail")
                
            }
            
        }
    }
    
}
