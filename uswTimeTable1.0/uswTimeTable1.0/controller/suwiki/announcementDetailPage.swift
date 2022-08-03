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
import GoogleMobileAds

class announcementDetailPage: UIViewController {
    
    
    @IBOutlet weak var announceView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var modifiedDateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    let keychain = KeychainSwift()
    
    var noticeId: Int = 0
    
    var announcementDetailPageData: Array<announceDetailPage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(keychain.get("AccessToken"))
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        announceView.layer.borderColor = UIColor.lightGray.cgColor
        announceView.layer.cornerRadius = 12.0
        announceView.layer.borderWidth = 1.0
        
        getAnnouncementDetailPage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
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
    
    //let range = tableViewUpdateData[indexPath.row].createDate.startIndex..<tableViewUpdateData[indexPath.row].createDate.index(tableViewUpdateData[indexPath.row].createDate.startIndex, offsetBy: 10)
    
    //cell.createDateLabel.text = "\(tableViewUpdateData[indexPath.row].createDate[range])"
    
    func detailViewUpdate() {
        titleLabel.text = announcementDetailPageData[0].title
        let dateData = announcementDetailPageData[0].modifiedDate.split(separator: "T")[0]
        modifiedDateLabel.text = String(dateData)
        contentLabel.text = announcementDetailPageData[0].content
    }


}
