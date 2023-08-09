//
//  TimetableViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/10.
//

import UIKit

import Combine
import Elliotable
import SnapKit
import Then

class TimetableViewController: UIViewController {
    
    @IBOutlet weak var timetable: Elliotable!
    
//    var addCourseController: AddCourseViewController?
    var addCourseController = AddCourseViewController()
    let dayString: [String] = ["월", "화", "수", "목", "금"]
    var viewModel = TimetableViewModel()
    var viewModel1 = InitAppViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCourse()
        navigationSetUp()
        initTimetable()
        bind()
    }
    
    func bind() {
        addCourseController.isFinished
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("@B 완료됨!")
                self.viewModel.getCourse()
                self.updateTimetable()
            }
            .store(in: &cancellables)
    }

    
    func navigationSetUp() {
        self.title = "시간표 추가시간표 추가시간표 추가시간표 추가"
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        let leftButton = UIBarButtonItem(title: "test", style: .plain, target: self, action: #selector(tempMethod))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc
    func tempMethod() {
        CoreDataManager.shared.deleteTimetable()
//        viewModel.getCourse()
//        viewModel1.fetchFirebaseCourse { course in
//            if let course = course {
//                self.viewModel1.saveCourseToCoreData(course: course)
//            }
//
//        }
        
//        viewModel.check1()
//        viewModel1.checkCoreDataCount()
//        elliottEvent = viewModel.getCourse()
    }
    
    @objc
    func addButtonTapped() {
        let addCourseVC = UINavigationController(rootViewController: addCourseController)
        self.present(addCourseVC, animated: true)
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
    
    func updateTimetable() {
        timetable.reloadData()
    }
    
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        print("@Log select")
    }
    
    func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
        print("@Log long select")
    }
    
    func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
        return dayString[dayPerIndex]
    }
    
    func numberOfDays(in elliotable: Elliotable) -> Int {
        return dayString.count
    }
    
    func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
        return viewModel.elliottEvent
    }

}


