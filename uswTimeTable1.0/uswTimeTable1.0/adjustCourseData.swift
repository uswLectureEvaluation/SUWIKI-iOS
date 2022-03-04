//
//  adjustCourseData.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/03.
//

import UIKit
import DropDown

class adjustCourseData: UIViewController {

    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var startTextField: UILabel!
    @IBOutlet weak var endTextField: UILabel!
    @IBOutlet weak var roomTextField: UITextField!
    
    let startDropDown = DropDown()
    let endDropDown = DropDown()
    
    let startTimeList = ["09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"]
    let endTimeList = ["10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"]
    
    var roomNameData = ""
    var courseNameData = ""
    var professorData = ""
    var courseDayData = ""
    var numData = 0
    var classificationData = ""
    var startTimeData = ""
    var endTimeData = ""
    
    var checkAdjust = 0
    var deleteIndex = 0
    
    //     var startTimeData = "" var endTimeData = ""     var roomNameData = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomTextField.text = roomNameData 
        startDropDown.anchorView = startView
        startDropDown.dataSource = startTimeList
        startDropDown.bottomOffset = CGPoint(x: 0, y:(startDropDown.anchorView?.plainView.bounds.height)!)
        startDropDown.direction = .bottom
        startDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.startTextField.text = startTimeList[index] 
            self.startTextField.font = UIFont(name: "system", size: 13)
            self.startTextField.textColor = .black
            self.startTextField.textAlignment = .center
            print("\(String(describing: startTextField.text!)):30")
                                            
        }
        
        endDropDown.anchorView = endView
        endDropDown.dataSource = endTimeList
        endDropDown.bottomOffset = CGPoint(x: 0, y:(endDropDown.anchorView?.plainView.bounds.height)!)
        endDropDown.direction = .bottom
        endDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.endTextField.text = endTimeList[index]
            self.endTextField.font = UIFont(name: "system", size: 13)
            self.endTextField.textColor = .black
            self.endTextField.textAlignment = .center
                                            
        }
        
        navigationBarHidden()
        navigationBackSwipeMotion()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startBtnClicked(_ sender: Any) {
        startDropDown.show()
    }
    @IBAction func endBtnClicked(_ sender: Any) {
        endDropDown.show()

    }
    
    @IBAction func finishBtnClicked(_ sender: Any) {
       
        if roomTextField.text == "" || startTextField.text == "시작" || endTextField.text == "종료" {
            showAlert(title: "비어있는 데이터가 있어요")
            //4. 경고창 보이기
        } else if checkAdjust == 0{
            
            let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
            infoVC.roomNameData = roomTextField.text ?? ""
            infoVC.startTimeData = "\(String(describing: startTextField.text!)):30"
            infoVC.endTimeData = "\(String(describing: endTextField.text!)):20"
            infoVC.professorData = professorData
            infoVC.courseNameData = courseNameData
            infoVC.courseDayData = courseDayData
            infoVC.classificationData = classificationData
            infoVC.numData = numData
            self.navigationController?.pushViewController(infoVC, animated: true)
            
        } else if checkAdjust == 1{
            
            let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
            infoVC.roomNameData = roomTextField.text ?? ""
            infoVC.startTimeData = "\(String(describing: startTextField.text!)):30"
            infoVC.endTimeData = "\(String(describing: endTextField.text!)):20"
            infoVC.professorData = professorData
            infoVC.courseNameData = courseNameData
            infoVC.courseDayData = courseDayData
            infoVC.classificationData = classificationData
            infoVC.numData = numData
            infoVC.checkAdjust = checkAdjust
            infoVC.deleteIndex = deleteIndex
            self.navigationController?.pushViewController(infoVC, animated: true)
            
        }
        
        // 취소버튼 누를땐 원본 그대로 다시 보내주기
    /*
        infoVC.courseNameData = filteredUswCourse[indexPath.row].courseName
        infoVC.roomNameData = filteredUswCourse[indexPath.row].roomName
        infoVC.professorData = filteredUswCourse[indexPath.row].professor
        infoVC.numData = filteredUswCourse[indexPath.row].num
        infoVC.courseDayData = filteredUswCourse[indexPath.row].courseDay
        infoVC.startTimeData = filteredUswCourse[indexPath.row].startTime
        infoVC.endTimeData = filteredUswCourse[indexPath.row].endTime
        infoVC.classificationData = filteredUswCourse[indexPath.row].classification
        infoVC.checkTimeTable = self.checkTimeTable
        */
        
    }
    // 변경 허용한 정보 1. 장소 2. startTime & endTime
    // if 완료 안누를 시 데이터 삭제 x, 완료 누르면 데이터 삭제하는 로직 필요. readCourse하는 로직이 infoCourseData랑 비슷.(--> 그냥 infoCourseData로 넘겨도 될듯)
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: "확인 버튼을 눌러주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(cancle)
        present(alert,animated: true,completion: nil)
    }
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
}
