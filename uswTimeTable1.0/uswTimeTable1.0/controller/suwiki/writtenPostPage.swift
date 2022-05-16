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
        
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 210
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewEvalData.removeAll()
        getWrittenEvalData(page: 1)
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
            
            cell.contentLabel.text = tableViewEvalData[indexPath.row].content + "\n"
            
            cell.adjustBtn.tag = indexPath.row
            cell.adjustBtn.addTarget(self, action: #selector(adjustBtnClicked), for: .touchUpInside)

            
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
    
    
    @objc func adjustBtnClicked(sender: UIButton)
    {
        let indexPath = IndexPath(row: sender.tag, section: 0)

        let nextVC = storyboard?.instantiateViewController(withIdentifier: "evalWriteVC") as! lectureEvaluationWritePage
        
        switch tableViewEvalData[indexPath.row].team {
        case "없음" :
            nextVC.teamWorkType.haveTeamWork = false
            nextVC.teamWorkType.noTeamWork = true
        case "있음" :
            nextVC.teamWorkType.haveTeamWork = true
            nextVC.teamWorkType.noTeamWork = false
        default:
            break
        }
        
        switch tableViewEvalData[indexPath.row].homework{
        case "없음" :
            nextVC.homeworkType.noHomework = true
            nextVC.homeworkType.usuallyHomework = false
            nextVC.homeworkType.manyHomework = false
        case "보통" :
            nextVC.homeworkType.noHomework = false
            nextVC.homeworkType.usuallyHomework = true
            nextVC.homeworkType.manyHomework = false
        case "많음" :
            nextVC.homeworkType.noHomework = false
            nextVC.homeworkType.usuallyHomework = false
            nextVC.homeworkType.manyHomework = true
        default:
            break
        }
        
        switch tableViewEvalData[indexPath.row].difficulty{
        case "개꿀" :
            nextVC.difficultyType.easyDifficulty = true
            nextVC.difficultyType.normalDifficulty = false
            nextVC.difficultyType.hardDifficulty = false
        case "보통" :
            nextVC.difficultyType.easyDifficulty = false
            nextVC.difficultyType.normalDifficulty = true
            nextVC.difficultyType.hardDifficulty = false
        case "까다로움" :
            nextVC.difficultyType.easyDifficulty = false
            nextVC.difficultyType.normalDifficulty = false
            nextVC.difficultyType.hardDifficulty = true
        default:
            break
        }
    
        nextVC.adjustBtn = 1
        nextVC.evaluateIdx = tableViewEvalData[indexPath.row].id
        nextVC.adjustContent = tableViewEvalData[indexPath.row].content
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
}
