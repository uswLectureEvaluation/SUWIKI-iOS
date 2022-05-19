//
//  announcementPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/19.
//

import UIKit

import Alamofire
import SwiftyJSON

class announcementPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var announcementViewData: Array<announcePage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let announcementCell = UINib(nibName: "announcementCell", bundle: nil)
        tableView.register(announcementCell, forCellReuseIdentifier: "announcementCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 103
        
        getAnnouncementPage()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "announcementCell", for: indexPath) as! announcementCell
        cell.titleLabel.text = announcementViewData[indexPath.row].title
        cell.modifiedDateLabel.text = announcementViewData[indexPath.row].modifiedDate
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // 다음페이지 띄워주기(공지사항 자세히 보기)
        <#code#>
    }
    

    
    func getAnnouncementPage() {
        let url = "https://api.suwiki.kr/notice/findAllList"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data ?? "")
            
            print(json)
            
            if json != "" {
                for index in 0..<json["data"].count{
                    let jsonData = json["data"][index]
                    
                    let readData = announcePage(id: jsonData["id"].intValue, title: jsonData["title"].stringValue, modifiedDate: jsonData["modifiedDate"].stringValue)
                    
                    self.announcementViewData.append(readData)
                    print(readData)
                }
            }
            self.tableView.reloadData()
            
        }
    }

}
