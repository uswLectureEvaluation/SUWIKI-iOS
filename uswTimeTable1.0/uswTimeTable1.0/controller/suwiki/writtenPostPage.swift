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
import Cosmos


// 개설학과 리스트 받아와야 함


class writtenPostPage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var evalBtn: UIButton!
    @IBOutlet weak var examBtn: UIButton!
    
    
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
        
        let noExamDataExistsCellName = UINib(nibName: "noExamDataExistsCell", bundle: nil)
        tableView.register(noExamDataExistsCellName, forCellReuseIdentifier: "noDataCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 210
        self.tableView.reloadData()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewExamData.removeAll()
        tableViewEvalData.removeAll()
        getWrittenEvalData(page: 1)
        getWrittenExamData(page: 1)
        evalBtn.setTitleColor(.black, for: .normal)
        examBtn.setTitleColor(.lightGray, for: .normal)
    }
    
    @IBAction func evalBtnClicked(_ sender: Any) {
        if tableViewEvalData.count == 0{
            tableViewNumber = 3
        } else {
            tableViewNumber = 1
        }
            
        tableView.reloadData()
        evalBtn.setTitleColor(.black, for: .normal)
        examBtn.setTitleColor(.lightGray, for: .normal)
    }
    
    @IBAction func examBtnClicked(_ sender: Any) {
        if tableViewExamData.count == 0 {
            tableViewNumber = 4
        } else {
            tableViewNumber = 2
        }
        
        tableView.reloadData()
        evalBtn.setTitleColor(.lightGray, for: .normal)
        examBtn.setTitleColor(.black, for: .normal)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewNumber == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "writtenEvalCell", for: indexPath) as! writtenEvalPostCell
            
            cell.semesterLabel.text = tableViewEvalData[indexPath.row].selectedSemester
            
            cell.lectureNameLabel.text = tableViewEvalData[indexPath.row].lectureName
            cell.professorLabel.text = tableViewEvalData[indexPath.row].professor
            
            cell.totalAvgLabel.text = tableViewEvalData[indexPath.row].totalAvg
            cell.ratingBarView.rating = Double(tableViewEvalData[indexPath.row].totalAvg)!
    
            cell.satisfactionLabel.text = tableViewEvalData[indexPath.row].satisfaction
            cell.honeyLabel.text = tableViewEvalData[indexPath.row].honey
            cell.learningLabel.text = tableViewEvalData[indexPath.row].learning
            
            cell.teamLabel.text = tableViewEvalData[indexPath.row].team
            cell.homeworkLabel.text = tableViewEvalData[indexPath.row].homework
            cell.difficultyLabel.text = tableViewEvalData[indexPath.row].difficulty
            
            cell.contentLabel.text = tableViewEvalData[indexPath.row].content + "\n"
            
            cell.adjustBtn.tag = indexPath.row
            cell.adjustBtn.addTarget(self, action: #selector(adjustEvaluationBtnClicked), for: .touchUpInside)

            cell.delBtn.tag = indexPath.row
            cell.delBtn.addTarget(self, action: #selector(deleteEvaluationBtnClicked), for: .touchUpInside)
            
            return cell
        } else if tableViewNumber == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "writtenExamCell", for: indexPath) as! writtenExamPostCell
            
            cell.semesterLabel.text = tableViewExamData[indexPath.row].selectedSemester
            cell.examTypeLabel.text = tableViewExamData[indexPath.row].examType
            
            cell.lectureNameLabel.text = tableViewExamData[indexPath.row].lectureName
            cell.professorLabel.text = tableViewExamData[indexPath.row].professor
            
            cell.examDifficultyLabel.text = tableViewExamData[indexPath.row].examDifficulty
            cell.examInfoLabel.text = tableViewExamData[indexPath.row].examInfo
            
            cell.contentLabel.text = tableViewExamData[indexPath.row].content + "\n"
            
            cell.adBtn.tag = indexPath.row
            cell.adBtn.addTarget(self, action: #selector(adjustExamBtnClicked), for: .touchUpInside)
            cell.delBtn.tag = indexPath.row
            cell.delBtn.addTarget(self, action: #selector(deleteExamBtnClicked), for: .touchUpInside)
            
            return cell
            
            
        } else if tableViewNumber == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! noExamDataExistsCell
            cell.noExamData.text = "강의평가가 없습니다."
            
            return cell
        } else if tableViewNumber == 4{
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! noExamDataExistsCell
            cell.noExamData.text = "시험정보가 없습니다."
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 1 {
            return tableViewEvalData.count
        } else if tableViewNumber == 2 {
            return tableViewExamData.count
        } else {
            return 1
        }
    }
    
    
    
    
    func getWrittenEvalData(page: Int) {
        let url = "https://api.suwiki.kr/evaluate-posts/written/"
        let parameters: Parameters = [
            "page" : page
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            
            let data = response.data
            let json = JSON(data ?? "")
            print(json)
            print(json["data"].count)
            if json["data"].count == 0 {
                self.tableViewNumber = 3
                
            } else if json != "" {
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
            }
            self.tableView.reloadData()
        }
    }
    
    
    func getWrittenExamData(page: Int) {
        let url = "https://api.suwiki.kr/exam-posts/written/"
        
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
                for index in 0..<json["data"].count{
                    let jsonData = json["data"][index]
                 
                    let readData = WrittenExamPostData(id: jsonData["id"].intValue, lectureName: jsonData["lectureName"].stringValue, professor: jsonData["professor"].stringValue, majorType: jsonData["majorType"].stringValue, selectedSemester: jsonData["selectedSemester"].stringValue, examType: jsonData["examType"].stringValue, examInfo: jsonData["examInfo"].stringValue, examDifficulty: jsonData["examDifficulty"].stringValue, content: jsonData["content"].stringValue)
                    
                    self.tableViewExamData.append(readData)
                     
                }// 셀이랑 시험 정보 연결, 시험정보 수정, 시험정보 삭제 진행
                self.tableView.reloadData()
            } else {
                self.tableViewNumber = 0
            }
        }
        
        
        
    }
    
    // MARK: 강의평가 수정 및 삭제 버튼 클릭
    @objc func adjustEvaluationBtnClicked(sender: UIButton)
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
        nextVC.lectureName = tableViewEvalData[indexPath.row].lectureName
        // 수정 시 여러개의 학기 받아오는 방법 생각해보아야 함.
        nextVC.semesterList.append(tableViewExamData[indexPath.row].selectedSemester)
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @objc func deleteEvaluationBtnClicked(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let removeAlert = UIAlertController(title: "강의평가 삭제", message: "삭제 하시겠어요?", preferredStyle: UIAlertController.Style.alert)
        
        let deleteButton = UIAlertAction(title: "삭제", style: .destructive, handler: { [self] (action) -> Void in
            print("Delete button tapped")
            removeEvaluation(id: tableViewEvalData[indexPath.row].id)
   
        })
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        removeAlert.addAction(deleteButton)
        removeAlert.addAction(cancelButton)
        present(removeAlert, animated: true, completion: nil)
    }
    
    func removeEvaluation(id: Int) {
        let url = "https://api.suwiki.kr/evaluate-posts/?evaluateIdx=\(id)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .delete, parameters: nil, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            
            if response.response?.statusCode == 400 {
                let alert = UIAlertController(title:"유저 포인트가 부족합니다.",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            } else if response.response?.statusCode == 403 {
                let alert = UIAlertController(title:"제한된 유저십니다 ^^",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.viewWillAppear(true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // MARK: 시험정보 수정 및 삭제 버튼 클릭
    @objc func adjustExamBtnClicked(sender: UIButton)
    {
        let indexPath = IndexPath(row: sender.tag, section: 0)

        let nextVC = storyboard?.instantiateViewController(withIdentifier: "examWriteVC") as! lectureExamWritePage
        
        switch tableViewExamData[indexPath.row].examDifficulty{
        case "쉬움":
            nextVC.levelType.easyLevel = true
            nextVC.levelType.normalLevel = false
            nextVC.levelType.hardLevel = false
            
        case "보통":
            nextVC.levelType.easyLevel = false
            nextVC.levelType.normalLevel = true
            nextVC.levelType.hardLevel = false
            
        case "어려움":
            nextVC.levelType.easyLevel = false
            nextVC.levelType.normalLevel = true
            nextVC.levelType.hardLevel = false
        
        default:
            break
        }
        
        nextVC.semesterList.append(tableViewExamData[indexPath.row].selectedSemester)
        nextVC.adjustBtn = 1
        nextVC.examIdx = tableViewExamData[indexPath.row].id
        nextVC.adjustContent = tableViewExamData[indexPath.row].content
        nextVC.lectureName = tableViewExamData[indexPath.row].lectureName
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @objc func deleteExamBtnClicked(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let removeAlert = UIAlertController(title: "시험정보 삭제", message: "삭제 하시겠어요?", preferredStyle: UIAlertController.Style.alert)
        
        let deleteButton = UIAlertAction(title: "삭제", style: .destructive, handler: { [self] (action) -> Void in
            print("Delete button tapped")
            removeExam(id: tableViewExamData[indexPath.row].id)
   
        })
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        removeAlert.addAction(deleteButton)
        removeAlert.addAction(cancelButton)
        present(removeAlert, animated: true, completion: nil)
    }
    
    func removeExam(id: Int){
        let url = "https://api.suwiki.kr/exam-posts/?examIdx=\(id)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .delete, parameters: nil, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            
            print(JSON(response.data))
            print(response.data)
            if response.response?.statusCode == 400{
                let alert = UIAlertController(title:"유저 포인트가 부족합니다.",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            } else if response.response?.statusCode == 403 {
                let alert = UIAlertController(title:"제한된 유저십니다 ^^",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.viewWillAppear(true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
