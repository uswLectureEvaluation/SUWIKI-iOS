//
//  lectureEvaluationWritePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/12.
//

import UIKit

// 슬라이더로 배움/꿀강/만족도 조절 기본값 3.0
// 수강학기 Dropdown
// 이전 페이지에서 받은 ResponseBody btn 클릭 시 넘겨주어야 하고, 과제, 조모임, 학점 부분은 특정 로직 거쳐서 Request body에 맞게 반환해주면 됨
// 텍스트필드는 글자 제한 1000자
// 유저가 선택하는 부분은 bool type으로 해도 될듯.
// 한번에 set으로 넣어주는 방법이 제일 좋아보이긴 하나, 순서가 중요하다면 array로 넣는 방법으로 진행


class lectureEvaluationWritePage: UIViewController {
    
    @IBOutlet weak var honeySlider: UISlider!
    @IBOutlet weak var learningSlider: UISlider!
    @IBOutlet weak var satisfactionSlider: UISlider!
    
    @IBOutlet weak var honeyPoint: UILabel!
    @IBOutlet weak var learningPoint: UILabel!
    @IBOutlet weak var satisfactionPoint: UILabel!
    
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    
    
    var teamWorkType = btnClickedType.teamWorkBtnType(noTeamWork: false, haveTeamWork: false)
    var homeworkType = btnClickedType.homeworkType(noHomework: false, usuallyHomework: false, manyHomework: false)
    var difficultyType = btnClickedType.difficultyType(easyDifficulty: false, usuallDifficulty: false, hardDifficulty: false)
    
    var lectureName: String = ""
    var professor: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lectureNameLabel.text = lectureName
        professorLabel.text = professor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func honeyPointChanged(_ sender: UISlider) {
        let point = String(format: "%.1f", round(sender.value * 1000) / 1000)
        honeyPoint.text = point
    }
    
    @IBAction func learningPointChanged(_ sender: UISlider) {
        let point = String(format: "%.1f", round(sender.value * 1000) / 1000)
        learningPoint.text = point
    }
    
    @IBAction func satisfactionValueChanged(_ sender: UISlider) {
        let point = String(format: "%.1f", round(sender.value * 1000) / 1000)
        satisfactionPoint.text = point
    }
     
    @IBAction func noTeamBtnClicked(_ sender: Any) {
        teamWorkType.haveTeamWork = false
        teamWorkType.noTeamWork = true
    }
    @IBAction func haveTeamBtnClicked(_ sender: Any) {
        teamWorkType.haveTeamWork = true
        teamWorkType.noTeamWork = false
    }
    
    @IBAction func noHomeworkBtnClicked(_ sender: Any) {
        homeworkType.manyHomework = false
        homeworkType.noHomework = true
        homeworkType.usuallyHomework = false
    }
    @IBAction func usuallyHomeworkBtnClicked(_ sender: Any) {
        homeworkType.manyHomework = false
        homeworkType.noHomework = false
        homeworkType.usuallyHomework = true
    }
    @IBAction func manyHomeworkBtnClicked(_ sender: Any) {
        homeworkType.manyHomework = true
        homeworkType.noHomework = false
        homeworkType.usuallyHomework = false
    }
    
    
    @IBAction func easyDifficultyBtnClicked(_ sender: Any) {
    }
    @IBAction func normalDifficultyBtnClicked(_ sender: Any) {
    }
    @IBAction func hardDifficultyBtnClicked(_ sender: Any) {
    }
    
    
}
