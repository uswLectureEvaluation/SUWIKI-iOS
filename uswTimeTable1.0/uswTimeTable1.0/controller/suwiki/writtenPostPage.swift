//
//  writtenPostPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/12.
//

import UIKit

import Alamofire
import SwiftyJSON
import KeychainSwift

class writtenPostPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
   
    let keychain = KeychainSwift()
    
    var tableViewEvalData: Array<WrittenEvalPostData> = []
    var tableViewExamData: Array<WrittenExamPostData> = []
    
    var tableViewNumber = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        let evalPostCell = UINib(nibName: "writtenEvalPostCell", bundle: nil)
        tableView.register(evalPostCell, forCellReuseIdentifier: "writtenEvalCell")
        let examPostCell = UINib(nibName: "writtenExamPostCell", bundle: nil)
        tableView.register(examPostCell, forCellReuseIdentifier: "writtenExamCell")
        
        getWrittenEvalData(page: 1)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 210
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewNumber == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "writtenEvalCell", for: indexPath) as! writtenEvalPostCell
            
            cell.semesterLabel.text = tableViewEvalData[indexPath.row].selectedSemester
            
            cell.lectureNameLabel.text = tableViewEvalData[indexPath.row].lectureName
            cell.professorLabel.text = tableViewEvalData[indexPath.row].professor
            
            cell.totalAvgLabel.text = tableViewEvalData[indexPath.row].totalAvg
            
            cell.satisfactionLabel.text = tableViewEvalData[indexPath.row].satisfaction
            cell.honeyLabel.text = tableViewEvalData[indexPath.row].honey
            cell.learningLabel.text = tableViewEvalData[indexPath.row].learning
            
            cell.teamLabel.text = tableViewEvalData[indexPath.row].team
            cell.homeworkLabel.text = tableViewEvalData[indexPath.row].homework
            cell.difficultyLabel.text = tableViewEvalData[indexPath.row].difficulty
            
            cell.contentLabel.text = tableViewEvalData[indexPath.row].content
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 1 {
            return tableViewEvalData.count
        } else {
            return 1
        }
    }
    
    
    
    
    func getWrittenEvalData(page: Int) {
        let url = "https://api.suwiki.kr/evaluate-posts/findByUserIdx/"
        let parameters: Parameters = [
            "page" : page
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            
            let data = response.data
            let json = JSON(data ?? "")
            
            if json != "" {
                self.tableViewNumber = 1
                print(json)
                for index in 0..<json["data"].count{
                    let jsonData = json["data"][index]
                    
                    
                    var team = ""
                    var difficulty = ""
                    var homework = ""
                    
                    let totalAvg = String(format: "%.1f", round(jsonData["totalAvg"].floatValue * 1000) / 1000)
                    let satisfactionAvg = String(format: "%.1f", round(jsonData["satisfaction"].floatValue * 1000) / 1000)
                    let honeyAvg = String(format: "%.1f", round(jsonData["honey"].floatValue * 1000) / 1000)
                    let learningAvg = String(format: "%.1f", round(jsonData["learning"].floatValue * 1000) / 1000)
                    
                    if jsonData["team"] == 0 {
                        team = "없음"
                    } else if jsonData["team"] == 1 {
                        team = "있음"
                    }
                    
                    if jsonData["difficulty"] == 0{
                        difficulty = "까다로움"
                    } else if jsonData["difficulty"] == 1 {
                        difficulty = "보통"
                    } else if jsonData["difficulty"] == 2 {
                        difficulty = "개꿀"
                    }
                    
                    if jsonData["homework"] == 0 {
                        homework = "없음"
                    } else if jsonData["homework"] == 1{
                        homework = "보통"
                    } else if jsonData["homework"] == 2 {
                        homework = "많음"
                    }
                    
    
                    let readData = WrittenEvalPostData(id: jsonData["id"].intValue, lectureName: jsonData["lectureName"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, selectedSemester: jsonData["selectedSemester"].stringValue, totalAvg: totalAvg, satisfaction: satisfactionAvg, learning: learningAvg, honey: honeyAvg, team: team, difficulty: difficulty, homework: homework, content: jsonData["content"].stringValue)
                    
                    
                    self.tableViewEvalData.append(readData)
                }
                self.tableView.reloadData()
                print(self.tableViewEvalData)
            } else {
                self.tableViewNumber = 0
            }
        }
    }


    func getWrittenExamData() {
        let url = "https://api.suwiki.kr/exam-posts/findByUserIdx/?page={}"
    }
}
