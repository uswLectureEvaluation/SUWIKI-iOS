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
    
    let startDropDown = DropDown()
    let endDropDown = DropDown()
    
    let startTimeList = ["09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"]
    let endTimeList = ["10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDropDown.anchorView = startView
        startDropDown.dataSource = startTimeList
        startDropDown.bottomOffset = CGPoint(x: 0, y:(startDropDown.anchorView?.plainView.bounds.height)!)
        startDropDown.direction = .bottom
        startDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.startTextField.text = startTimeList[index] ?? "09"
            self.startTextField.font = UIFont(name: "system", size: 13)
            self.startTextField.textColor = .black
            self.startTextField.textAlignment = .center
                                            
        }
        
        endDropDown.anchorView = endView
        endDropDown.dataSource = endTimeList
        endDropDown.bottomOffset = CGPoint(x: 0, y:(endDropDown.anchorView?.plainView.bounds.height)!)
        endDropDown.direction = .bottom
        endDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.endTextField.text = endTimeList[index] ?? "09"
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
        self.dismiss(animated: false, completion: nil)  // 사라지게 하기
        let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! infoCourseData
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    // 변경 허용한 정보 1. 장소 2. startTime & endTime
    // if 완료 안누를 시 데이터 삭제 x, 완료 누르면 데이터 삭제하는 로직 필요. readCourse하는 로직이 infoCourseData랑 비슷.(--> 그냥 infoCourseData로 넘겨도 될듯)
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
}
