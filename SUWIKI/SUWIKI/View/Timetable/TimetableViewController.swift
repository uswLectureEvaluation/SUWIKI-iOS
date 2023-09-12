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

class TimetableViewController: UIViewController, UINavigationControllerDelegate {
    
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
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    let timetableEmptyView = TimetableEmptyView()
    
    let dayString: [String] = ["월", "화", "수", "목", "금", "이러닝"]
    var viewModel = TimetableViewModel()
    var viewModel1 = InitAppViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateCourse()
        viewModel.updateTimetable()
        binding()
        initTimetable()
        setupNavigationBar()
        setObserver()
        setupUI()
    }
    
    private func binding() {
        viewModel.$timetableTitle
            .receive(on: RunLoop.main)
            .sink { title in
                self.timetableTitle.text = title
            }
            .store(in: &cancellables)
        viewModel.$timetableIsEmpty
            .receive(on: RunLoop.main)
            .sink { isEmpty in
                self.timetableEmptyView.isHidden = !isEmpty
                self.timetable.isHidden = isEmpty
            }
            .store(in: &cancellables)
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadCourse),
                                               name: Notification.Name("addCourse"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dismissObserver),
                                               name: Notification.Name(rawValue: "timetableListDismiss")
                                               , object: nil)
    }
    
    private func setupUI() {
        self.view.addSubview(timetableEmptyView)
        self.timetableEmptyView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
        }
        self.timetableEmptyView.addButton.addAction(UIAction { [weak self] _ in self?.viewModel.addTimetable() },
                                                    for: .touchUpInside)
        
        self.view.addSubview(timetableTitleBackground)
        self.timetableTitleBackground.addSubview(timetableTitle)
        
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
        
        self.timetableTitle.text = viewModel.timetableTitle
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.primaryColor
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        let title = UIBarButtonItem(customView: navigationTitle)
        let listButton = UIBarButtonItem(systemItem: .organize,
                                         primaryAction: UIAction { [weak self] _ in self?.listButtonTapped()})
        let addButton = UIBarButtonItem(systemItem: .add,
                                        primaryAction: UIAction { [weak self] _ in self?.addButtonTapped() })
//        let rightButton = UIBarButtonItem(image: UIImage(systemName: "plus"),
//                                          style: .plain,
//                                          target: self,
//                                          action: #selector(addButtonTapped))
//        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"),
//                                         style: .plain,
//                                         target: self,
//                                         action: #selector(<#T##@objc method#>))
//        let tempbutt =
        
        let testButton = UIBarButtonItem(title: "test",
                                         style: .plain,
                                         target: self,
                                         action: #selector(tempMethod))
        
        self.navigationItem.rightBarButtonItems = [addButton, listButton]
//        self.navigationItem.leftBarButtonItem = title
        self.navigationItem.leftBarButtonItem = testButton


    }
    
    @objc
    func testMethod() {
//        viewModel.coreDataManager.fetchTimetable()
    }
    
    @objc
    func tempMethod() {
//        await viewModel1.saveCourseToCoreData(course: viewModel1.fetchFirebaseCourse() ?? [])
//        viewModel.coreDataManager.saveTimetable(name: "새로운 시간표", semester: "2023-1")
        Task {
            await tempFetch()
        }
//        do {
//            viewModel1.fetchFirebaseCourse()
//        } catch {
//
//        }
//        viewModel1.fetchFirebaseCourse { course in
//            if let course = course {
//                await self.viewModel1.saveCourseToCoreData(course: course)
//            }
//        }
    }
    
    func tempFetch() async {
        await viewModel1.fetchFirebaseCourse()
    }
    
    func tempAlert() {
        let alertController = UIAlertController(title: "텍스트 입력", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "텍스트를 입력하세요"
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            if let textField = alertController.textFields?.first {
                if let userInput = textField.text {
                    // 입력된 텍스트 사용 (userInput)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc
    func dismissObserver() {
        print("@Log dismiss")
    }
    
    @objc
    func reloadCourse() {
        viewModel.updateCourse()
        timetable.reloadData()
    }
    
    
    func addButtonTapped() {
        let majorVC = UINavigationController(rootViewController: SelectMajorViewController())
        if let sheet = majorVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
        }
        self.present(majorVC, animated: true)
    }
    
    func listButtonTapped() {
        let listVC = TimetableListViewController()
        listVC.delegate = self
        
        let listNC = UINavigationController(rootViewController: listVC)
        if let sheet = listNC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
        }
        
        self.present(listNC, animated: true)
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

extension TimetableViewController: ElliotableDelegate, ElliotableDataSource, TimetableDelegate {
    
    func updateTimetable() {
        print("@Log - Update")
        viewModel.updateCourse()
        viewModel.updateTimetable()
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

protocol TimetableDelegate: AnyObject {
    func updateTimetable()
}
