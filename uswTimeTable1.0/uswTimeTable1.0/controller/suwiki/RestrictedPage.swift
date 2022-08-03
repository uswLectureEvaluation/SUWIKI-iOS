//
//  RestrictedPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class RestrictedPage: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: properties
    
    let keychain = KeychainSwift()
    var tableViewUpdateData: Array<restricted> = []
    var tableViewNumber = 1 // 1 이용제한 2 블랙리스트 3 이용제한 무 4 블랙리스트 무
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: API Func
    
    private func getRestricted(){
        let url = "https://api.suwiki.kr/user/restricted-reason"
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken")!)
        ]
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            
            let json = JSON(response.data)
            
            if json["data"].count == 0 {
                self.tableViewNumber = 3
            } else {
                self.tableViewNumber = 1
                
                for i in 0..<json["data"].count{
                    
                    let data = json["data"][i]
                    let readData = restricted(reason: data["restrictedReason"].stringValue,
                                              judgement: data["judgement"].stringValue,
                                              createdAt: data["createdAt"].stringValue,
                                              expiredAt: data["restrictingDate"].stringValue)
                    self.tableViewUpdateData.append(readData)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    private func getBlackList() {
        let url = "https://api.suwiki.kr/user/blacklist-reason"
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken")!)
        ]
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers,
                   interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            
            let json = JSON(response.data)
            
            if json["data"].count == 0 {
                self.tableViewNumber = 4
            } else {
                self.tableViewNumber = 2
                
                for i in 0..<json["data"].count{
                    
                    let data = json["data"][i]
                    let readData = restricted(reason: data["blackListReason"].stringValue,
                                              judgement: data["judgement"].stringValue,
                                              createdAt: data["createdAt"].stringValue,
                                              expiredAt: data["expiredAt"].stringValue)
                    self.tableViewUpdateData.append(readData)
                }
            }
            self.tableView.reloadData()
        }
        
    }

    
}

extension RestrictedPage: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 1 || tableViewNumber == 2{
            return tableViewUpdateData.count
        } else {
            return 1
        }
        
    }
    
}
