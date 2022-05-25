//
//  PurchaseHistoryPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/25.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class PurchaseHistoryPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewUpdateData: Array<purchaseModel> = []
    
    let keychain = KeychainSwift()

    override func viewDidLoad() {
        getPurchaseHistoryData()

        super.viewDidLoad()
        
        let historyCell = UINib(nibName: "PurchaseHistoryCell", bundle: nil)
        tableView.register(historyCell, forCellReuseIdentifier: "historyCell")
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUpdateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! PurchaseHistoryCell
        
        cell.createDateLabel.text = tableViewUpdateData[indexPath.row].createDate
        cell.lectureNameLabel.text = tableViewUpdateData[indexPath.row].lectureName
        cell.majorTypeLabel.text = tableViewUpdateData[indexPath.row].majortype
        cell.professorLabel.text = tableViewUpdateData[indexPath.row].professor
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
    func getPurchaseHistoryData() {
        let url = "https://api.suwiki.kr/exam-posts/purchase-history"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            let data = response.data
            let json = JSON(data ?? "")
            
            print(json["data"].count)
            if json["data"].count > 0 {
                for index in 0..<json["data"].count{
                    let jsonData = json["data"][index]
                    let readData = purchaseModel(id: jsonData["id"].intValue, lectureName: jsonData["lectureName"].stringValue, professor: jsonData["professor"].stringValue, majortype: jsonData["majorType"].stringValue, createDate: jsonData["createDate"].stringValue)
                    
                    print(readData)
                    self.tableViewUpdateData.append(readData)
                }
                print(self.tableViewUpdateData)
                self.tableView.reloadData()
            }
            
        }
    }
    

}
