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
import GoogleMobileAds

class RestrictedPage: UIViewController {

    //MARK: IBOutlet
    
    @IBOutlet weak var restrictBtn: UIButton!
    @IBOutlet weak var blackListBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    
    //MARK: properties
    
    let keychain = KeychainSwift()
    var tableViewUpdateData: Array<restricted> = []
    var tableViewNumber = 1 // 1 이용제한 2 블랙리스트 3 이용제한 무 4 블랙리스트 무
    
    override func viewDidLoad() {
        getRestricted()
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        super.viewDidLoad()
        
        let restrictedcell = UINib(nibName: "RestrictedCell", bundle: nil)
        tableView.register(restrictedcell, forCellReuseIdentifier: "restrictCell")
        
        
    }
    
    //MARK: btnAction
    
    @IBAction func restrictBtnClicked(_ sender: Any) {
        restrictBtn.setTitleColor(.black, for: .normal)
        blackListBtn.setTitleColor(.lightGray, for: .normal)
        getRestricted()
        
    }
    
    @IBAction func blackListBtnClikcked(_ sender: Any) {
        restrictBtn.setTitleColor(.lightGray, for: .normal)
        blackListBtn.setTitleColor(.black, for: .normal)
        getBlackList()
        
    }
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //MARK: API Func
    
    private func getRestricted(){
        
        tableViewUpdateData.removeAll()
        
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
            print(response.response?.statusCode)
            print(json)
            if json["data"].count == 0 {
                
                self.noDataView.isHidden = false
                self.noDataLabel.text = "이용 제한 내역이 없습니다."
                self.noDataLabel.isHidden = false
                self.tableView.isHidden = true
                
            } else {

                self.tableViewNumber = 1
                self.noDataView.isHidden = true
                self.tableView.isHidden = false

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
        
        tableViewUpdateData.removeAll()
        
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
            print(response.response?.statusCode)
            print(json)
            if json["data"].count == 0 {
                
                self.noDataView.isHidden = false
                self.noDataLabel.text = "블랙리스트 내역이 없습니다."
                self.noDataLabel.isHidden = false
                self.tableView.isHidden = true
                
            } else {
                
                self.tableViewNumber = 2
                self.noDataView.isHidden = true
                self.tableView.isHidden = false
                
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableViewNumber == 1 || tableViewNumber == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "restrictCell", for: indexPath) as! RestrictedCell
            cell.reasonLabel.text = tableViewUpdateData[indexPath.row].reason
            let createdAtData = tableViewUpdateData[indexPath.row].createdAt.split(separator: "T")[0]
            cell.createdAtLabel.text = String(createdAtData)
            let expiredAtData = tableViewUpdateData[indexPath.row].expiredAt.split(separator: "T")[0]
            cell.expiredAtLabel.text = String(expiredAtData)
            cell.judgementLabel.text = tableViewUpdateData[indexPath.row].judgement
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 1 || tableViewNumber == 2{
            return tableViewUpdateData.count
        } else {
            return 1
        }
        
    }
    
}
