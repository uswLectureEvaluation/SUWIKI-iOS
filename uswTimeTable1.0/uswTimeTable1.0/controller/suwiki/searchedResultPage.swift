//
//  searchedResultPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/02.
//

import UIKit

import Alamofire
import SwiftyJSON
import DropDown
import Cosmos
import GoogleMobileAds
import KeychainSwift


class searchedResultPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryDropDown: UIView!
    @IBOutlet weak var categoryTextField: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchResultCountLabel: UILabel!
    @IBOutlet weak var majorCategoryBtn: UIView!
    @IBOutlet weak var chooseMajorLabel: UILabel!
    @IBOutlet weak var majorTypeLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var noSearchDataView: UIView!
    @IBOutlet weak var noSearchDataLabel: UILabel!
    
    
    let dropDown = DropDown()
    let keychain = KeychainSwift()
    var searchData: String = ""
    var page = 1
    var majorType: String = ""
    var option: String = "lectureTotalAvg"
    var tableViewUpdateData: Array<searchedResult> = []
    var pageCount = 0
    var tableViewNumber = 1
    
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)

    let categoryList = ["종합", "만족도", "꿀강", "배움", "날짜"]
    
    override func viewDidLoad() {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        noSearchDataView.isHidden = true
        super.viewDidLoad()
        getMajorType()

        let searchedResultCellName = UINib(nibName: "searchedResultCell", bundle: nil)
        tableView.register(searchedResultCellName, forCellReuseIdentifier: "resultCell")
        
        noSearchDataView.layer.borderWidth = 1.0
        noSearchDataView.layer.cornerRadius = 10.0
        noSearchDataView.layer.borderColor = UIColor.lightGray.cgColor
        
        categoryDropDown.layer.borderWidth = 1.0
        categoryDropDown.layer.borderColor = UIColor.systemGray5.cgColor
        categoryDropDown.layer.cornerRadius = 10.0
        
        majorCategoryBtn.layer.borderWidth = 1.0
        majorCategoryBtn.layer.borderColor = UIColor.systemGray5.cgColor
        majorCategoryBtn.layer.cornerRadius = 10.0
        

        // getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
        
        dropDown.anchorView = categoryDropDown
        dropDown.dataSource = categoryList
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.textFont = UIFont.systemFont(ofSize: 14)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextField.text = categoryList[index]
            self.categoryTextField.font = UIFont(name: "Pretendard", size: 14)
            self.categoryTextField.textColor = colorLiteralBlue
            
            if categoryTextField.text == "종합" { // 토탈 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureTotalAvg"
                getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
            } else if categoryTextField.text == "만족도" { // 만족 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureSatisfactionAvg"
                getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
            } else if categoryTextField.text == "꿀강"{ // 꿀 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureHoneyAvg"
                getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
            } else if categoryTextField.text == "배움" { // 러닝 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureLearningAvg"
                getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
            } else if categoryTextField.text == "날짜"{ // 최근
                tableViewUpdateData.removeAll()
                page = 1
                option = "modifiedDate"
                getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
            }
        }
        tableView.isHidden = true
    }
    
    // 검색결과 없을 때 표시 해주는 부분 필요
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewUpdateData.removeAll()
        print("viewwillappear")
        
        getMajorType()
        page = 1
        getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
        super.viewWillAppear(animated)
    }
    
    @IBAction func majorCategoryBtnClicked(_ sender: Any) {
        tableViewUpdateData.removeAll()

        let majorVC = self.storyboard?.instantiateViewController(withIdentifier: "majorVC") as! MajorCategoryPage
        majorVC.modalPresentationStyle = .fullScreen
        self.present(majorVC, animated: true, completion: nil)
        
    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        tableViewUpdateData.removeAll()
        searchData = searchTextField.text!
        page = 1
        option = "lectureTotalAvg"
        getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUpdateData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if keychain.get("AccessToken") != nil {
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! lectureDetailedInformationPage
            detailVC.lectureId = tableViewUpdateData[indexPath.row].id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        else {
           let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginController
           self.present(nextVC, animated: true, completion: nil)
       }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! searchedResultCell
        cell.lectureName.text = tableViewUpdateData[indexPath.row].lectureName
        cell.majorType.text = tableViewUpdateData[indexPath.row].majorType
        cell.professor.text = tableViewUpdateData[indexPath.row].professor
        cell.lectureType.text = tableViewUpdateData[indexPath.row].lectureType
        cell.lectureTotalAvg.text = tableViewUpdateData[indexPath.row].lectureTotalAvg
        cell.ratingBarView.rating = Double(tableViewUpdateData[indexPath.row].lectureTotalAvg)!
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = tableViewUpdateData.count - 1
        if indexPath.row == lastIndex{
            page += 1
            if page <= pageCount {
                getLectureData(searchValue: searchData, option: option, page: page, majorType: majorType)
            }
        }
    }
    
    func getMajorType(){
        let AD = UIApplication.shared.delegate as? AppDelegate
        
        if let majorData = AD?.majorType{
            
            if majorData == "1"{
                chooseMajorLabel.isHidden = true
                majorTypeLabel.isHidden = false
                majorLabel.isHidden = false
            } else {
                if majorData == ""{
                    majorType = ""
                    chooseMajorLabel.text = "전체"
                } else {
                    majorType = majorData
                    chooseMajorLabel.text = majorType
                }
                
                chooseMajorLabel.isHidden = false
                majorTypeLabel.isHidden = true
                majorLabel.isHidden = true
            }
        }
    }
    
    func getLectureData(searchValue: String, option: String, page: Int, majorType: String){ // 최근

        let url = "https://api.suwiki.kr/lecture/search/"
        
        let parameter: Parameters = [
            "searchValue" : searchValue,
            "option" : option,
            "page" : page,
            "majorType" : majorType
        ]
    
        // JSONEncoding --> URLEncoding으로 변경해야 데이터 넘어옴(파라미터 사용 시)
        AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default).responseJSON { (response) in
                        
            let data = response.data
            let json = JSON(data ?? "")
            print(json["count"])
            self.searchResultCountLabel.text = "\(json["count"].intValue)"
            print(json["count"].intValue)
            self.pageCount = (json["count"].intValue / 10) + 1
            if json != "" {
                
                for index in 0..<json["data"].count{
                    
                    
                    let jsonData = json["data"][index]
                    let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                    let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                    let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                    let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                    
                    let readData = searchedResult(id: jsonData["id"].intValue, semester: jsonData["semesterList"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                    
                    self.tableViewUpdateData.append(readData)
                }

            }
            
            if self.tableViewUpdateData.count == 0{

                self.tableView.isHidden = true
                self.noSearchDataView.isHidden = false
                self.noSearchDataLabel.text = "'\(searchValue)'에 대한"
                
            } else {
                
                self.tableView.isHidden = false
                self.noSearchDataView.isHidden = true
                
            }
            
            self.tableView?.reloadData()
            self.tableView?.beginUpdates()
            self.tableView.endUpdates()
            
            
        }
        
    }
    
    @IBAction func categoryBtnClicked(_ sender: Any) {
        dropDown.show()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    


}
