//
//  lectureExamWritePage.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/28.
//

import UIKit

class lectureExamWritePage: UIViewController {

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
    
    var levelType = examBtnClickedType.levelType()
    
    var examType = examBtnClickedType.examType()
    
    var lectureName = ""
    var professor = ""
    var lectureId = 0
    
    var examTypeArray: [String] = []
    var examTypeArrayCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // examType bool값 확인 후 true false 일 경우 append or remove - n번째 요소. or 그 단어 제거 해주기
    // list.joined(separator: ", ")로 완료 버튼 누를 시 update 해줌
    
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
}
