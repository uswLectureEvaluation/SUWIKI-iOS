//
//  lectureDetailedInformationPage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/04.
//

import UIKit
import KeychainSwift
import Alamofire
import SwiftyJSON

// 1. 화면이 켜질 때 eval / exam 데이터 리스트에 저장
// 2. 데이터는 10개씩만 테이블 뷰에 보여주고, 이후 스크롤 시 이후 데이터 마저 불러오기
// 3. 강의평가 -> 시험평가 버튼 클릭 시 메인 리스트 비우고, reloadData 진행
// 테이블뷰넘버로 시험정보 구매 여부 확인 후 넘버 변경 -> 시험 정보 출력

class lectureDetailedInformationPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lectureView: UIView!
    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var professor: UILabel!
    
    @IBOutlet weak var teamView: UILabel!
    @IBOutlet weak var homeworkView: UILabel!
    @IBOutlet weak var pointView: UILabel!
    
    @IBOutlet weak var lectureHoneyAvg: UILabel!
    @IBOutlet weak var lectureLearningAvg: UILabel!
    @IBOutlet weak var lectureSatisAvg: UILabel!
  
    @IBOutlet weak var evaluationBtn: UIButton!
    @IBOutlet weak var examBtn: UIButton!
    
    @IBOutlet weak var writeBtn: UIButton!
    
    var detailViewArray: Array<Any> = []
    var detailLectureArray: Array<detailLecture> = []
    var detailEvaluationArray: Array<detailEvaluation> = []
    var detailExamArray: Array<detailExam> = []
    
    var testArray = ["1", "2", "3", "4", "5"]
    var testArray1 = ["1", "2", "3"]
    
    var lectureId = 0
    let keychain = KeychainSwift()
    

    var tableViewNumber = 0
    var examDataExist = 0
    
    override func viewDidLoad() {
        
        tableViewNumber = 0
        loadDetailData()
        print(lectureId)
        lectureView.layer.borderWidth = 1.0
        lectureView.layer.borderColor = UIColor.lightGray.cgColor
        lectureView.layer.cornerRadius = 12.0
        super.viewDidLoad()
        getDetailPage()
        evaluationBtn.tintColor = .darkGray
        
        scrollView.isDirectionalLockEnabled = true
        
        // Xib 등록
        let evaluationCellName = UINib(nibName: "detailEvaluationCell", bundle: nil)
        tableView.register(evaluationCellName, forCellReuseIdentifier: "evaluationCell")
        let examCellName = UINib(nibName: "detailExamCell", bundle: nil)
        tableView.register(examCellName, forCellReuseIdentifier: "examCell")
        let noExamDataExistsCellName = UINib(nibName: "noExamDataExistsCell", bundle: nil)
        tableView.register(noExamDataExistsCellName, forCellReuseIdentifier: "noDataCell")
        let examInfoTakeCellName = UINib(nibName: "examInfoTakeCell", bundle: nil)
        tableView.register(examInfoTakeCellName, forCellReuseIdentifier: "takeInfoCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 210
        self.tableView.reloadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        print("viewdidload")

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    @IBAction func evaluationBtnClicked(_ sender: Any) {
        writeBtn.setTitle("강의 정보 쓰기", for: .normal)
        writeBtn.titleLabel!.font = UIFont.systemFont(ofSize: 13)

        tableViewNumber = 0
        evaluationBtn.tintColor = .darkGray
        examBtn.tintColor = .lightGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
       
        
    }
    
    @IBAction func examBtnClicked(_ sender: Any) {
        writeBtn.setTitle("시험 정보 쓰기", for: .normal)
        writeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        // tableviewNumber = 1은 시험 리스트 없을때 설정, 2는 미구매시
        examBtn.tintColor = .darkGray
        evaluationBtn.tintColor = .lightGray
        
        if examDataExist == 0 {
            tableViewNumber = 1
            tableView.estimatedRowHeight = 130
            tableView.rowHeight = UITableView.automaticDimension
            tableView.reloadData()
        } else {
            if examDataExist == 1 {
                tableViewNumber = 2
                tableView.estimatedRowHeight = 130
                tableView.rowHeight = UITableView.automaticDimension
                tableView.reloadData()
            } else if examDataExist == 2 {
                tableViewNumber = 3 // 3이면 시험정보 구매한 상   
                tableView.estimatedRowHeight = 130
                tableView.rowHeight = UITableView.automaticDimension
                tableView.reloadData()
            }
            
        }
    
        
    }

    @IBAction func InfoWriteBtnClicked(_ sender: Any) {
        // 조건문 추가하여 어느
        if tableViewNumber == 0 {
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "evalWriteVC") as! lectureEvaluationWritePage
            nextVC.lectureName = lectureName.text!
            nextVC.professor = professor.text!
            nextVC.lectureId = lectureId
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
        } else {
            
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 0 {
            return self.detailEvaluationArray.count
        } else if tableViewNumber == 1 || tableViewNumber == 2{
            return 1
        } else {
            return self.detailExamArray.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableViewNumber == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "evaluationCell", for: indexPath) as! detailEvaluationCell
            
            cell.content.numberOfLines = 0
            
            cell.semester.text = detailEvaluationArray[indexPath.row].semester
            cell.totalAvg.text = detailEvaluationArray[indexPath.row].totalAvg
            cell.satisfactionPoint.text = detailEvaluationArray[indexPath.row].satisfaction
            cell.honeyPoint.text = detailEvaluationArray[indexPath.row].honey
            cell.learningPoint.text = detailEvaluationArray[indexPath.row].learning
            cell.team.text = detailEvaluationArray[indexPath.row].team
            cell.homework.text = detailEvaluationArray[indexPath.row].homework
            cell.difficulty.text = detailEvaluationArray[indexPath.row].difficulty
            cell.content.text = detailEvaluationArray[indexPath.row].content
            
            return cell
            
        } else if tableViewNumber == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! noExamDataExistsCell
            cell.noExamData.text = "시험 정보가 없어요 !"
            return cell
            
        } else if tableViewNumber == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "takeInfoCell", for: indexPath) as! examInfoCell
            cell.takeBtn.tag = indexPath.row
            cell.takeBtn.addTarget(self, action: #selector(takeBtnClicked), for: .touchUpInside)
            
            return cell
            
        } else if tableViewNumber == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "examCell", for: indexPath) as! detailExamCell
            
            cell.content.numberOfLines = 0
            
            cell.examType.text = detailExamArray[indexPath.row].examInfo
            cell.examDifficulty.text = detailExamArray[indexPath.row].examDifficulty
            cell.content.text = detailExamArray[indexPath.row].content
            
            return cell
        }
        return UITableViewCell()
           
    }

    func lectureViewUpdate(){
        
        lectureName.text = detailLectureArray[0].lectureName
        lectureName.sizeToFit()
        professor.text = detailLectureArray[0].professor
        professor.sizeToFit()
        lectureHoneyAvg.text = detailLectureArray[0].lectureHoneyAvg
        lectureLearningAvg.text = detailLectureArray[0].lectureLearningAvg
        lectureSatisAvg.text = detailLectureArray[0].lectureSatisfactionAvg
    
    }
    
    func getDetailPage(){
        
        let url = "https://api.suwiki.kr/lecture/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            
            let data = response.value
            
            let json = JSON(data ?? "")["data"]
      
            let totalAvg = String(format: "%.1f", round(json["lectureTotalAvg"].floatValue * 1000) / 1000)
            let totalSatisfactionAvg = String(format: "%.1f", round(json["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
            let totalHoneyAvg = String(format: "%.1f", round(json["lectureHoneyAvg"].floatValue * 1000) / 1000)
            let totalLearningAvg = String(format: "%.1f", round(json["lectureLearningAvg"].floatValue * 1000) / 1000)
            
            let detailLectureData = detailLecture(id: json["id"].intValue, semester: json["semester"].stringValue, professor: json["professor"].stringValue, majorType: json["majorType"].stringValue, lectureType: json["lectureType"].stringValue, lectureName: json["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg, lectureTeamAvg: json["lectureTeamAvg"].floatValue, lectureDifficultyAvg: json["lectureDifficultyAvg"].floatValue, lectureHomeworkAvg: json["lectureHomeworkAvg"].floatValue)

            self.detailLectureArray.append(detailLectureData)
            self.lectureViewUpdate()
            
        }
        
        
    }
    
    func loadDetailData(){
        DispatchQueue.global().async {
            self.getDetailEvaluation()
            self.getDetailExam()
        }
        tableView.reloadData()
        
    }
    
    func getDetailEvaluation(){

        let url = "https://api.suwiki.kr/evaluate-posts/findByLectureId/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            let data = response.value
            let json = JSON(data ?? "")
    
            for index in 0..<json["data"].count{
                let jsonData = json["data"][index]
                var team = ""
                var difficulty = ""
                var homework = ""
                let totalAvg = String(format: "%.1f", round(jsonData["totalAvg"].floatValue * 1000) / 1000)
                let satisfaction = String(format: "%.1f", round(jsonData["satisfaction"].floatValue * 1000) / 1000)
                let learning = String(format: "%.1f", round(jsonData["learning"].floatValue * 1000) / 1000)
                let honey = String(format: "%.1f", round(jsonData["honey"].floatValue * 1000) / 1000)
                
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
                print(jsonData)
                let readData = detailEvaluation(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, totalAvg: totalAvg, satisfaction: satisfaction, learning: learning, honey: honey, team: team, difficulty: difficulty, homework: homework, content: jsonData["content"].stringValue)
                
                self.detailEvaluationArray.append(readData)
            }
            self.tableView.reloadData()
        }
    }
    
    func getDetailExam(){
        
        let url = "https://api.suwiki.kr/exam-posts/findByLectureId/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            let data = response.value
            let json = JSON(data ?? "")
            if json["examDataExist"].boolValue == false {
                self.examDataExist = 0
                print("false")
            } else if json["examDataExist"].boolValue == true {
                
                if json["data"].count == 0{
                    self.examDataExist = 1 // 시험 정보는 존재하나 구매하지 않은 상태
                    
                } else {
                    self.examDataExist = 2 // 시험 정보 구매한 상태
                    for index in 0..<json["data"].count{
                        let jsonData = json["data"][index]
                        let readData = detailExam(id: jsonData["id"].intValue, semester: jsonData["semester"].stringValue, examInfo: jsonData["examInfo"].stringValue, examType: jsonData["examType"].stringValue, examDifficulty: jsonData["examDifficulty"].stringValue, content: jsonData["content"].stringValue)
                        
                        self.detailExamArray.append(readData)
                       }
                    
                    self.tableView.reloadData()
                }
                print(self.detailExamArray)
            }
            // examDataExist를 트루로 확인하고 내부 데이터 받아오는 것 없을 경우
            // 시험 정보 구매 뷰 보여줘야 하고,
            // 만약 배열 받아오는 정보가 있을 경우는 바로 시험정보를 보여주면 된다.
            // false로 받아올 경우는 시험정보가 없다는 정보를 표시해주면 됨.
            
            /*
            
               */
           
            print(self.detailExamArray)
        }
    }
    
    @objc func takeBtnClicked(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let AD = UIApplication.shared.delegate as? AppDelegate
        
        let lectureId = Int(AD?.lectureId ?? 0)
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]

        let url = "https://api.suwiki.kr/exam-posts/buyExamInfo/?lectureId=\(lectureId)"
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let data = response.response?.statusCode
            if Int(data!) == 200{
                print("success")
                self.getDetailExam()
                self.tableViewNumber = 3
            } else if Int(data!) == 403{
                print("fail")
                
            }
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 0{
            scrollView.contentOffset.x = 0
        }
    }
    
}

class examInfoCell: UITableViewCell{
    
    @IBOutlet weak var takeBtn: UIButton!
    
}
