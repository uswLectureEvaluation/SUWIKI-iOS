//
//  lectureDetailedInformationPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/04.
//

import UIKit
import KeychainSwift
import Alamofire
import SwiftyJSON

class lectureDetailedInformationPage: UIViewController {

    @IBOutlet weak var lectureView: UIView!
    
    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var professor: UILabel!
    
    
    let keychain = KeychainSwift()
    var lectureId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lectureView.layer.borderWidth = 1.0
        lectureView.layer.borderColor = UIColor.lightGray.cgColor
        lectureView.layer.cornerRadius = 12.0
        
        getDetailPage()

        lectureName.sizeToFit()
    }
    
    func getDetailPage(){
        let url = "https://api.suwiki.kr/lecture/?lectureId=\(lectureId)"
        
 
        let headers: HTTPHeaders = [
            "AccessToken" : String(keychain.get("AccessToken") ?? "")
        ]
  
        
        print(url)
        print(keychain.get("AccessToken"))
              //

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            let data = response.value
            
            let json = JSON(data)["data"]
            
            
            
        }
        
        
    }

}
