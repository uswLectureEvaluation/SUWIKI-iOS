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
    
    private let navigationTitle = UILabel().then {
        $0.text = "SUWIKI"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    private let timetableTitleBackground = UIView().then {
        $0.layer.cornerRadius = 12.0
        $0.frame = CGRect(x: 0, y: 0, width: 0, height: 60)
        $0.backgroundColor = .white
    }
    
    private let timetableTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 12.0
        $0.backgroundColor = .white
        $0.text = "2023년 말까지 업데이트..2023년 말까지 업데이트..2023년 말까지 업데이트.."
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
//    var addCourseController: AddCourseViewController?
    let dayString: [String] = ["월", "화", "수", "목", "금", "이러닝"]
    var viewModel = TimetableViewModel()
    var viewModel1 = InitAppViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCourse()
        navigationSetUp()
        initTimetable()
        setObserver()
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadCourse),
                                               name: Notification.Name("addCourse"),
                                               object: nil)
    }
    
    func navigationSetUp() {
//        self.title = "시간표 추가시간표 추가시간표 추가시간표 추가"
        self.navigationController?.navigationBar.tintColor = UIColor.primaryColor
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        let title = UIBarButtonItem(customView: navigationTitle)

        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = title

        self.view.addSubview(timetableTitleBackground)
        timetableTitleBackground.addSubview(timetableTitle)

        self.timetableTitleBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(60)
        }

        self.timetableTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(timetableTitleBackground.snp.leading).offset(10)
            $0.trailing.equalTo(timetableTitleBackground.snp.trailing).offset(-10)
        }
    }
    
    @objc
    func tempMethod() {
        
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
    func reloadCourse() {
        viewModel.getCourse()
        timetable.reloadData()
    }
    
    @objc
    func addButtonTapped() {
        let majorVC = UINavigationController(rootViewController: SelectMajorViewController())
        
//        majorVC.navigationItem.largeTitleDisplayMode = .never
        
        if let sheet = majorVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
        }
        self.present(majorVC, animated: true)
//        let addCourseVC = UINavigationController(rootViewController: addCourseController)
//        self.present(addCourseVC, animated: true)
    }
    
    func initTimetable() {
        timetable.delegate = self
        timetable.dataSource = self

        timetable.elliotBackgroundColor = UIColor.white
        timetable.borderWidth = 1.0
        timetable.borderColor = .systemGray6
//        UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        timetable.textEdgeInsets = UIEdgeInsets(top: 10, left: 4, bottom: 2, right: 4)
        timetable.courseItemMaxNameLength = 18
        timetable.courseItemTextSize = 13
        timetable.courseTextAlignment = .left
        timetable.roundCorner = .all
        timetable.borderCornerRadius = 12
        timetable.roomNameFontSize = 8

        timetable.courseItemHeight = 60
        timetable.symbolFontSize = 13
        timetable.symbolTimeFontSize = 13
        timetable.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        timetable.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        timetable.layer.cornerRadius = 12.0
        timetable.layer.masksToBounds = true
        
        timetable.reloadData()
    }
    
}

extension TimetableViewController: ElliotableDelegate, ElliotableDataSource {
    
    func updateTimetable() {
        timetable.reloadData()
    }
    
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        let actionSheet = UIAlertController(
            title: "\(selectedCourse.courseName) | \(selectedCourse.professor)",
            message: selectedCourse.roomName,
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(
            UIAlertAction(title: "수정", style: .default) { _ in
                print("@Log - 수정")
            }
        )
        actionSheet.addAction(
            UIAlertAction(title: "삭제", style: .destructive) { [weak self] alert in
                guard let self = self else { return }
                self.viewModel.deleteCourse(uuid: selectedCourse.courseId)
                self.updateTimetable()
            }
        )
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(actionSheet, animated: true)
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


///MARK: Todo
///이후 수정될 AddCourse와 연결해야 함.
//    func bind() {
//        addCourseController.isFinished
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//                self.viewModel.getCourse()
//                self.timetable.reloadData()
//            }
//            .store(in: &cancellables)
//    }
