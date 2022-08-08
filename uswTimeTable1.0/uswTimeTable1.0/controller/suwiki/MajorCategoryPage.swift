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

class MajorCategoryPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
    // 버튼 눌렀을 때 api 호출 --> majorType 넘겨준다.
    // 개설학과 전체 다 보여주는 그거 만들어야 함
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableViewBorder: UIView!
    @IBOutlet weak var totalBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    
    
    
    let keychain = KeychainSwift()
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let chooseColor = #colorLiteral(red: 0.9590070844, green: 0.9689564109, blue: 0.9988682866, alpha: 1)
    
    

    private var tableViewUpdateData: Array<MajorCategory> = []
    private var searchTableViewData: Array<MajorCategory> = []
    private var favoritesMajorData : Array<MajorCategory> = []
    
    // 1은 전체, 2는 즐겨찾기, 3은 전체일 때 검색 시, 4는 즐겨찾기에서 검색 시
    var tableViewNumber = 1
    // 1은 데이터 있을 때, 0은 데이터 없을 때
    var tableViewDataExists = 1
    
    var sendMajorData: String = ""
    
    override func viewDidLoad() {
        
        finishBtn.layer.cornerRadius = 10.0
        finishBtn.layer.borderColor = UIColor.white.cgColor
        finishBtn.layer.borderWidth = 1.0
        
        totalBtn.tintColor = .black
        favoriteBtn.tintColor = .lightGray
        
        tableViewNumber = 1
        super.viewDidLoad()
        getFavorite()
        let majorCellName = UINib(nibName: "MajorCategoryCell", bundle: nil)
        tableView.register(majorCellName, forCellReuseIdentifier: "majorCell")
        let noMajorCellName = UINib(nibName: "MajorCategoryNoDataCell", bundle: nil)
        tableView.register(noMajorCellName, forCellReuseIdentifier: "noMajorCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 63
        self.tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableViewBorder.layer.borderColor = UIColor.lightGray.cgColor
        tableViewBorder.layer.borderWidth = 1.0
        tableViewBorder.layer.cornerRadius = 12.0
        
        self.searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // 즐겨찾기 이후 검색 시 리스트가 두번 출력되는 버그
//    let AD = UIApplication.shared.delegate as? AppDelegate
//
//    AD?.roomName = roomTextField.text ?? ""
//    AD?.startTime = "\(String(describing: startTextField.text!)):30"
//    AD?.endTime = "\(String(describing: endTextField.text!)):20"
//    
//    self.dismiss(animated: true, completion: nil)
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func finishBtnClicked(_ sender: Any) {
        
        if sendMajorData != "" {
            
            let AD = UIApplication.shared.delegate as? AppDelegate
            if sendMajorData == "전체" {
                AD?.majorType = ""
            } else {
                AD?.majorType = sendMajorData
            }
            
            
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title:"학과를 선택해주세요!",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            self.present(alert, animated: true, completion: nil)
            
        }
        

    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        
        searchTableViewData.removeAll()
        
        if tableViewNumber == 1 || tableViewNumber == 3{
            
            tableViewNumber = 3
            
            for i in 0..<tableViewUpdateData.count{
                var searchData: String = "\(tableViewUpdateData[i].majorType)"
                // if contain 확인 후 True or false
                if searchData.contains(searchTextField.text ?? ""){
                    
//                    print(tableViewUpdateData.count)
//                    print(searchTextField.text)
//                    print(searchData)
                    
                    if favoritesMajorData.contains(where: {$0.majorType == searchData}){
                        searchTableViewData.append(MajorCategory(majorType: searchData, favoriteCheck: true))
                    } else {
                        searchTableViewData.append(MajorCategory(majorType: searchData, favoriteCheck: false))
                    }
                }
            }
            
        } else if tableViewNumber == 2 || tableViewNumber == 4 {
            searchTableViewData.removeAll()
            tableViewNumber = 4
            
            for i in 0..<favoritesMajorData.count{
                var searchData: String = "\(favoritesMajorData[i].majorType)"
                print(searchData)
                if searchData.contains(searchTextField.text ?? ""){
                    print("success")
                    searchTableViewData.append(MajorCategory(majorType: searchData, favoriteCheck: true))
                    
                }
            }
        }
        
        if searchTableViewData.count == 0{
            tableViewNumber = 6
        }
        
        tableView.reloadData()
    }
    
    @IBAction func totalBtnClicked(_ sender: Any) {
        totalBtn.tintColor = .black
        favoriteBtn.tintColor = .lightGray
        tableViewNumber = 1
        tableView.reloadData()
    }
    
    @IBAction func favoriteBtnClicked(_ sender: Any) {
        print("0")
        if favoritesMajorData.count > 0{
            self.getFavorite()
            tableViewNumber = 2
            print(favoritesMajorData)
        } else {
            print("3")
            tableViewNumber = 5
        }
        totalBtn.tintColor = .lightGray
        favoriteBtn.tintColor = .black
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableViewNumber == 1 {
            return tableViewUpdateData.count
        } else if tableViewNumber == 2 {
            return favoritesMajorData.count
        } else if tableViewNumber == 3 || tableViewNumber == 4{
            return searchTableViewData.count
        } else {
            return 1
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            searchBtnClicked(self)
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableViewNumber == 1{ // 전체
            let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! MajorCategoryCell
            cell.majorTypeLabel.text = tableViewUpdateData[indexPath.row].majorType
            
            cell.favoriteBtn.tag = indexPath.row
            cell.favoriteBtn.addTarget(self, action: #selector(favoriteBtnClicked), for: .touchUpInside)
            
            if tableViewUpdateData[indexPath.row].favoriteCheck == true {
                cell.favoriteBtn.setImage(UIImage(named: "icon_fullstar_24"), for: .normal)
            } else{
                cell.favoriteBtn.setImage(UIImage(named: "icon_emptystar_24"), for: .normal)
            }
            
            var bgColorView = UIView()
            bgColorView.backgroundColor = chooseColor
            cell.selectedBackgroundView = bgColorView
            
            return cell
            
        } else if tableViewNumber == 2{ // 즐겨찾기
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! MajorCategoryCell
            cell.majorTypeLabel.text = favoritesMajorData[indexPath.row].majorType
            
            cell.favoriteBtn.tag = indexPath.row
            cell.favoriteBtn.addTarget(self, action: #selector(favoriteBtnClicked), for: .touchUpInside)
            
            if favoritesMajorData[indexPath.row].favoriteCheck == true {
                cell.favoriteBtn.setImage(UIImage(named: "icon_fullstar_24"), for: .normal)
            } else{
                cell.favoriteBtn.setImage(UIImage(named: "icon_emptystar_24"), for: .normal)
            }
            
            var bgColorView = UIView()
            bgColorView.backgroundColor = chooseColor
            cell.selectedBackgroundView = bgColorView
            
            return cell

            
        } else if tableViewNumber == 3 || tableViewNumber == 4{ // 전체 검색
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! MajorCategoryCell
            cell.majorTypeLabel.text = searchTableViewData[indexPath.row].majorType
        
            cell.favoriteBtn.tag = indexPath.row
            cell.favoriteBtn.addTarget(self, action: #selector(favoriteBtnClicked), for: .touchUpInside)
            
            if searchTableViewData[indexPath.row].favoriteCheck == true {
                cell.favoriteBtn.setImage(UIImage(named: "icon_fullstar_24"), for: .normal)
            } else{
                cell.favoriteBtn.setImage(UIImage(named: "icon_emptystar_24"), for: .normal)
            }
            
            var bgColorView = UIView()
            bgColorView.backgroundColor = chooseColor
            cell.selectedBackgroundView = bgColorView
            
            return cell
            
        } else if tableViewNumber == 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "noMajorCell", for: indexPath) as! MajorCategoryNoDataCell
            cell.noMajorLabel.text = "즐겨찾기가 없어요!"
            cell.hiddenLabel.isHidden = true
            return cell
            
        } else if tableViewNumber == 6{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "noMajorCell", for: indexPath) as! MajorCategoryNoDataCell
            cell.noMajorLabel.text = "'\(searchTextField.text ?? "1")'에 대한"
            cell.hiddenLabel.isHidden = false
            return cell
            
        }

        
        
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewNumber == 1{
            
            sendMajorData = tableViewUpdateData[indexPath.row].majorType
            
        } else if tableViewNumber == 2{
            
            sendMajorData = favoritesMajorData[indexPath.row].majorType
            
        } else if tableViewNumber == 3 || tableViewNumber == 4{
            
            sendMajorData = searchTableViewData[indexPath.row].majorType
            
        }
        
        print(sendMajorData)
    }
    
    func getMajorType(){
        let url = "https://api.suwiki.kr/suwiki/majorType"
        
        let parameter: Parameters = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        if tableViewUpdateData.count == 0 { // 최초 호출
            AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default).responseJSON { (response) in
                let data = response.data
                
                let json = JSON(data ?? "")
                self.tableViewUpdateData.append(MajorCategory(majorType: "전체", favoriteCheck: false))
                if self.favoritesMajorData.contains(where: {$0.majorType == "전체"}) {
                    self.tableViewUpdateData[0].favoriteCheck = true
                }
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
            
        } else {
            for i in 0..<tableViewUpdateData.count{
                if self.favoritesMajorData.contains(where: {$0.majorType == tableViewUpdateData[i].majorType}){
                    tableViewUpdateData[i].favoriteCheck = true
                } else {
                    tableViewUpdateData[i].favoriteCheck = false
                }
            }
        
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
            
            let json = JSON(data ?? "")
            if json["data"].count > 0 {
                for index in 0..<json["data"].count{
                    let jsonData = json["data"][index]
                    let readData = MajorCategory(majorType: jsonData.stringValue, favoriteCheck: true)
                    self.favoritesMajorData.append(readData)
                }
                self.tableView.reloadData()

            }
            self.getMajorType()
            
        }
        
        
    }
    

    // 전공 즐겨찾기 하기
    func favoriteAdd(majorType: String){
        let url = "https://api.suwiki.kr/user/favorite-major"
        
        let parameters: Parameters = [
            "majorType" : majorType
        ]

        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            let status = response.response?.statusCode
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
        
        let parameters: Parameters = [
            "majorType" : majorType
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .delete, parameters: parameters, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            let status = response.response?.statusCode
            
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
                self.tableView.reloadData()
            }
//            } else {
//                self.getFavorite()
//            }
        }
    }
   
    
    @objc func favoriteBtnClicked(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        if tableViewNumber == 1{
   
            if tableViewUpdateData[indexPath.row].favoriteCheck == true {
                
                favoriteRemove(majorType: "\(tableViewUpdateData[indexPath.row].majorType)")
                tableViewUpdateData[indexPath.row].favoriteCheck = false
            } else {
                favoriteAdd(majorType: "\(tableViewUpdateData[indexPath.row].majorType)")
                tableViewUpdateData[indexPath.row].favoriteCheck = true
            }
        } else if tableViewNumber == 2{ // 데이터 유지 시키기가 더 좋을 듯 함. reloadData 되는 도중에 index 벗어나는 버그 발생함
            
            if favoritesMajorData.count == 1{
                tableViewNumber = 5
                tableView.reloadData()
            }
            
            favoriteRemove(majorType: "\(favoritesMajorData[indexPath.row].majorType)")
            favoritesMajorData[indexPath.row].favoriteCheck = false
//            let dataIndex: Int = tableViewUpdateData.firstIndex(where: {$0.majorType == favoritesMajorData[indexPath.row].majorType}) ?? 0
//            tableViewUpdateData[dataIndex].favoriteCheck = false
            
        } else if tableViewNumber == 3 || tableViewNumber == 4{
            if searchTableViewData[indexPath.row].favoriteCheck == true {
                
                favoriteRemove(majorType: "\(searchTableViewData[indexPath.row].majorType)")
                searchTableViewData[indexPath.row].favoriteCheck = false
            } else {
                favoriteAdd(majorType: "\(searchTableViewData[indexPath.row].majorType)")
                searchTableViewData[indexPath.row].favoriteCheck = true
            }
        }

    }
}
