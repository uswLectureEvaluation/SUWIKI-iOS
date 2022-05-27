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



class searchedResultPage: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var categoryDropDown: UIView!
    @IBOutlet weak var categoryTextField: UILabel!
    
    @IBOutlet weak var majorCategoryDropDown: UIView!
    
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
        
        categoryDropDown.layer.borderWidth = 1.0
        categoryDropDown.layer.borderColor = UIColor.lightGray.cgColor
        categoryDropDown.layer.cornerRadius = 8.0
        majorCategoryDropDown.layer.borderWidth = 1.0
        majorCategoryDropDown.layer.borderColor = UIColor.lightGray.cgColor
        majorCategoryDropDown.layer.cornerRadius = 8.0
        
        getLectureData(searchValue: searchData, option: option, page: page)
        
        dropDown.anchorView = categoryDropDown
        dropDown.dataSource = categoryList
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.textFont = UIFont.systemFont(ofSize: 13)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.categoryTextField.text = categoryList[index]
            self.categoryTextField.font = UIFont.systemFont(ofSize: 13)
            self.categoryTextField.textColor = UIColor.systemBlue
            self.categoryTextField.textAlignment = .center
            
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
    
    override func viewDidLayoutSubviews() {
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0, y: searchTextField.frame.size.height + 16, width: searchTextField.frame.width, height: 1)
        bottomLine1.borderColor = UIColor.black.cgColor
        bottomLine1.borderWidth = 1.0
        searchTextField.borderStyle = .none
        searchTextField.layer.addSublayer(bottomLine1)
    }
    
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        tableViewUpdateData.removeAll()
        searchData = searchTextField.text!
        page = 1
        option = "lectureTotalAvg"
        getLectureData(searchValue: searchData, option: option, page: page)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUpdateData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! lectureDetailedInformationPage
        detailVC.lectureId = tableViewUpdateData[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
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
                getLectureData(searchValue: searchData, option: option, page: page)
            }
        }
    }
    
    func getLectureData(searchValue: String, option: String, page: Int){ // 최근

        let url = "https://api.suwiki.kr/lecture/search/"
        
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
                    print(jsonData)
                    let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                    let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                    let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                    let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                    
                    let readData = searchedResult(id: jsonData["id"].intValue, semester: jsonData["semesterList"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    


}
