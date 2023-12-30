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


class lectureExamWritePage: UIViewController, UITextViewDelegate{
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    @IBOutlet weak var finishBtn: UIButton!
    
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
    
    var keyboardTouchCheck: Bool = false
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lectureNameLabel.text = lectureName
        
        if adjustBtn == 1{
            getAdjustExam()
            finishBtn.setTitle("수정하기", for: .normal)
        } else {
            contentField.text = "강의평가를 작성해주세요."
            contentField.textColor = UIColor.lightGray
        }
        
        btnCustom()
        
        contentField.delegate = self
       
        contentField.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        
        contentField.layer.borderColor = UIColor.lightGray.cgColor
        contentField.layer.borderWidth = 1.0
        contentField.layer.cornerRadius = 8.0
        
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
            self.semesterTextField.font = UIFont(name: "Pretendard", size: 14)
            self.semesterTextField.textAlignment = .center
        }
        
        examDropDown.anchorView = examTypeDropDown
        examDropDown.dataSource = examTypeList
        examDropDown.bottomOffset = CGPoint(x: 0, y:(examDropDown.anchorView?.plainView.bounds.height)!)
        examDropDown.direction = .bottom
        examDropDown.textFont = UIFont.systemFont(ofSize: 16)

        examDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.examTypeTextField.text = examTypeList[index]
            self.examTypeTextField.font = UIFont(name: "Pretendard", size: 14)
            self.examTypeTextField.textAlignment = .center
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MyTapMethod)) // 스크롤 뷰 화면 터치 시 키보드 올라감
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(singleTapGestureRecognizer)

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self) // 메모리
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if adjustBtn == 1{
            finishBtn.setTitle("수정하기", for: .normal)
            getAdjustExam()
        } else {
            contentField.text = "강의평가를 작성해주세요."
            contentField.textColor = UIColor.lightGray
        }
    }
    
    @objc func MyTapMethod(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
   
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
            let alert = UIAlertController(title:"입력하지 않은 내용이 있습니다.",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
        } else if contentField.text.count < 30 || contentField.text.count > 1000 {
            let alert = UIAlertController(title:"시험정보를 확인해주세요!",
                                        message: "내용은 30자 이상, 1000자 이하로 작성해주세요!",
                                        preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
        }
        
//            lse if contentField.text.count < 30 || contentField.text.count > 1000 {
//                let alert = UIAlertController(title:"강의평가를 확인해주세요!",
//                    message: "내용은 30자 이상, 1000자 이하로 작성해주세요!",
//                    preferredStyle: UIAlertController.Style.alert)
//                let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
//                alert.addAction(cancle)
//                self.present(alert, animated: true, completion: nil)
//
//            }
//
        else {
            if adjustBtn == 0 {
                writeExam()
            } else if adjustBtn == 1{
                writeAdjustExam()
            }
        }
        
    }
    
    func btnCustom(){
        
        easyLevelBtn.layer.cornerRadius = 10.0
        easyLevelBtn.layer.borderColor = UIColor.white.cgColor
        easyLevelBtn.layer.borderWidth = 1.0
        
        normalLevelBtn.layer.cornerRadius = 10.0
        normalLevelBtn.layer.borderWidth = 1.0
        normalLevelBtn.layer.borderColor = UIColor.white.cgColor
        
        hardLevelBtn.layer.cornerRadius = 10.0
        hardLevelBtn.layer.borderColor = UIColor.white.cgColor
        hardLevelBtn.layer.borderWidth = 1.0
        
        jokboBtn.layer.borderWidth = 1.0
        jokboBtn.layer.borderColor = UIColor.white.cgColor
        jokboBtn.layer.cornerRadius = 10.0
        
        textbookBtn.layer.borderWidth = 1.0
        textbookBtn.layer.borderColor = UIColor.white.cgColor
        textbookBtn.layer.cornerRadius = 10.0
        
        pptBtn.layer.borderColor = UIColor.white.cgColor
        pptBtn.layer.borderWidth = 1.0
        pptBtn.layer.cornerRadius = 10.0
    
        applicationBtn.layer.cornerRadius = 10.0
        applicationBtn.layer.borderWidth = 1.0
        applicationBtn.layer.borderColor = UIColor.white.cgColor
        
        trainingBtn.layer.cornerRadius = 10.0
        trainingBtn.layer.borderColor = UIColor.white.cgColor
        trainingBtn.layer.borderWidth = 1.0
        
        finishBtn.layer.cornerRadius = 10.0
        finishBtn.layer.borderWidth = 1.0
        finishBtn.layer.borderColor = UIColor.white.cgColor
        
        homeworkBtn.layer.cornerRadius = 10.0
        homeworkBtn.layer.borderColor = UIColor.white.cgColor
        homeworkBtn.layer.borderWidth = 1.0

    }
    
    func writeExam() {
        let examInfo: String = examTypeArray.joined(separator: ", ")
        let url = "https://api.kr"
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
        let url = "https://api.kr"
        
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if contentField.textColor == UIColor.lightGray {
            contentField.text = nil
            contentField.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentField.text.isEmpty {
            contentField.text = "강의평가를 작성해주세요."
            contentField.textColor = UIColor.lightGray
        }
    }
//    
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
            easyLevelBtn.setTitleColor(colorLiteralBlue, for: .normal)
            normalLevelBtn.setTitleColor(.lightGray, for: .normal)
            hardLevelBtn.setTitleColor(.lightGray, for: .normal)
        } else if levelType.levelPoint == 1 {
            easyLevelBtn.setTitleColor(.lightGray, for: .normal)
            normalLevelBtn.setTitleColor(colorLiteralPurple, for: .normal)
            hardLevelBtn.setTitleColor(.lightGray, for: .normal)
        } else if levelType.levelPoint == 2 {
            easyLevelBtn.setTitleColor(.lightGray, for: .normal)
            normalLevelBtn.setTitleColor(.lightGray, for: .normal)
            hardLevelBtn.setTitleColor(colorLiteralPurple, for: .normal)
        } else {
            easyLevelBtn.setTitleColor(.lightGray, for: .normal)
            normalLevelBtn.setTitleColor(.lightGray, for: .normal)
            hardLevelBtn.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification){
        if keyboardTouchCheck == false {
            keyboardTouchCheck = true
            if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                UIView.animate(withDuration: 0.8){
                    self.view.frame.origin.y -= keyboardFrame.height - 60
                }
                
            }
        }
        
    }
    
    @objc func keyboardWillDisappear(_ notification: Notification){
        if keyboardTouchCheck == true{
            keyboardTouchCheck = false
            UIView.animate(withDuration: 0.8){
                self.view.frame.origin.y = 0
            }
            
        }
        
    }
}

