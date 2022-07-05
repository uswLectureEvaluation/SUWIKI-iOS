//
//  MajorCategoryPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/07/02.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class MajorCategoryPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    // 버튼 눌렀을 때 api 호출 --> majorType 넘겨준다.
    
    @IBOutlet weak var tableView: UITableView!
    
    let keychain = KeychainSwift()
    
    private var tableViewUpdateData: Array<MajorCategory> = []
    
    private var searchTableViewData: Array<MajorCategory> = []

    private var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMajorType()

        let majorCellName = UINib(nibName: "MajorCategoryCell", bundle: nil)
        tableView.register(majorCellName, forCellReuseIdentifier: "majorCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 63
        self.tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUpdateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! MajorCategoryCell
        let data = tableViewUpdateData[indexPath.row]
        
        cell.majorTypeLabel.text = "\(data.stringValue)"
        return cell
    }
    
    func getMajorType(){
        let url = "https://api.suwiki.kr/suwiki/majorType"
        
        let parameter: Parameters = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        // JSONEncoding --> URLEncoding으로 변경해야 데이터 넘어옴(파라미터 사용 시)
        AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default).responseJSON { (response) in
            let data = response.data
            
            let json = JSON(data ?? "")
            
            self.tableViewUpdateData = json["data"].arrayValue
            self.tableView.reloadData()
            print(self.tableViewUpdateData)
        }
    }
    

   
}
