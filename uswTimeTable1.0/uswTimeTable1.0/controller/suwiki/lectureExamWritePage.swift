//
//  lectureExamWritePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/28.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import DropDown

class lectureExamWritePage: UIViewController {
    
    @IBOutlet weak var examTypeDropDown: UIView!
    @IBOutlet weak var examTypeTextField: UILabel!
    
    @IBOutlet weak var semesterDropDown: UIView!
    @IBOutlet weak var semesterTextField: UILabel!
    
    @IBOutlet weak var lectureNameLabel: UILabel!
    
    @IBOutlet weak var easyLevelBtn: UIButton!
    @IBOutlet weak var normalLevelBtn: UIButton!
    @IBOutlet weak var hardLevelBtn: UIButton!
    
    @IBOutlet weak var jokboBtn: UIButton!
    @IBOutlet weak var textbookBtn: UIButton!
    @IBOutlet weak var pptBtn: UIButton!
    @IBOutlet weak var applicationBtn: UIButton!
    @IBOutlet weak var trainingBtn: UIButton!
    @IBOutlet weak var homeworkBtn: UIButton!
    
    @IBOutlet weak var contentField: UITextView!
    
   
    let semeDropDown = DropDown()
    let examDropDown = DropDown()
    let keychain = KeychainSwift()
    
    var levelType = examBtnClickedType.levelType()
    var examType = examBtnClickedType.examType()
    
    var lectureName = ""
    var professor = ""
    var lectureId = 0
    
    var examTypeArray: [String] = []
    var examTypeArrayCount = 0

    var semesterList: [String] = []
    let examTypeList = ["중간고사", "기말고사", "쪽지", "기타"]
    
    var tableViewNumber = 0
    var evalDataList = 0
    
    var adjustBtn = 0
    var adjustContent: String = ""
    var examIdx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(keychain.get("AccessToken"))
        print(lectureId)
        
        if adjustBtn == 1{
            getAdjustExam()
        }
        
        examTypeDropDown.layer.cornerRadius = 8.0
        examTypeDropDown.layer.borderColor = UIColor.lightGray.cgColor
        examTypeDropDown.layer.borderWidth = 1.0
        
        semesterDropDown.layer.cornerRadius = 8.0
        semesterDropDown.layer.borderWidth = 1.0
        semesterDropDown.layer.borderColor = UIColor.lightGray.cgColor
        
        semeDropDown.anchorView = semesterDropDown
        semeDropDown.dataSource = semesterList
        semeDropDown.bottomOffset = CGPoint(x: 0, y:(semeDropDown.anchorView?.plainView.bounds.height)!)
        semeDropDown.direction = .bottom
        semeDropDown.textFont = UIFont.systemFont(ofSize: 16)

        semeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.semesterTextField.text = semesterList[index]
            self.semesterTextField.font = UIFont.systemFont(ofSize: 16)
            self.semesterTextField.textColor = UIColor.black
            self.semesterTextField.textAlignment = .center
        }
        
        examDropDown.anchorView = examTypeDropDown
        examDropDown.dataSource = examTypeList
        examDropDown.bottomOffset = CGPoint(x: 0, y:(examDropDown.anchorView?.plainView.bounds.height)!)
        examDropDown.direction = .bottom
        examDropDown.textFont = UIFont.systemFont(ofSize: 16)

        examDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.examTypeTextField.text = examTypeList[index]
            self.examTypeTextField.font = UIFont.systemFont(ofSize: 16)
            self.examTypeTextField.textColor = UIColor.black
            self.examTypeTextField.textAlignment = .center
        }
        
        
        
    }
    
    @IBAction func semesterBtnClicked(_ sender: Any) {
        semeDropDown.show()
    }
    
    
    @IBAction func examTypeBtnClicked(_ sender: Any) {
        examDropDown.show()
    }
    // examType bool값 확인 후 true false 일 경우 append or remove - n번째 요소. or 그 단어 제거 해주기
    // list.joined(separator: ", ")로 완료 버튼 누를 시 update 해줌
    //
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finishBtnClicked(_ sender: Any) {
        if examTypeArray.count == 0 || contentField.text == "" || levelType.levelPoint == 3 || examTypeTextField.text == "선택" || semesterTextField.text == "선택" {
            let alert = UIAlertController(title:"빈 데이터가 있어요 !",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            if adjustBtn == 0 {
                writeExam()
            } else if adjustBtn == 1{
                writeAdjustExam()
            }
        }
        
    }
    
    func writeExam() {
        let examInfo: String = examTypeArray.joined(separator: ", ")
        let url = "https://api.suwiki.kr/exam-posts/?lectureId=\(lectureId)"
        //
        let parameters: Parameters = [
            "lectureName" : lectureName, //과목 이름
            "professor" : professor, //교수이름
            "selectedSemester" : semesterTextField.text!, //  semesterTextField.text!, //학기 (ex) 2022-1)
            "examInfo" : examInfo, //시험 방식
            "examType" : examTypeTextField.text!,   //examTypeTextField.text!,
            "examDifficulty" : "쉬움", //시험 난이도
            "content" : contentField.text!
        ]
        print(parameters)
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            
    
            if response.response?.statusCode == 400{
                let alert = UIAlertController(title:"이미 작성하셨습니다 ^^",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(cancle)
                self.present(alert, animated: true, completion: nil)
            } else if response.response?.statusCode == 403 {
                let alert = UIAlertController(title:"제한된 유저십니다 ^^",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                //2. 확인 버튼 만들기
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                //3. 확인 버튼을 경고창에 추가하기
                alert.addAction(cancle)
                //4. 경고창 보이기
                self.present(alert, animated: true, completion: nil)
            } else {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! lectureDetailedInformationPage
                nextVC.tableViewNumber = self.tableViewNumber
                nextVC.evalDataExist = self.evalDataList
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func writeAdjustExam(){
        let examInfo: String = examTypeArray.joined(separator: ", ")
        let url = "https://api.suwiki.kr/exam-posts/?examIdx=\(examIdx)"
        
        let parameters: Parameters = [
            "selectedSemester" : semesterTextField.text!, //  semesterTextField.text!, //학기 (ex) 2022-1)
            "examInfo" : examInfo, //시험 방식
            "examType" : examTypeTextField.text!,   //examTypeTextField.text!,
            "examDifficulty" : "쉬움", //시험 난이도
            "content" : contentField.text!
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers, interceptor: BaseInterceptor()).validate().responseJSON { response in
            
           if response.response?.statusCode == 403 {
                let alert = UIAlertController(title:"제한된 유저십니다 ^^",
                    message: "확인을 눌러주세요!",
                    preferredStyle: UIAlertController.Style.alert)
                //2. 확인 버튼 만들기
                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
                //3. 확인 버튼을 경고창에 추가하기
                alert.addAction(cancle)
                //4. 경고창 보이기
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func getAdjustExam(){
        
        contentField.text = adjustContent
        levelType.checkPoint(easy: levelType.easyLevel, normal: levelType.normalLevel, hard: levelType.hardLevel)
        levelPointCheck()
        
    }
    
    @IBAction func jokboBtnClicked(_ sender: Any) {
        if examType.jokboCheck {
            examType.jokboCheck = false
            if let firstIndex = examTypeArray.firstIndex(of: "족보") {
                examTypeArray.remove(at: firstIndex)
            }
            jokboBtn.setTitleColor(.darkGray, for: .normal)
        } else {
            examTypeArray.append("족보")
            examType.jokboCheck = true
            jokboBtn.setTitleColor(.black, for: .normal)
        }
        print(examTypeArray)
    }
    
    @IBAction func textBookBtnClicked(_ sender: Any) {
        if examType.textbookCheck {
            examType.textbookCheck = false
            if let firstIndex = examTypeArray.firstIndex(of: "교재") {
                examTypeArray.remove(at: firstIndex)
            }
            textbookBtn.setTitleColor(.darkGray, for: .normal)
        } else {
            examType.textbookCheck = true
            examTypeArray.append("교재")
            textbookBtn.setTitleColor(.black, for: .normal)
        }
        print(examTypeArray)
    }
    
    @IBAction func pptBtnClicked(_ sender: Any) {
        if examType.pptCheck {
            examType.pptCheck = false
            if let firstIndex = examTypeArray.firstIndex(of: "PPT") {
                examTypeArray.remove(at: firstIndex)
            }
            pptBtn.setTitleColor(.darkGray, for: .normal)
        } else {
            examType.pptCheck = true
            examTypeArray.append("PPT")
            pptBtn.setTitleColor(.black, for: .normal)
        }
        print(examTypeArray)
    }
    
    @IBAction func applicationBtnClicked(_ sender: Any) {
        if examType.applicationCheck {
            examType.applicationCheck = false
            if let firstIndex = examTypeArray.firstIndex(of: "응용") {
                examTypeArray.remove(at: firstIndex)
            }
            applicationBtn.setTitleColor(.darkGray, for: .normal)
        } else {
            examType.applicationCheck = true
            examTypeArray.append("응용")
            applicationBtn.setTitleColor(.black, for: .normal)
        }
        print(examTypeArray)
    }
    
    @IBAction func trainingBtnClicked(_ sender: Any) {
        if examType.trainingCheck {
            examType.trainingCheck = false
            if let firstIndex = examTypeArray.firstIndex(of: "실습") {
                examTypeArray.remove(at: firstIndex)
            }
            trainingBtn.setTitleColor(.darkGray, for: .normal)
        } else {
            examType.trainingCheck = true
            examTypeArray.append("실습")
            trainingBtn.setTitleColor(.black, for: .normal)
        }
        print(examTypeArray)
    }
    
    @IBAction func homeworkBtnClicked(_ sender: Any) {
        if examType.homeworkCheck {
            examType.homeworkCheck = false
            if let firstIndex = examTypeArray.firstIndex(of: "과제") {
                examTypeArray.remove(at: firstIndex)
            }
            homeworkBtn.setTitleColor(.darkGray, for: .normal)
        } else {
            examType.homeworkCheck = true
            examTypeArray.append("과제")
            homeworkBtn.setTitleColor(.black, for: .normal)
        }
        print(examTypeArray)
    }
    
    
    
    
    
    @IBAction func easyLevelBtnClicked(_ sender: Any) {
        levelTypeCheck(level: "easy")
        levelType.checkPoint(easy: levelType.easyLevel, normal: levelType.normalLevel, hard: levelType.hardLevel)
        levelPointCheck()
    }
    
    @IBAction func normalBtnClicked(_ sender: Any) {
        levelTypeCheck(level: "normal")
        levelType.checkPoint(easy: levelType.easyLevel, normal: levelType.normalLevel, hard: levelType.hardLevel)
        levelPointCheck()
    }
    
    @IBAction func hardBtnClicked(_ sender: Any) {
        levelTypeCheck(level: "hard")
        levelType.checkPoint(easy: levelType.easyLevel, normal: levelType.normalLevel, hard: levelType.hardLevel)
        levelPointCheck()
    }
    
    func levelTypeCheck(level: String){
        if level == "easy"{
            if levelType.easyLevel == true {
                levelType.easyLevel = false
                levelType.normalLevel = false
                levelType.hardLevel = false
            } else {
                levelType.easyLevel = true
                levelType.normalLevel = false
                levelType.hardLevel = false
            }
            
        } else if level == "normal" {
            if levelType.normalLevel == true {
                levelType.easyLevel = false
                levelType.normalLevel = false
                levelType.hardLevel = false
            } else {
                levelType.easyLevel = false
                levelType.normalLevel = true
                levelType.hardLevel = false
            }
            
        } else if level == "hard" {
            if levelType.hardLevel == true {
                levelType.easyLevel = false
                levelType.normalLevel = false
                levelType.hardLevel = false
            } else {
                levelType.easyLevel = false
                levelType.normalLevel = false
                levelType.hardLevel = true
            }
        }
    }
    
    func levelPointCheck() {
        if levelType.levelPoint == 0 {
            easyLevelBtn.setTitleColor(.black, for: .normal)
            normalLevelBtn.setTitleColor(.lightGray, for: .normal)
            hardLevelBtn.setTitleColor(.lightGray, for: .normal)
        } else if levelType.levelPoint == 1 {
            easyLevelBtn.setTitleColor(.lightGray, for: .normal)
            normalLevelBtn.setTitleColor(.black, for: .normal)
            hardLevelBtn.setTitleColor(.lightGray, for: .normal)
        } else if levelType.levelPoint == 2 {
            easyLevelBtn.setTitleColor(.lightGray, for: .normal)
            normalLevelBtn.setTitleColor(.lightGray, for: .normal)
            hardLevelBtn.setTitleColor(.black, for: .normal)
        } else {
            easyLevelBtn.setTitleColor(.lightGray, for: .normal)
            normalLevelBtn.setTitleColor(.lightGray, for: .normal)
            hardLevelBtn.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
}
