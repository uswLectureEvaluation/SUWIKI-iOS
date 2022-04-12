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
    
    
    @IBOutlet weak var teamNoBtn: UIButton!
    @IBOutlet weak var teamHaveBtn: UIButton!
    
    
    @IBOutlet weak var homeworkNoBtn: UIButton!
    @IBOutlet weak var homeworkUsuallyBtn: UIButton!
    @IBOutlet weak var homeworkManyBtn: UIButton!
    
    
    @IBOutlet weak var easyDifficultyBtn: UIButton!
    @IBOutlet weak var normalDifficultyBtn: UIButton!
    @IBOutlet weak var hardDiffcultyBtn: UIButton!
    
    var teamWorkType = btnClickedType.teamWorkType()
    var homeworkType = btnClickedType.homeworkType()
    var difficultyType = btnClickedType.difficultyType()
    
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
        teamWorkTypeCheck(teamWork: "no")
        teamWorkType.checkPoint(no: teamWorkType.noTeamWork, have: teamWorkType.haveTeamWork)
    }
    @IBAction func haveTeamBtnClicked(_ sender: Any) {
        teamWorkTypeCheck(teamWork: "have")
        teamWorkType.checkPoint(no: teamWorkType.noTeamWork, have: teamWorkType.haveTeamWork)
    }
    
    @IBAction func noHomeworkBtnClicked(_ sender: Any) {
        homeworkTypeCheck(homework: "no")
        homeworkType.checkPoint(no: homeworkType.noHomework, usually: homeworkType.usuallyHomework, many: homeworkType.manyHomework)
    }
    @IBAction func usuallyHomeworkBtnClicked(_ sender: Any) {
        homeworkTypeCheck(homework: "usually")
        homeworkType.checkPoint(no: homeworkType.noHomework, usually: homeworkType.usuallyHomework, many: homeworkType.manyHomework)
    }
    @IBAction func manyHomeworkBtnClicked(_ sender: Any) {
        homeworkTypeCheck(homework: "many")
        homeworkType.checkPoint(no: homeworkType.noHomework, usually: homeworkType.usuallyHomework, many: homeworkType.manyHomework)
    }
    
    
    @IBAction func easyDifficultyBtnClicked(_ sender: Any) {
        difficultyTypeCheck(difficulty: "easy")
        difficultyType.checkPoint(easy: difficultyType.easyDifficulty, normal: difficultyType.normalDifficulty, hard: difficultyType.hardDifficulty)
    }
    @IBAction func normalDifficultyBtnClicked(_ sender: Any) {
        difficultyTypeCheck(difficulty: "normal")
        difficultyType.checkPoint(easy: difficultyType.easyDifficulty, normal: difficultyType.normalDifficulty, hard: difficultyType.hardDifficulty)
    }
    @IBAction func hardDifficultyBtnClicked(_ sender: Any) {
        difficultyTypeCheck(difficulty: "hard")
        difficultyType.checkPoint(easy: difficultyType.easyDifficulty, normal: difficultyType.normalDifficulty, hard: difficultyType.hardDifficulty)
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
                homeworkType.manyHomework = true
                homeworkType.noHomework = false
                homeworkType.usuallyHomework = false
            } else {
                homeworkType.manyHomework = false
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
    
        
}
