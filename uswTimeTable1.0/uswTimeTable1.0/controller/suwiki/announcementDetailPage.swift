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
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var modifiedDateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    let keychain = KeychainSwift()
    
    var noticeId: Int = 0
    
    var announcementDetailPageData: Array<announceDetailPage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAnnouncementDetailPage()
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
            
            print(json)
            
            if json != "" {
                let jsonData = json["data"]
                let readData = announceDetailPage(id: jsonData["id"].intValue, title: jsonData["title"].stringValue, modifiedDate: jsonData["modifiedDate"].stringValue, content: jsonData["content"].stringValue)
                
                self.announcementDetailPageData.append(readData)
            }
            self.detailViewUpdate()
            print(self.announcementDetailPageData)
        }
    }
    
    func detailViewUpdate() {
        titleLabel.text = announcementDetailPageData[0].title
        modifiedDateLabel.text = announcementDetailPageData[0].modifiedDate
        contentLabel.text = announcementDetailPageData[0].content
    }


}
