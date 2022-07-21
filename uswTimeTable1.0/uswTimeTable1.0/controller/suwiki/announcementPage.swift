//
//  announcementPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/19.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class announcementPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    let keychain = KeychainSwift()
    
    var announcementViewData: Array<announcePage> = []
    
    var tableViewNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let announcementCell = UINib(nibName: "announcementCell", bundle: nil)
        tableView.register(announcementCell, forCellReuseIdentifier: "announcementCell")
        
        let noExamDataExistsCellName = UINib(nibName: "noExamDataExistsCell", bundle: nil)
        tableView.register(noExamDataExistsCellName, forCellReuseIdentifier: "noDataCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 103.0
        self.tableView.reloadData()
        getAnnouncementPage()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 0{
            return announcementViewData.count
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableViewNumber == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "announcementCell", for: indexPath) as! announcementCell
            cell.titleLabel.text = announcementViewData[indexPath.row].title
            let modifiedDateView = announcementViewData[indexPath.row].modifiedDate.split(separator: "T")[0]
            cell.modifiedDateLabel.text = String(modifiedDateView)
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.white
            cell.selectedBackgroundView = bgColorView
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! noExamDataExistsCell
            cell.noExamData.text = "공지사항이 없습니다."
            
            return cell
        }
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // 다음페이지 띄워주기(공지사항 자세히 보기
        
        let url = "https://api.suwiki.kr/notice/?noticeId=\(announcementViewData[indexPath.row].id)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            
            print(response.response?.statusCode)
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data)
                if json["data"].count > 0 {
                    self.tableViewNumber = 0
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "announceDetailVC") as! announcementDetailPage
                    nextVC.noticeId = self.announcementViewData[indexPath.row].id
                    self.present(nextVC, animated: true, completion: nil)
                } else {
                    self.tableViewNumber = 1
                }
            } else {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
    

    
    func getAnnouncementPage() {
        let url = "https://api.suwiki.kr/notice/all?page=1"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data ?? "")
            
            print(json)
            
            if json != "" {
                if json["data"].count > 0{
                    self.tableViewNumber = 0
                    for index in 0..<json["data"].count{
                        let jsonData = json["data"][index]
                        
                        let readData = announcePage(id: jsonData["id"].intValue, title: jsonData["title"].stringValue, modifiedDate: jsonData["modifiedDate"].stringValue)
                        
                        self.announcementViewData.append(readData)
                        print(readData)
                    }
                } else {
                    self.tableViewNumber = 1
                }
                
            }
            self.tableView.reloadData()
            
        }
    }

}
