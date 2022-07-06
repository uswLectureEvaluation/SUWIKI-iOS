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
    @IBOutlet weak var searchTextField: UITextField!
    
    
    let keychain = KeychainSwift()
    
    private var tableViewUpdateData: Array<MajorCategory> = []
    private var searchTableViewData: Array<MajorCategory> = []
    private var favoritesMajorData : Array<MajorCategory> = []
    
    // 1은 전체, 2는 즐겨찾기, 3은 전체일 때 검색 시, 4는 즐겨찾기에서 검색 시
    var tableViewNumber = 1
    // 1은 데이터 있을 때, 0은 데이터 없을 때
    var tableViewDataExists = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMajorType()
        getFavorite()
        let majorCellName = UINib(nibName: "MajorCategoryCell", bundle: nil)
        tableView.register(majorCellName, forCellReuseIdentifier: "majorCell")
        
        print(String(keychain.get("AccessToken") ?? ""))
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 63
        self.tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        if tableViewNumber == 1 && tableViewNumber == 3{
            searchTableViewData.removeAll()
            tableViewNumber = 3
            for i in 0..<tableViewUpdateData.count{
                var searchData: String = "\(tableViewUpdateData[i].majorType)"
                // if contain 확인 후 True or false
                if searchData.contains(searchTextField.text ?? ""){
                    print(searchData)
                    // searchTableViewData.append(MajorCategory(majorType: searchData))
                }
            }
            tableView.reloadData()
        } else {
            searchTableViewData.removeAll()
            tableViewNumber = 4
            for i in 0..<favoritesMajorData.count{
                var searchData: String = "\(favoritesMajorData[i].majorType)"
                if searchData.contains(searchTextField.text ?? ""){
                    
                    if favoritesMajorData.contains(where: {$0.majorType == searchData}){
                        searchTableViewData.append(MajorCategory(majorType: searchData, favoriteCheck: true))
                    } else {
                        searchTableViewData.append(MajorCategory(majorType: searchData, favoriteCheck: false))
                    }
                    //
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewDataExists == 1{
            if tableViewNumber == 1 {
                return tableViewUpdateData.count
            } else {
                return searchTableViewData.count
            }
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewDataExists == 1{
            if tableViewNumber == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! MajorCategoryCell
                cell.majorTypeLabel.text = tableViewUpdateData[indexPath.row].majorType
                
                cell.favoriteBtn.tag = indexPath.row
                cell.favoriteBtn.addTarget(self, action: #selector(favoriteBtnClicked), for: .touchUpInside)
                
                if tableViewUpdateData[indexPath.row].favoriteCheck == true {
                    cell.favoriteBtn.setImage(UIImage(named: "icon_fullstar_24"), for: .normal)
                } else{
                    cell.favoriteBtn.setImage(UIImage(named: "icon_emptystar_24"), for: .normal)
                }
                return cell
            } else if tableViewNumber == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! MajorCategoryCell
                cell.majorTypeLabel.text = searchTableViewData[indexPath.row].majorType
                return cell
            }
        }
        
        return UITableViewCell()
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
            for index in 0..<json["data"].count {
                
                var readData = MajorCategory(majorType: json["data"][index].stringValue, favoriteCheck: false)
                let checkData: String = "\(readData.majorType)"
                if self.favoritesMajorData.contains(where: {$0.majorType == checkData}){
                    readData.favoriteCheck = true
                }
                self.tableViewUpdateData.append(readData)
                
            }
            
            self.tableView.reloadData()
        }
    }
    
    func getFavorite(){
        favoritesMajorData.removeAll()
        let url = "https://api.suwiki.kr/user/favorite-major"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? ""),
            
        ]
        // JSONEncoding --> URLEncoding으로 변경해야 데이터 넘어옴(파라미터 사용 시)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON {
            (response) in
            let data = response.data
            print(JSON(response.value))
            let json = JSON(data ?? "")
            for index in 0..<json["data"].count{
                let jsonData = json["data"][index]
                let readData = MajorCategory(majorType: jsonData.stringValue, favoriteCheck: true)
                self.favoritesMajorData.append(readData)
            }
            self.tableView.reloadData()
            print(self.favoritesMajorData)
        }
        
    }
    

    // 전공 즐겨찾기 하기
    func favoriteAdd(majorType: String){
        let url = "https://api.suwiki.kr/user/favorite-major"
        
        let parameters: Parameters = [
            "majorType" : majorType,
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
//
//        let headers: HTTPHeaders = [
//            "Authorization" : String(keychain.get("AccessToken") ?? "")
//        ]
        
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, interceptor: BaseInterceptor()).validate().responseJSON { response in
            let status = response.response?.statusCode
            print(status)
            if status == 403{
                let alert = UIAlertController(title:"제한된 유저십니다 ^^",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                //2. 확인 버튼 만들기
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                //3. 확인 버튼을 경고창에 추가하기
                alert.addAction(cancle)
                //4. 경고창 보이기
                self.present(alert, animated: true, completion: nil)
            }
            self.getFavorite()
        }
        
    }
    
    func favoriteRemove(majorType: String){
        let url = "https://api.suwiki.kr/user/favorite-major"
        
//        let headers: HTTPHeaders = [
//
//            "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
//        ]
        
        let parameters: Parameters = [
            "majorType" : majorType
        ]
//
//
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .delete, parameters: parameters, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            let status = response.response?.statusCode
            
            print(status)
            if status == 403{
                let alert = UIAlertController(title:"제한된 유저십니다 ^^",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                //2. 확인 버튼 만들기
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                //3. 확인 버튼을 경고창에 추가하기
                alert.addAction(cancle)
                //4. 경고창 보이기
                self.present(alert, animated: true, completion: nil)
            } else {
                self.getFavorite()
            }
            
        }
        
        
    }
   
    
    @objc func favoriteBtnClicked(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        if tableViewNumber == 1{
            print("\(tableViewUpdateData[indexPath.row].majorType)")
            if tableViewUpdateData[indexPath.row].favoriteCheck == true {
                
                favoriteRemove(majorType: "\(tableViewUpdateData[indexPath.row].majorType)")
                tableViewUpdateData[indexPath.row].favoriteCheck = false
            } else {
                favoriteAdd(majorType: "\(tableViewUpdateData[indexPath.row].majorType)")
                tableViewUpdateData[indexPath.row].favoriteCheck = true
            }
        } else if tableViewNumber == 2{
            
        } else if tableViewNumber == 3{
            
        } else if tableViewNumber == 4{
            
        }
//        let removeAlert = UIAlertController(title: "강의평가 삭제", message: "삭제 하시겠어요?", preferredStyle: UIAlertController.Style.alert)
//
//        let deleteButton = UIAlertAction(title: "삭제", style: .destructive, handler: { [self] (action) -> Void in
//            print("Delete button tapped")
//            removeEvaluation(id: tableViewEvalData[indexPath.row].id)
//
//        })
//
//        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
//            print("Cancel button tapped")
//        })
//
//        removeAlert.addAction(deleteButton)
//        removeAlert.addAction(cancelButton)
//        present(removeAlert, animated: true, completion: nil)
    }
}
