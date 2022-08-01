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
import Cosmos

// 1. 화면이 켜질 때 eval / exam 데이터 리스트에 저장
// 2. 데이터는 10개씩만 테이블 뷰에 보여주고, 이후 스크롤 시 이후 데이터 마저 불러오기
// 3. 강의평가 -> 시험평가 버튼 클릭 시 메인 리스트 비우고, reloadData 진행
// 테이블뷰넘버로 시험정보 구매 여부 확인 후 넘버 변경 -> 시험 정보 출력


// 0620 -- 시험정보 부분 클릭 시 회색으로 바뀌는 부분 수정 필요


class lectureDetailedInformationPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lectureView: UIView!
    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var professor: UILabel!
    @IBOutlet weak var majorType: UILabel!
    
    @IBOutlet weak var teamView: UILabel!
    @IBOutlet weak var homeworkView: UILabel!
    @IBOutlet weak var pointView: UILabel!
    
    @IBOutlet weak var lectureHoneyAvg: UILabel!
    @IBOutlet weak var lectureLearningAvg: UILabel!
    @IBOutlet weak var lectureSatisAvg: UILabel!
  
    @IBOutlet weak var evaluationBtn: UIButton!
    @IBOutlet weak var examBtn: UIButton!
    
    @IBOutlet weak var writeBtn: UIButton!
    
    
    var detailLectureArray: Array<detailLecture> = []
    var detailEvaluationArray: Array<detailEvaluation> = []
    var detailExamArray: Array<detailExam> = []
    var componentsSemester: Array<String> = []
    var testArray = ["1", "2", "3", "4", "5"]
    var testArray1 = ["1", "2", "3"]
    
    var lectureId = 0
    let keychain = KeychainSwift()
    
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)
    
    var evalPageLast: Bool = false // page의 수를 계산해주는 변수
    var evalPage = 1
    var examPage = 1
    var tableViewNumber = 0
    var examDataExist = 0
    var evalDataExist = 0
    
    override func viewDidLoad() {
        
    

        lectureView.layer.borderWidth = 1.0
        lectureView.layer.borderColor = UIColor.lightGray.cgColor
        lectureView.layer.cornerRadius = 12.0
        super.viewDidLoad()
        evaluationBtn.tintColor = .darkGray
        scrollView.isDirectionalLockEnabled = true
        
        writeBtn.layer.cornerRadius = 10.0
        writeBtn.layer.borderColor = UIColor.white.cgColor
        writeBtn.layer.borderWidth = 1.0
        
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailExamArray.removeAll()
        detailLectureArray.removeAll()
        detailEvaluationArray.removeAll()
        
        evaluationBtn.tintColor = .darkGray
        examBtn.tintColor = .lightGray
        
        
        print("viewwillappear")
        
        loadDetailData()
        getDetailPage()
    }
    
    @IBAction func evaluationBtnClicked(_ sender: Any) {
        
        if evalDataExist == 0 {
            tableViewNumber = 0
        } else {
            tableViewNumber = 100
        }
        
        evaluationBtn.tintColor = .darkGray
        examBtn.tintColor = .lightGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    
    }
    
    @IBAction func examBtnClicked(_ sender: Any) {
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
        if tableViewNumber == 0 || tableViewNumber == 100{
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "evalWriteVC") as! lectureEvaluationWritePage
            
            nextVC.lectureName = lectureName.text!
            nextVC.professor = professor.text!
            nextVC.lectureId = lectureId
            // 이후에 , 기준으로 쪼개서 append 한 상태로 옮겨주면 될듯함.
            for index in 0..<componentsSemester.count {
                nextVC.semesterList.append(componentsSemester[index])
            }
            
            nextVC.adjustBtn = 0
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
        } else {
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "examWriteVC") as! lectureExamWritePage
            nextVC.lectureName = lectureName.text!
            nextVC.professor = professor.text!
            nextVC.lectureId = lectureId
            
            for index in 0..<componentsSemester.count {
                nextVC.semesterList.append(componentsSemester[index])
            }
            
            if evalDataExist == 0 {
                nextVC.tableViewNumber = 0
                nextVC.evalDataList = 0
            } else {
                nextVC.tableViewNumber = 100
                nextVC.evalDataList = 1
            }
            
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: nil)
            
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewNumber == 0 {
            return self.detailEvaluationArray.count
        } else if tableViewNumber == 1 || tableViewNumber == 2 || tableViewNumber == 100{
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
            if detailEvaluationArray[indexPath.row].team == "없음" {
                cell.team.textColor = colorLiteralBlue
            } else {
                cell.team.textColor = colorLiteralPurple
            }
            
            cell.homework.text = detailEvaluationArray[indexPath.row].homework
            if detailEvaluationArray[indexPath.row].homework == "없음" {
                cell.homework.textColor = colorLiteralBlue
            } else {
                cell.homework.textColor = colorLiteralPurple
            }
            
            cell.difficulty.text = detailEvaluationArray[indexPath.row].difficulty
            if detailEvaluationArray[indexPath.row].difficulty == "쉬움" {
                cell.difficulty.textColor = colorLiteralBlue
            } else {
                cell.difficulty.textColor = colorLiteralPurple
            }
            
            cell.content.text = detailEvaluationArray[indexPath.row].content + "\n"
            cell.ratingBarView.rating = Double(detailEvaluationArray[indexPath.row].totalAvg)!
            
            cell.reportBtn.tag = indexPath.row
            cell.reportBtn.addTarget(self, action: #selector(evalReportBtnClikced), for: .touchUpInside)
            
            return cell
            
        } else if tableViewNumber == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! noExamDataExistsCell
            cell.noExamData.text = "등록된 시험정보가 없어요!"
            
            return cell
            
        } else if tableViewNumber == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "takeInfoCell", for: indexPath) as! examInfoCell
            cell.takeBtn.tag = indexPath.row
            cell.takeBtn.addTarget(self, action: #selector(takeBtnClicked), for: .touchUpInside)
            
            return cell
            
        } else if tableViewNumber == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "examCell", for: indexPath) as! detailExamCell
            
            cell.content.numberOfLines = 0
            
            cell.semester.text = detailExamArray[indexPath.row].semester
            cell.examTypeLabel.text = detailExamArray[indexPath.row].examType
            // cell.examType.text = detailExamArray[indexPath.row].examInfo
            cell.examInfoLabel.text = detailExamArray[indexPath.row].examInfo
            cell.examDifficulty.text = detailExamArray[indexPath.row].examDifficulty
            
            if detailExamArray[indexPath.row].examDifficulty == "쉬움"{
                cell.examDifficulty.tintColor = colorLiteralBlue
            } else {
                cell.examDifficulty.tintColor = colorLiteralPurple
            }
            
            cell.content.text = detailExamArray[indexPath.row].content + "\n"
            
            cell.reportBtn.tag = indexPath.row
            cell.reportBtn.addTarget(self, action: #selector(examReportBtnClicked), for: .touchUpInside)
            
            return cell
        } else if tableViewNumber == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noDataCell", for: indexPath) as! noExamDataExistsCell
            
            cell.noExamData.text = "등록된 강의평가가 없어요!"
            
            return cell
        }
        return UITableViewCell()
           
    }

    func lectureViewUpdate(){
        
        lectureName.text = detailLectureArray[0].lectureName
        professor.text = detailLectureArray[0].professor
        lectureHoneyAvg.text = detailLectureArray[0].lectureHoneyAvg
        lectureLearningAvg.text = detailLectureArray[0].lectureLearningAvg
        lectureSatisAvg.text = detailLectureArray[0].lectureSatisfactionAvg
        majorType.text = detailLectureArray[0].majorType
        
        if detailLectureArray[0].lectureTeamAvg > 0.5 {
            teamView.text = "있음"
            teamView.textColor = colorLiteralBlue
        } else {
            teamView.text = "없음"
            teamView.textColor = colorLiteralPurple
        }
        
        if detailLectureArray[0].lectureHomeworkAvg < 0.5 {
            homeworkView.text = "없음"
            homeworkView.textColor = colorLiteralBlue
        } else if detailLectureArray[0].lectureHomeworkAvg < 1.5 {
            homeworkView.text = "보통"
            homeworkView.textColor = colorLiteralPurple
        } else {
            homeworkView.text = "많음"
            homeworkView.textColor = colorLiteralPurple
        }
        
        if detailLectureArray[0].lectureDifficultyAvg < 0.5 {
            pointView.text = "쉬움"
            pointView.textColor = colorLiteralBlue
        } else if detailLectureArray[0].lectureDifficultyAvg < 1.5 {
            pointView.text = "보통"
            pointView.textColor = colorLiteralPurple
        } else {
            pointView.text = "까다로움"
            pointView.textColor = colorLiteralPurple
        }
        
        let componentsData = String(detailLectureArray[0].semesterList).components(separatedBy: ", ")
        componentsSemester = componentsData
        collection.reloadData()
        
    }
    
    func getDetailPage(){
        
        let url = "https://api.suwiki.kr/lecture/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]

        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            
            let data = response.value

            let json = JSON(data ?? "")["data"]
            
            let totalAvg = String(format: "%.1f", round(json["lectureTotalAvg"].floatValue * 1000) / 1000)
            let totalSatisfactionAvg = String(format: "%.1f", round(json["lectureSatisfactionAvg"].floatValue * 1000) / 1000)
            let totalHoneyAvg = String(format: "%.1f", round(json["lectureHoneyAvg"].floatValue * 1000) / 1000)
            let totalLearningAvg = String(format: "%.1f", round(json["lectureLearningAvg"].floatValue * 1000) / 1000)
            
            let detailLectureData = detailLecture(id: json["id"].intValue, semesterList: json["semesterList"].stringValue, professor: json["professor"].stringValue, majorType: json["majorType"].stringValue, lectureType: json["lectureType"].stringValue, lectureName: json["lectureName"].stringValue, lectureTotalAvg: totalAvg, lectureSatisfactionAvg: totalSatisfactionAvg, lectureHoneyAvg: totalHoneyAvg, lectureLearningAvg: totalLearningAvg, lectureTeamAvg: json["lectureTeamAvg"].floatValue, lectureDifficultyAvg: json["lectureDifficultyAvg"].floatValue, lectureHomeworkAvg: json["lectureHomeworkAvg"].floatValue)
            
            
            self.detailLectureArray.append(detailLectureData)
            self.lectureViewUpdate()
        }
        
    }
    
    func loadDetailData(){
        DispatchQueue.global().async {
            self.getDetailEvaluation(lectureId: self.lectureId, evalPage: 1)
            self.getDetailExam()
        }
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableViewNumber == 0{
            let lastIndex = detailEvaluationArray.count - 1
            if indexPath.row == lastIndex{
                evalPage += 1
                if evalPageLast != true {
                    getDetailEvaluation(lectureId: lectureId, evalPage: evalPage)
                }
            }
        }
    }
    
    // #MARK: 무한스크롤 구현 필요
    func getDetailEvaluation(lectureId: Int, evalPage: Int){

        let url = "https://api.suwiki.kr/evaluate-posts/"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        let parameters: Parameters = [
            "lectureId" : lectureId,
            "page" : evalPage
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            let data = response.value
            let json = JSON(data ?? "")

            print(JSON(response.data))
            if json["data"].count < 10 {
                self.evalPageLast = true
            }
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
                    difficulty = "쉬움"
                }
                
                if jsonData["homework"] == 0 {
                    homework = "없음"
                } else if jsonData["homework"] == 1{
                    homework = "보통"
                } else if jsonData["homework"] == 2 {
                    homework = "많음"
                }
                let readData = detailEvaluation(id: jsonData["id"].intValue, semester: jsonData["selectedSemester"].stringValue, totalAvg: totalAvg, satisfaction: satisfaction, learning: learning, honey: honey, team: team, difficulty: difficulty, homework: homework, content: jsonData["content"].stringValue)
                
                
                
                self.detailEvaluationArray.append(readData)
            }
            if self.detailEvaluationArray.count != 0 {
                self.evalDataExist = 0
                self.tableViewNumber = 0
            } else {
                self.evalDataExist = 1
                self.tableViewNumber = 100
            }
          
            self.tableView.reloadData()
        }
    }
    
    func getDetailExam(){
        
        let url = "https://api.suwiki.kr/exam-posts/?lectureId=\(lectureId)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { (response) in
            let data = response.value
            let json = JSON(data ?? "")

            if json["examDataExist"].boolValue == false {
                self.examDataExist = 0
            } else if json["examDataExist"].boolValue == true {
                
                if json["data"].count == 0{
                    self.examDataExist = 1 // 시험 정보는 존재하나 구매하지 않은 상태
                    
                } else {
                    self.examDataExist = 2 // 시험 정보 구매한 상태
                    for index in 0..<json["data"].count{
                        let jsonData = json["data"][index]
                        let readData = detailExam(id: jsonData["id"].intValue, semester: jsonData["selectedSemester"].stringValue, examInfo: jsonData["examInfo"].stringValue, examType: jsonData["examType"].stringValue, examDifficulty: jsonData["examDifficulty"].stringValue, content: jsonData["content"].stringValue)
                        
                        self.detailExamArray.append(readData)
                       }
                    
                    self.tableView.reloadData()
                }
            }
            // examDataExist를 트루로 확인하고 내부 데이터 받아오는 것 없을 경우
            // 시험 정보 구매 뷰 보여줘야 하고,
            // 만약 배열 받아오는 정보가 있을 경우는 바로 시험정보를 보여주면 된다.
            // false로 받아올 경우는 시험정보가 없다는 정보를 표시해주면 됨.
            
            /*
            
               */
           
        }
    }
    
    @objc func evalReportBtnClikced(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let evaluateIdx = detailEvaluationArray[indexPath.row].id
        
        let evalReportAlert = UIAlertController(title: "신고 하시겠습니까?", message: "허위 신고시 제재가 가해질 수 있습니다.", preferredStyle: UIAlertController.Style.alert)
        
        let reportButton = UIAlertAction(title: "신고", style: .destructive, handler: { [self] (action) -> Void in
            evalReport(evaluateIdx: evaluateIdx)
        })
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        evalReportAlert.addAction(reportButton)
        evalReportAlert.addAction(cancelButton)
        present(evalReportAlert, animated: true, completion: nil)
        
    }
    
    func evalReport(evaluateIdx: Int){
        
        let url = "https://api.suwiki.kr/user/report/evaluate"
        
        let parameters: Parameters = [
            "evaluateIdx" : evaluateIdx,
            "content" : ""
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            let data = response.response?.statusCode
            
            if Int(data!) == 403 {
                let alert = UIAlertController(title:"제한된 유저입니다!",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func examReportBtnClicked(sender: UIButton){
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let examIdx = detailExamArray[indexPath.row].id
        
        let examReportAlert = UIAlertController(title: "신고 하시겠습니까?", message: "허위 신고시 제재가 가해질 수 있습니다.", preferredStyle: UIAlertController.Style.alert)
        
        let reportButton = UIAlertAction(title: "신고", style: .destructive, handler: { [self] (action) -> Void in
            examReport(examIdx: examIdx)
        })
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        examReportAlert.addAction(reportButton)
        examReportAlert.addAction(cancelButton)
        present(examReportAlert, animated: true, completion: nil)
        
    }
    
    func examReport(examIdx: Int){
        
        let url = "https://api.suwiki.kr/user/report/exam"
        
        let parameters: Parameters = [
            "evaluateIdx" : examIdx,
            "content" : ""
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            let data = response.response?.statusCode
            
            if Int(data!) == 403 {
                let alert = UIAlertController(title:"제한된 유저입니다!",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    }
    
    @objc func takeBtnClicked(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let AD = UIApplication.shared.delegate as? AppDelegate
        
        let lectureId = Int(AD?.lectureId ?? 0)
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]

        let url = "https://api.suwiki.kr/exam-posts/purchase/?lectureId=\(lectureId)"
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            let data = response.response?.statusCode
            if Int(data!) == 200{
                self.getDetailExam()
                self.tableViewNumber = 3
            } else if Int(data!) == 403{
                let alert = UIAlertController(title:"제한된 유저입니다!",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
                
            } else if Int(data!) == 400{
                let alert = UIAlertController(title:"포인트가 부족해요!",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        takeBtn.layer.borderWidth = 1.0
        takeBtn.layer.borderColor = UIColor.white.cgColor
        takeBtn.layer.cornerRadius = 10.0
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0
    }
    
}

class DetailSemesterCell: UICollectionViewCell{
    
    @IBOutlet weak var semesterLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = 8.0
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4))
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
//    }
}


extension lectureDetailedInformationPage: UICollectionViewDelegate{
    
}


extension lectureDetailedInformationPage: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return componentsSemester.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collection.dequeueReusableCell(withReuseIdentifier: "detailSemeCell", for: indexPath) as! DetailSemesterCell
        cell.semesterLabel.text = componentsSemester[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 61, height: 23)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
}
//
//extension lectureDetailedInformationPage: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.2
//
//    }
//}
