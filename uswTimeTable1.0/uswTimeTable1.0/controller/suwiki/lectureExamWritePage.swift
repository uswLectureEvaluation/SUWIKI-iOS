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
    
    var levelType = examBtnClickedType.levelType()
    
    var lectureName = ""
    var professor = ""
    var lectureId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
