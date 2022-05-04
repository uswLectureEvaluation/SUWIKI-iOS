//
//  searchedResultPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/02.
//

import UIKit
import Alamofire
import SwiftyJSON

// 검색결과 테이블 뷰로 보여준다
// 없는 데이터 검색 시 빈 배열
// 즉 데이터 0일경우 다른 화면을 출력해줘야한다는 이야기임
// xib로 셀 두개 만든 후 진행하는게 좋겠음
// 5개의 배열 필요. 기본 값은 수정된 날짜로

class searchedResultPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchData: String = ""
    var page = 1
    
    var modifiedDateArray: Array<searchedResult> = []
    var lectureSatisfactionAvgArray: Array<searchedResult> = []
    var lectureHoneyAvgArray: Array<searchedResult> = []
    var lectureLearningAvgArray: Array<searchedResult> = []
    var lectureTotalAvgArray: Array<searchedResult> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(searchData)
        getModifiedDateData(searchValue: searchData, page: 1)
        
        let searchedResultCellName = UINib(nibName: "searchedResultCell", bundle: nil)
        tableView.register(searchedResultCellName, forCellReuseIdentifier: "resultCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 116

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modifiedDateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! searchedResultCell
        cell.lectureName.text = modifiedDateArray[indexPath.row].lectureName
        cell.professor.text = modifiedDateArray[indexPath.row].professor
        cell.lectureType.text = modifiedDateArray[indexPath.row].lectureType
        cell.lectureTotalAvg.text = modifiedDateArray[indexPath.row].lectureTotalAvg
        return cell
    }
    
    
    
    func getModifiedDateData(searchValue: String, page: Int){
        let url = "https://api.suwiki.kr/lecture/findBySearchValue/"
        
        let parameter: Parameters = [
            "searchValue" : searchValue,
            "option" : "modifiedDate",
            "page" : page
        ]
    
        // JSONEncoding --> URLEncoding으로 변경해야 데이터 넘어옴(파라미터 사용 시)
        AF.request(url, method: .get, parameters: parameter, encoding: URLEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data ?? "")

            if json != "" {
                for index in 0..<10{
                    let jsonData = json["data"][index]
                    let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                    let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                    let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                    let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                    
                    let readData = searchedResult(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                    
                    self.modifiedDateArray.append(readData)
                }
            }
            self.tableView.reloadData()
            print(self.modifiedDateArray)
            
            
        }
        
    }
    
    func getLectureSatisfactionAvgData(searchValue: String, page: Int){
        
    }
    
    func getLectureHoneyAvgData(searchValue: String, page: Int){
        
    }
    
    func getLectureLearningAvgData(searchValue: String, page: Int){
        
    }
    
    func getLectureTotalAvgData(searchValue: String, page: Int){
        
    }

}
