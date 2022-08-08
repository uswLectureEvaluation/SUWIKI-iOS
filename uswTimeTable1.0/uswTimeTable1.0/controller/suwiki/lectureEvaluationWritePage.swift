//
//  lectureEvaluationWritePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/12.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift
import DropDown

// 슬라이더로 배움/꿀강/만족도 조절 기본값 3.0
// 수강학기 Dropdown
// 이전 페이지에서 받은 ResponseBody btn 클릭 시 넘겨주어야 하고, 과제, 조모임, 학점 부분은 특정 로직 거쳐서 Request body에 맞게 반환해주면 됨
// 텍스트필드는 글자 제한 1000자
// 유저가 선택하는 부분은 bool type으로 해도 될듯.
// 한번에 set으로 넣어주는 방법이 제일 좋아보이긴 하나, 순서가 중요하다면 array로 넣는 방법으로 진행
// point 셋다 3 아니여야 넘어가는 방법 적용

class lectureEvaluationWritePage: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var semesterDropDown: UIView!
    @IBOutlet weak var semesterTextField: UILabel!
    
    @IBOutlet weak var honeySlider: UISlider!
    @IBOutlet weak var learningSlider: UISlider!
    @IBOutlet weak var satisfactionSlider: UISlider!
    
    @IBOutlet weak var honeyPoint: UILabel!
    @IBOutlet weak var learningPoint: UILabel!
    @IBOutlet weak var satisfactionPoint: UILabel!
    
    @IBOutlet weak var lectureNameLabel: UILabel!
    
    
    @IBOutlet weak var teamNoBtn: UIButton!
    @IBOutlet weak var teamHaveBtn: UIButton!
    
    @IBOutlet weak var homeworkNoBtn: UIButton!
    @IBOutlet weak var homeworkUsuallyBtn: UIButton!
    @IBOutlet weak var homeworkManyBtn: UIButton!
    
    @IBOutlet weak var easyDifficultyBtn: UIButton!
    @IBOutlet weak var normalDifficultyBtn: UIButton!
    @IBOutlet weak var hardDiffcultyBtn: UIButton!
    
    @IBOutlet weak var contentField: UITextView!
    
    @IBOutlet weak var finishBtn: UIButton!
    
    var teamWorkType = evalBtnClickedType.teamWorkType()
    var homeworkType = evalBtnClickedType.homeworkType()
    var difficultyType = evalBtnClickedType.difficultyType()
    
    var lectureName: String = ""
    var professor: String = ""
    var lectureId: Int = 0
    
    var adjustBtn: Int = 0
    var adjustContent: String = ""
    var evaluateIdx: Int = 0
    
    let keychain = KeychainSwift()
    let dropDown = DropDown()
    
    var semesterList: [String] = []
    
    var keyboardTouchCheck: Bool = false
    let colorLiteralBlue = #colorLiteral(red: 0.2016981244, green: 0.4248289466, blue: 0.9915582538, alpha: 1)
    let colorLiteralBlack = #colorLiteral(red: 0.1333333254, green: 0.1333333254, blue: 0.1333333254, alpha: 1)
    let colorLiteralPurple = #colorLiteral(red: 0.4726856351, green: 0, blue: 0.9996752143, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCustom()
        
        self.contentField.layer.borderWidth = 1.0
        self.contentField.layer.borderColor = UIColor.black.cgColor
        lectureNameLabel.text = lectureName
        
        if adjustBtn == 1 {
            getAdjustEvaluation()
        }

        contentField.delegate = self
        contentField.text = "강의평가를 작성해주세요."
        contentField.textColor = UIColor.lightGray
        contentField.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)

        contentField.layer.cornerRadius = 8.0
        contentField.layer.borderWidth = 1.0
        contentField.layer.borderColor = UIColor.lightGray.cgColor
        
        scrollView.layer.borderWidth = 1.0
        scrollView.layer.borderColor = UIColor.lightGray.cgColor
        scrollView.layer.cornerRadius = 8.0
        
        semesterDropDown.layer.borderWidth = 1.0
        semesterDropDown.layer.borderColor = UIColor.lightGray.cgColor
        semesterDropDown.layer.cornerRadius = 8.0
        
        dropDown.anchorView = semesterDropDown
        dropDown.dataSource = semesterList
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.textFont = UIFont.systemFont(ofSize: 16)
        dropDown.cornerRadius = 8.0

        //            self.categoryTextField.font = UIFont(name: "Pretendard", size: 14)

        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.semesterTextField.text = semesterList[index]
            self.semesterTextField.font = UIFont(name: "Pretendard", size: 14)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
        
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
    
    @objc func MyTapMethod(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
   
    }
    
    @IBAction func semesterDropDownClicked(_ sender: Any) {
        dropDown.show()
    }
        
    @IBAction func finishedBtnClicked(_ sender: Any) {
        
        if teamWorkType.teamWorkPoint == 3 || difficultyType.difficultyPoint == 3 || homeworkType.homeworkPoint == 3 || semesterTextField.text == "선택" {
            let alert = UIAlertController(title:"입력하지 않은 내용이 있습니다.",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)
            
        } else if contentField.text.count < 30 || contentField.text.count > 1000 {
            let alert = UIAlertController(title:"강의평가를 확인해주세요!",
                message: "내용은 30자 이상, 1000자 이하로 작성해주세요!",
                preferredStyle: UIAlertController.Style.alert)
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(cancle)
            self.present(alert, animated: true, completion: nil)

        }
        else {
            if adjustBtn == 0 {
                writeEvaluation()
            } else if adjustBtn == 1 {
                writeAdjustEvaluation()
            }
        }
    }
    
    func writeEvaluation() {
        
        let url = "https://api.suwiki.kr/evaluate-posts/?lectureId=\(lectureId)"
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        let parameters = [
            "lectureName" : lectureName, //과목이름
            "professor" : professor, //교수이름
            "selectedSemester" : semesterTextField.text,//학기
            "satisfaction" : Float(satisfactionPoint.text!) ?? 0, //만족도
            "learning" : Float(learningPoint.text!) ?? 0, //배움지수
            "honey" : Float(honeyPoint.text!) ?? 0, //꿀강지수
            "team" : teamWorkType.teamWorkPoint, //조별모임 유무(없음 == 0, 있음 == 1)
            "difficulty" : difficultyType.difficultyPoint, //학점 잘주는가? (까다로움 == 0, 보통 == 1, 학점느님 ==2)
            "homework" : homeworkType.homeworkPoint, //과제양 (없음 ==0, 보통 == 1, 많음 == 2)
            "content" : contentField.text!
        ] as [String : Any]
        
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
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    
    func writeAdjustEvaluation() {
        let url = "https://api.suwiki.kr/evaluate-posts/?evaluateIdx=\(evaluateIdx)"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("AccessToken") ?? "")
        ]
        
        let parameters = [
            "selectedSemester" : semesterTextField.text,//학기
            "satisfaction" : Float(satisfactionPoint.text!) ?? 0, //만족도
            "learning" : Float(learningPoint.text!) ?? 0, //배움지수
            "honey" : Float(honeyPoint.text!) ?? 0, //꿀강지수
            "team" : teamWorkType.teamWorkPoint, //조별모임 유무(없음 == 0, 있음 == 1)
            "difficulty" : difficultyType.difficultyPoint, //학점 잘주는가? (까다로움 == 0, 보통 == 1, 학점느님 ==2)
            "homework" : homeworkType.homeworkPoint, //과제양 (없음 ==0, 보통 == 1, 많음 == 2)
            "content" : contentField.text!
        ] as [String : Any]
        
        print(parameters)
        print(headers)
        
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
    
    func btnCustom(){
        
        teamNoBtn.layer.cornerRadius = 10.0
        teamNoBtn.layer.borderWidth = 1.0
        teamNoBtn.layer.borderColor = UIColor.white.cgColor
        
        teamHaveBtn.layer.cornerRadius = 10.0
        teamHaveBtn.layer.borderColor = UIColor.white.cgColor
        teamHaveBtn.layer.borderWidth = 1.0
        
        homeworkNoBtn.layer.cornerRadius = 10.0
        homeworkNoBtn.layer.borderWidth = 1.0
        homeworkNoBtn.layer.borderColor = UIColor.white.cgColor
        
        homeworkUsuallyBtn.layer.cornerRadius = 10.0
        homeworkUsuallyBtn.layer.borderColor = UIColor.white.cgColor
        homeworkUsuallyBtn.layer.borderWidth = 1.0
        
        homeworkManyBtn.layer.cornerRadius = 10.0
        homeworkManyBtn.layer.borderWidth = 1.0
        homeworkManyBtn.layer.borderColor = UIColor.white.cgColor

        easyDifficultyBtn.layer.cornerRadius = 10.0
        easyDifficultyBtn.layer.borderColor = UIColor.white.cgColor
        easyDifficultyBtn.layer.borderWidth = 1.0
        
        normalDifficultyBtn.layer.cornerRadius = 10.0
        normalDifficultyBtn.layer.borderWidth = 1.0
        normalDifficultyBtn.layer.borderColor = UIColor.white.cgColor
        
        hardDiffcultyBtn.layer.cornerRadius = 10.0
        hardDiffcultyBtn.layer.borderColor = UIColor.white.cgColor
        hardDiffcultyBtn.layer.borderWidth = 1.0
        
        finishBtn.layer.cornerRadius = 10.0
        finishBtn.layer.borderWidth = 1.0
        finishBtn.layer.borderColor = UIColor.white.cgColor
//        @IBOutlet weak var contentField: UITextView!
        
    }
        
    func getAdjustEvaluation(){
        
        contentField.text = adjustContent
        teamWorkType.checkPoint(no: teamWorkType.noTeamWork, have: teamWorkType.haveTeamWork)
        teamWorkPointCheck()
        homeworkType.checkPoint(no: homeworkType.noHomework, usually: homeworkType.usuallyHomework, many: homeworkType.manyHomework)
        homeworkPointCheck()
        difficultyType.checkPoint(easy: difficultyType.easyDifficulty, normal: difficultyType.normalDifficulty, hard: difficultyType.hardDifficulty)
        difficultyPointCheck()
        
    }
    
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func honeyPointChanged(_ sender: UISlider) {
        
        let sliderPoint = String(format: "%.1f", round(sender.value * 100) / 100)
        let roundIndex = sliderPoint.index(sliderPoint.startIndex, offsetBy: 2)
        var point = Double(String(sliderPoint[sliderPoint.startIndex]))!
        let roundPoint = Int(String(sliderPoint[roundIndex]))!
        if roundPoint > 5{
            point += 0.5
        }

        honeyPoint.text = String(point)
    
    }
    
    @IBAction func learningPointChanged(_ sender: UISlider) {
        
        let sliderPoint = String(format: "%.1f", round(sender.value * 100) / 100)
        let roundIndex = sliderPoint.index(sliderPoint.startIndex, offsetBy: 2)
        var point = Double(String(sliderPoint[sliderPoint.startIndex]))!
        let roundPoint = Int(String(sliderPoint[roundIndex]))!
        if roundPoint > 5{
            point += 0.5
        }
        
        learningPoint.text = String(point)
    }
    
    @IBAction func satisfactionValueChanged(_ sender: UISlider) {
        
        let sliderPoint = String(format: "%.1f", round(sender.value * 100) / 100)
        let roundIndex = sliderPoint.index(sliderPoint.startIndex, offsetBy: 2)
        var point = Double(String(sliderPoint[sliderPoint.startIndex]))!
        let roundPoint = Int(String(sliderPoint[roundIndex]))!
        if roundPoint > 5{
            point += 0.5
        }
        
        satisfactionPoint.text = String(point)
    }
     
    @IBAction func noTeamBtnClicked(_ sender: Any) {
        teamWorkTypeCheck(teamWork: "no")
        teamWorkType.checkPoint(no: teamWorkType.noTeamWork, have: teamWorkType.haveTeamWork)
        teamWorkPointCheck()
    }
    @IBAction func haveTeamBtnClicked(_ sender: Any) {
        teamWorkTypeCheck(teamWork: "have")
        teamWorkType.checkPoint(no: teamWorkType.noTeamWork, have: teamWorkType.haveTeamWork)
        teamWorkPointCheck()
    }
    
    @IBAction func noHomeworkBtnClicked(_ sender: Any) {
        homeworkTypeCheck(homework: "no")
        homeworkType.checkPoint(no: homeworkType.noHomework, usually: homeworkType.usuallyHomework, many: homeworkType.manyHomework)
        print(homeworkType.homeworkPoint)

        homeworkPointCheck()
    }
    @IBAction func usuallyHomeworkBtnClicked(_ sender: Any) {
        homeworkTypeCheck(homework: "usually")
        homeworkType.checkPoint(no: homeworkType.noHomework, usually: homeworkType.usuallyHomework, many: homeworkType.manyHomework)
        print(homeworkType.homeworkPoint)

        homeworkPointCheck()
    }
    @IBAction func manyHomeworkBtnClicked(_ sender: Any) {
        homeworkTypeCheck(homework: "many")
        homeworkType.checkPoint(no: homeworkType.noHomework, usually: homeworkType.usuallyHomework, many: homeworkType.manyHomework)
        print(homeworkType.homeworkPoint)
        homeworkPointCheck()
    }
    
    
    @IBAction func easyDifficultyBtnClicked(_ sender: Any) {
        difficultyTypeCheck(difficulty: "easy")
        difficultyType.checkPoint(easy: difficultyType.easyDifficulty, normal: difficultyType.normalDifficulty, hard: difficultyType.hardDifficulty)
        difficultyPointCheck()
        print(difficultyType.difficultyPoint)
    }
    @IBAction func normalDifficultyBtnClicked(_ sender: Any) {
        difficultyTypeCheck(difficulty: "normal")
        difficultyType.checkPoint(easy: difficultyType.easyDifficulty, normal: difficultyType.normalDifficulty, hard: difficultyType.hardDifficulty)
        difficultyPointCheck()
        print(difficultyType.difficultyPoint)
    }
    @IBAction func hardDifficultyBtnClicked(_ sender: Any) {
        difficultyTypeCheck(difficulty: "hard")
        difficultyType.checkPoint(easy: difficultyType.easyDifficulty, normal: difficultyType.normalDifficulty, hard: difficultyType.hardDifficulty)
        difficultyPointCheck()
        print(difficultyType.difficultyPoint)
    }
    
    
    func teamWorkTypeCheck(teamWork: String){
        if teamWork == "have"{
            if teamWorkType.haveTeamWork == true{
                teamWorkType.haveTeamWork = false
                teamWorkType.noTeamWork = false
            } else {
                teamWorkType.haveTeamWork = true
                teamWorkType.noTeamWork = false
            }
            
        } else if teamWork == "no"{
            if teamWorkType.noTeamWork == true{
                teamWorkType.haveTeamWork = false
                teamWorkType.noTeamWork = false
            } else {
                teamWorkType.haveTeamWork = false
                teamWorkType.noTeamWork = true
            }
        }
    }
    
    func homeworkTypeCheck(homework: String){
        if homework == "no"{
            if homeworkType.noHomework == true {
                homeworkType.manyHomework = false
                homeworkType.noHomework = false
                homeworkType.usuallyHomework = false
            } else {
                homeworkType.manyHomework = false
                homeworkType.noHomework = true
                homeworkType.usuallyHomework = false
            }
           
        } else if homework == "usually" {
            if homeworkType.usuallyHomework == true {
                homeworkType.manyHomework = false
                homeworkType.noHomework = false
                homeworkType.usuallyHomework = false
            } else {
                homeworkType.manyHomework = false
                homeworkType.noHomework = false
                homeworkType.usuallyHomework = true
            }
            
        } else if homework == "many"{
            if homeworkType.manyHomework == true {
                homeworkType.manyHomework = false
                homeworkType.noHomework = false
                homeworkType.usuallyHomework = false
            } else {
                homeworkType.manyHomework = true
                homeworkType.noHomework = false
                homeworkType.usuallyHomework = false
            }
        }
    }
    
    func difficultyTypeCheck(difficulty: String){
        if difficulty == "easy" {
            if difficultyType.easyDifficulty == true {
                difficultyType.easyDifficulty = false
                difficultyType.normalDifficulty = false
                difficultyType.hardDifficulty = false
            } else {
                difficultyType.easyDifficulty = true
                difficultyType.normalDifficulty = false
                difficultyType.hardDifficulty = false
            }
            
        } else if difficulty == "normal" {
            if difficultyType.normalDifficulty == true {
                difficultyType.easyDifficulty = false
                difficultyType.normalDifficulty = false
                difficultyType.hardDifficulty = false
            } else {
                difficultyType.easyDifficulty = false
                difficultyType.normalDifficulty = true
                difficultyType.hardDifficulty = false
            }
            
        } else if difficulty == "hard" {
            if difficultyType.hardDifficulty == true {
                difficultyType.easyDifficulty = false
                difficultyType.normalDifficulty = false
                difficultyType.hardDifficulty = false
            } else {
                difficultyType.easyDifficulty = false
                difficultyType.normalDifficulty = false
                difficultyType.hardDifficulty = true
            }
            
        }
    }
    
    func teamWorkPointCheck(){
        if teamWorkType.teamWorkPoint == 0 {
            teamNoBtn.setTitleColor(colorLiteralBlue, for: .normal)
            teamHaveBtn.setTitleColor(.darkGray, for: .normal)
        } else if teamWorkType.teamWorkPoint == 1 {
            teamNoBtn.setTitleColor(.darkGray, for: .normal)
            teamHaveBtn.setTitleColor(colorLiteralPurple, for: .normal)
        } else {
            teamNoBtn.setTitleColor(.darkGray, for: .normal)
            teamHaveBtn.setTitleColor(.darkGray, for: .normal)
        }
    }
    
    func homeworkPointCheck(){
        if homeworkType.homeworkPoint == 0{
            homeworkNoBtn.setTitleColor(colorLiteralBlue, for: .normal)
            homeworkUsuallyBtn.setTitleColor(.darkGray, for: .normal)
            homeworkManyBtn.setTitleColor(.darkGray, for: .normal)
        } else if homeworkType.homeworkPoint == 1{
            homeworkNoBtn.setTitleColor(.darkGray, for: .normal)
            homeworkUsuallyBtn.setTitleColor(colorLiteralBlack, for: .normal)
            homeworkManyBtn.setTitleColor(.darkGray, for: .normal)
        } else if homeworkType.homeworkPoint == 2 {
            homeworkNoBtn.setTitleColor(.darkGray, for: .normal)
            homeworkUsuallyBtn.setTitleColor(.darkGray, for: .normal)
            homeworkManyBtn.setTitleColor(colorLiteralPurple, for: .normal)
        } else {
            homeworkNoBtn.setTitleColor(.darkGray, for: .normal)
            homeworkUsuallyBtn.setTitleColor(.darkGray, for: .normal)
            homeworkManyBtn.setTitleColor(.darkGray, for: .normal)
        }
    }
    
    func difficultyPointCheck(){
        if difficultyType.difficultyPoint == 0{
            easyDifficultyBtn.setTitleColor(colorLiteralBlue, for: .normal)
            normalDifficultyBtn.setTitleColor(.darkGray, for: .normal)
            hardDiffcultyBtn.setTitleColor(.darkGray, for: .normal)
        } else if difficultyType.difficultyPoint == 1{
            easyDifficultyBtn.setTitleColor(.darkGray, for: .normal)
            normalDifficultyBtn.setTitleColor(colorLiteralBlack, for: .normal)
            hardDiffcultyBtn.setTitleColor(.darkGray, for: .normal)
        } else if difficultyType.difficultyPoint == 2{
            easyDifficultyBtn.setTitleColor(.darkGray, for: .normal)
            normalDifficultyBtn.setTitleColor(.darkGray, for: .normal)
            hardDiffcultyBtn.setTitleColor(colorLiteralPurple, for: .normal)
        } else {
            easyDifficultyBtn.setTitleColor(.darkGray, for: .normal)
            normalDifficultyBtn.setTitleColor(.darkGray, for: .normal)
            hardDiffcultyBtn.setTitleColor(.darkGray, for: .normal)
        }
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
    
    @objc func keyboardWillAppear(_ notification: NSNotification){
        if keyboardTouchCheck == false {
            keyboardTouchCheck = true
            if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                UIView.animate(withDuration: 0.8){
                    self.view.frame.origin.y -= keyboardFrame.height
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


