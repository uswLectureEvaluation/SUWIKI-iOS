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
import FirebaseRemoteConfig

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

    private lazy var titleChangeButton = UIButton().then {
        let uiImage = UIImage(systemName: "pencil")
        $0.setImage(uiImage?.imageWithColor(color: .primaryColor), for: .normal)
        $0.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }

    private var addButton = UIBarButtonItem()
    private var listButton = UIBarButtonItem()
    
    let timetableEmptyView = TimetableEmptyView()
    let initView = InitView()
    
    let dayString: [String] = ["월", "화", "수", "목", "금", "이러닝"]
    var viewModel = TimetableViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateTimetable()
        binding()
        initTimetable()
        setObserver()
        setupUI()
        setupNavigationBar()
    }
    
    private func binding() {
        viewModel.$timetableTitle
            .receive(on: RunLoop.main)
            .sink { title in
                self.timetableTitle.text = title
            }
            .store(in: &cancellables)
        viewModel.$timetableIsEmpty
            .combineLatest(viewModel.$isVersionChecked)
            .receive(on: RunLoop.main)
            .sink { isEmpty, versionChecked in
                
                self.timetableEmptyView.isHidden = !isEmpty
                self.timetable.isHidden = isEmpty
                
                if versionChecked && !isEmpty {
                    self.initView.removeFromSuperview()
                    self.navigationItem.rightBarButtonItems = [self.addButton, self.listButton]
                } else if versionChecked && isEmpty {
                    self.initView.removeFromSuperview()
                } else {
                    self.navigationItem.rightBarButtonItems = []
                }
            }
            .store(in: &cancellables)
        viewModel.$elliottEvent
            .receive(on: RunLoop.main)
            .sink { _ in
                self.timetable.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func setObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadCourse),
                                               name: Notification.Name("addCourse"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(timetableIsEmpty),
                                               name: Notification.Name("timetableIsEmpty"),
                                               object: nil)
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
        self.timetableTitleBackground.addSubview(titleChangeButton)

        self.timetableTitleBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(60)
        }
        
        self.timetableTitle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(timetableTitleBackground.snp.leading).offset(10)
            $0.trailing.equalTo(titleChangeButton.snp.leading).offset(-10)
        }

        self.titleChangeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(timetableTitle.snp.trailing).offset(10)
            $0.trailing.equalTo(timetableTitleBackground.snp.trailing).offset(-12)
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }

        self.timetableTitle.text = viewModel.timetableTitle
        
        //TODO: 최상위 뷰, InitView 만들기
        self.view.addSubview(initView)
        self.initView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        initView.logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(260)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(36)
        }
        initView.activityIndicator.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        initView.statusDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(initView.activityIndicator.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.primaryColor
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        listButton = UIBarButtonItem(systemItem: .organize,
                                     primaryAction: UIAction { [weak self] _ in self?.listButtonTapped()})
        addButton = UIBarButtonItem(systemItem: .add,
                                    primaryAction: UIAction { [weak self] _ in self?.addButtonTapped() })
    }
    
    @objc
    func timetableIsEmpty() {
        viewModel.timetableIsEmpty = true
    }
    
    @objc
    func reloadCourse() {
        viewModel.updateCourse()
    }

    @objc
    func changeButtonTapped() {
        let alert = UIAlertController(title: "시간표 이름 수정", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let confirm = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let title = alert.textFields?.first?.text ?? "시간표"
            self.viewModel.updateTimetableTitle(title: title)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true)
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
        timetable.textEdgeInsets = UIEdgeInsets(top: 10, left: 4, bottom: 2, right: 2)
        timetable.courseItemMaxNameLength = 18
        timetable.courseItemTextSize = 11 // 과목
        timetable.courseTextAlignment = .left
        timetable.roundCorner = .all
        timetable.borderCornerRadius = 12
        timetable.roomNameFontSize = 9 // 룸 name
        timetable.courseItemHeight = 60
        timetable.symbolFontSize = 14 // 요일 size
        timetable.symbolTimeFontSize = 14 // 교시 size
        timetable.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        timetable.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        timetable.layer.cornerRadius = 12.0
        timetable.layer.masksToBounds = true
        
        timetable.reloadData()
    }
}

extension TimetableViewController: ElliotableDelegate, ElliotableDataSource, TimetableDelegate {
    
    func updateTimetable() {
        viewModel.updateCourse()
        viewModel.updateTimetable()
    }
    
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        let actionSheet = UIAlertController(
            title: "\(selectedCourse.courseName) | \(selectedCourse.professor)",
            message: selectedCourse.roomName,
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(
            UIAlertAction(title: "삭제", style: .destructive) { [weak self] alert in
                guard let self = self else { return }
                self.viewModel.deleteCourse(courseId: selectedCourse.courseId)
                self.updateTimetable()
            }
        )
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        self.present(actionSheet, animated: true)
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
