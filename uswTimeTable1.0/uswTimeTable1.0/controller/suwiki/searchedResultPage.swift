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


// 검색결과 테이블 뷰로 보여준다
// 없는 데이터 검색 시 빈 배열
// 즉 데이터 0일경우 다른 화면을 출력해줘야한다는 이야기임
// xib로 셀 두개 만든 후 진행하는게 좋겠음
// 5개의 배열 필요. 기본 값은 수정된 날짜로

class searchedResultPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var categoryDropDown: UIView!
    @IBOutlet weak var categoryTextField: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchResultCountLabel: UILabel!
    let dropDown = DropDown()
    
    var searchData: String = ""
    var page = 1
    var option: String = "lectureTotalAvg"
    var tableViewUpdateData: Array<searchedResult> = []
    var pageCount = 0

    
    let categoryList = ["종합", "만족도", "꿀강", "배움", "날짜"]
    override func viewDidLoad() {
        super.viewDidLoad()
        print(searchData)
        
        let searchedResultCellName = UINib(nibName: "searchedResultCell", bundle: nil)
        tableView.register(searchedResultCellName, forCellReuseIdentifier: "resultCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 116
        
        getLectureData(searchValue: searchData, option: option, page: page)
        
        dropDown.anchorView = categoryDropDown
        dropDown.dataSource = categoryList
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.textFont = UIFont.systemFont(ofSize: 13)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            if categoryTextField.text == "종합" { // 토탈 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureTotalAvg"
                getLectureData(searchValue: searchData, option: option, page: page)
            } else if categoryTextField.text == "만족도" { // 만족 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureSatisfactionAvg"
                getLectureData(searchValue: searchData, option: option, page: page)
            } else if categoryTextField.text == "꿀강"{ // 꿀 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureHoneyAvg"
                getLectureData(searchValue: searchData, option: option, page: page)
            } else if categoryTextField.text == "배움" { // 러닝 에버리지
                tableViewUpdateData.removeAll()
                page = 1
                option = "lectureLearningAvg"
                getLectureData(searchValue: searchData, option: option, page: page)
            } else if categoryTextField.text == "날짜"{ // 최근
                tableViewUpdateData.removeAll()
                page = 1
                option = "modifiedDate"
                getLectureData(searchValue: searchData, option: option, page: page)
            }
        }
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUpdateData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! searchedResultCell
        cell.lectureName.text = tableViewUpdateData[indexPath.row].lectureName
        cell.professor.text = tableViewUpdateData[indexPath.row].professor
        cell.lectureType.text = tableViewUpdateData[indexPath.row].lectureType
        cell.lectureTotalAvg.text = tableViewUpdateData[indexPath.row].lectureTotalAvg
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = tableViewUpdateData.count - 1
        if indexPath.row == lastIndex{
            page += 1
            if page <= pageCount {
                getLectureData(searchValue: searchData, option: option, page: page)
                print("API 호출")
            }
        }
    }
    
    func getLectureData(searchValue: String, option: String, page: Int){ // 최근

        let url = "https://api.suwiki.kr/lecture/findBySearchValue/"
        
        let parameter: Parameters = [
            "searchValue" : searchValue,
            "option" : option,
            "page" : page
        ]
    
        // JSONEncoding --> URLEncoding으로 변경해야 데이터 넘어옴(파라미터 사용 시)
        AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data ?? "")
            print(json["count"])
            self.searchResultCountLabel.text = "\(json["count"].intValue)"
            self.pageCount = (json["count"].intValue / 10) + 1
            if json != "" {
                for index in 0..<json["data"].count{
                    let jsonData = json["data"][index]
                    let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                    let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                    let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                    let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                    
                    let readData = searchedResult(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                    
                    self.tableViewUpdateData.append(readData)
                }
            }
            
            self.tableView?.reloadData()
            self.tableView?.beginUpdates()
            self.tableView.endUpdates()
            
            
        }
        
    }
    
    @IBAction func categoryBtnClicked(_ sender: Any) {
        dropDown.show()
    }
    
    


}
