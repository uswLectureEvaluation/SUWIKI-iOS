    //
//  suwikiHomePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown

class suwikiHomePage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // main Page == tableView 구현 스크롤 최대 10개 제한

    @IBOutlet weak var categoryDropDown: UIView!
    @IBOutlet weak var categoryTextField: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var viewData: Array<homePageData> = []
    let dropDown = DropDown()
    
    let categoryList = ["최근 올라온 강의", "꿀 강의", "만족도가 높은 강의", "배울게 많은 강의", "Best 강의"]
    
    override func viewDidLoad() {
        navigationBarHidden()
        super.viewDidLoad()
        getMainPage()
        dropDown.anchorView = categoryDropDown
        dropDown.dataSource = categoryList
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.textFont = UIFont.systemFont(ofSize: 13)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.categoryTextField.text = categoryList[index]
            self.categoryTextField.font = UIFont.systemFont(ofSize: 13)
            self.categoryTextField.textColor = .black
            self.categoryTextField.textAlignment = .center
            
            if categoryTextField.text == "최근 올라온 강의" {
                getMainPage()
            } else if categoryTextField.text == "꿀 강의" {
                getHoneyLecture()
            } else if categoryTextField.text == "만족도가 높은 강의"{
                getSatisfactionLecture()
            } else if categoryTextField.text == "배울게 많은 강의" {
                getLearningLecture()
            } else if categoryTextField.text == "Best 강의"{
                getTotalLecture()
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func categoryButtonClicked(_ sender: Any) {
        dropDown.show()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainCell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! mainPageCell
        mainCell.lectureName.text = viewData[indexPath.row].lectureName
        mainCell.lectureType.text = viewData[indexPath.row].lectureType
        mainCell.lectureTotalAvg.text = viewData[indexPath.row].lectureTotalAvg
        mainCell.professor.text = viewData[indexPath.row].professor
        mainCell.lectureName.sizeToFit()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        mainCell.selectedBackgroundView = bgColorView
 
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! lectureDetailedInformationPage
        let AD = UIApplication.shared.delegate as? AppDelegate
        AD?.lectureId = viewData[indexPath.row].id ?? 0
        detailVC.lectureId = viewData[indexPath.row].id
    
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getMainPage(){

        let url = "https://api.suwiki.kr/lecture/findAllList"
        // let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureTotalAvg&page=1"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data!)
           
            for index in 0..<10{
                let jsonData = json["data"][index]
                let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                
                let readData = homePageData(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                
                self.viewData.append(readData)
                            
            }
            self.tableView?.reloadData()

        }
        
    }
    
    func getModifiedDate(){
        self.viewData.removeAll()
        let url = "https://api.suwiki.kr/lecture/findAllList"
        // let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureTotalAvg&page=1"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data!)
           
            for index in 0..<10{
                let jsonData = json["data"][index]
                let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                
                let readData = homePageData(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                
                self.viewData.append(readData)
                            
            }
            self.tableView?.reloadData()

        }
    }
    
    func getHoneyLecture(){
        self.viewData.removeAll()
        let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureHoneyAvg&page=1"
        
        // let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureTotalAvg&page=1"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data!)
           
            for index in 0..<10{
                let jsonData = json["data"][index]
                let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                let totalStatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                
                let readData = homePageData(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalStatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                
                self.viewData.append(readData)
                            
            }
            self.tableView?.reloadData()
            self.tableView?.beginUpdates()
            self.tableView.endUpdates()

        }
    }
    
    func getSatisfactionLecture(){
        self.viewData.removeAll()
        let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureSatisfactionAvg&page=1"
        
        // let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureTotalAvg&page=1"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data!)
           
            for index in 0..<10{
                let jsonData = json["data"][index]
                let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                
                let readData = homePageData(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                
                self.viewData.append(readData)
                            
            }
            self.tableView?.reloadData()
            self.tableView?.beginUpdates()
            self.tableView.endUpdates()

        }
    }
    
    @IBAction func testLogOut(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "pwd")
    }
    func getLearningLecture(){
        self.viewData.removeAll()
        let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureLearningAvg&page=1"
        
        // let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureTotalAvg&page=1"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data!)
           
            for index in 0..<10{
                let jsonData = json["data"][index]
                let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                
                let readData = homePageData(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                
                self.viewData.append(readData)
                            
            }
            self.tableView?.reloadData()
            self.tableView?.beginUpdates()
            self.tableView.endUpdates()

        }
    }
    
    func getTotalLecture(){
        self.viewData.removeAll()
        let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureTotalAvg&page=1"
        
        // let url = "https://api.suwiki.kr/lecture/findAllList/?option=lectureTotalAvg&page=1"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            let data = response.data
            let json = JSON(data!)
           
            for index in 0..<10{
                let jsonData = json["data"][index]
                let totalAvg = String(format: "%.1f", round(jsonData["lectureTotalAvg"].floatValue * 1000) / 1000)
                let totalSatisfactionAvg = String(format: "%.1f", round(jsonData["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
                let totalHoneyAvg = String(format: "%.1f", round(jsonData["lectureHoneyAvg"].floatValue * 1000) / 1000)
                let totalLearningAvg = String(format: "%.1f", round(jsonData["lectureLearningAvg"].floatValue * 1000) / 1000)
                
                let readData = homePageData(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, professor: jsonData["professor"].stringValue, lectureType: jsonData["lectureType"].stringValue, lectureName: jsonData["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg)
                
                self.viewData.append(readData)
                            
            }
            self.tableView?.reloadData()
            self.tableView?.beginUpdates()
            self.tableView.endUpdates()

        }
    }
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
    }


}

class mainPageCell: UITableViewCell {

    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var lectureType: UILabel!
    @IBOutlet weak var lectureTotalAvg: UILabel!
    @IBOutlet weak var professor: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 12.0
        
    }
    
    
}
