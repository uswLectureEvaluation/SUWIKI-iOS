//
//  announcementDetailPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/19.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class announcementDetailPage: UIViewController {
    
    let keychain = KeychainSwift()
    
    var noticeId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getAnnouncementDetailPage() {
        
        let url = "https://api.suwiki.kr/notice/?noticeId=\(noticeId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            
            let data = response.data
            let json = JSON(data ?? "")
                
            if json != "" {
                
            }
            
        }
    }


}
