//
//  TimetableViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/10.
//

import UIKit

import Elliotable
import SnapKit
import Then

class TimetableViewController: UIViewController {
    
    @IBOutlet weak var timetable: Elliotable!
    
    let dayString: [String] = ["월", "화", "수", "목", "금"]
    let courseList: [ElliottEvent] = [ElliottEvent(courseId: "1", courseName: "Hi", roomName: "Hio", professor: "Hio", courseDay: .monday, startTime: "10:00", endTime: "20:00", textColor: .black, backgroundColor: .lightGray)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetUp()
        addSubView()
        setUpButtons()
        initTimetable()
    }
    
    func navigationSetUp() {
        self.title = "시간표 추가시간표 추가시간표 추가시간표 추가"
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    func addButtonTapped() {
        let addCourseVC = UINavigationController(rootViewController: AddCourseViewController())
        self.present(addCourseVC, animated: true)
    }
    
    func addSubView() {
//        self.view.addSubview(self.addButton)
    }

    func setUpButtons() {
//        self.addButton.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.trailing.equalToSuperview()
//            $0.height.equalTo(44)
//        }
    }
    
    func initTimetable() {
        timetable.delegate = self
        timetable.dataSource = self

        timetable.elliotBackgroundColor = UIColor.white
        timetable.borderWidth = 1
        timetable.borderColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)

        timetable.textEdgeInsets = UIEdgeInsets(top: 2, left: 3, bottom: 2, right: 10)
        timetable.courseItemMaxNameLength = 18
        timetable.courseItemTextSize = 12.5
        timetable.courseTextAlignment = .left

        timetable.borderCornerRadius = 24
        timetable.roomNameFontSize = 8

        timetable.courseItemHeight = 70.0
        timetable.symbolFontSize = 14
        timetable.symbolTimeFontSize = 12
        timetable.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        timetable.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)

        timetable.reloadData()
    }
    
}

extension TimetableViewController: ElliotableDelegate, ElliotableDataSource {
    
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        print("@Log select")
    }
    
    func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
        print("@Log long select")
    }
    
    func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
        print(dayPerIndex)
        return dayString[dayPerIndex]
    }
    
    func numberOfDays(in elliotable: Elliotable) -> Int {
        return dayString.count
    }
    
    func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
        return courseList
    }

}


