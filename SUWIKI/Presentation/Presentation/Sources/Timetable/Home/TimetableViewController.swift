//
//  TimetableViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/10.
//

import UIKit
import Combine

import SnapKit
import Then

class TimetableViewController: UIViewController {

  private let timetable = Elliotable()

  private let navigationTitle = UILabel()
  private let timetableTitleBackground = UIView()
  private let timetableTitle = UILabel()
  private lazy var titleChangeButton = UIButton()
  private lazy var addButton = UIBarButtonItem()
  private lazy var listButton = UIBarButtonItem()
  private let timetableEmptyView = TimetableEmptyView()
  private let initView = InitView()

  private let viewModel = TimetableViewModel()
  private var cancellables: Set<AnyCancellable> = []

  override func viewDidLoad() {
    super.viewDidLoad()
    setStyle()
    setUI()
    setLayout()
    setDelegate()
    bind()
  }

  private func bind() {
    viewModel.$timetableTitle
      .receive(on: RunLoop.main)
      .sink { [weak self] title in
        guard let self else { return }
        self.timetableTitle.text = title
      }
      .store(in: &cancellables)

    viewModel.$timetableIsEmpty
      .combineLatest(viewModel.$isVersionChecked)
      .receive(on: RunLoop.main)
      .sink { [weak self] isEmpty, versionChecked in
        guard let self else { return }

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
      .sink { [weak self] _ in
        guard let self else { return }
        self.timetable.reloadData()
      }
      .store(in: &cancellables)
  }

  private func setStyle() {
    navigationTitle.do {
      $0.text = "SUWIKI"
      $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    timetableTitleBackground.do {
      $0.layer.cornerRadius = 12.0
      $0.frame = CGRect(x: 0, y: 0, width: 0, height: 60)
      $0.backgroundColor = .white
    }

    timetableTitle.do {
      $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = 12.0
      $0.backgroundColor = .white
      $0.textAlignment = .left
      $0.textColor = .black
    }

    titleChangeButton.do {
      let uiImage = UIImage(systemName: "pencil")
      $0.setImage(uiImage?.imageWithColor(color: .primaryColor), for: .normal)
      $0.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
    }

    timetableEmptyView.addButton.do {
      $0.addAction(
        UIAction { [weak self] _ in self?.viewModel.addTimetable() },
        for: .touchUpInside
      )
    }

    view.backgroundColor = .systemGray6

    navigationController?.navigationBar.tintColor = UIColor.primaryColor
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    listButton = UIBarButtonItem(systemItem: .organize,
                                 primaryAction: UIAction { [weak self] _ in self?.listButtonTapped() })
    addButton = UIBarButtonItem(systemItem: .add,
                                primaryAction: UIAction { [weak self] _ in self?.addButtonTapped() })

    timetable.do {
      $0.layer.cornerRadius = 12.0
      $0.layer.masksToBounds = true
      $0.backgroundColor = .white
      $0.borderWidth = 1.0
      $0.borderColor = .systemGray6

      $0.elliotBackgroundColor = .white
      $0.textEdgeInsets = UIEdgeInsets(top: 10, left: 4, bottom: 2, right: 2)
      $0.courseTextAlignment = .left
      $0.roundCorner = .all
      $0.borderCornerRadius = 12

      $0.courseItemMaxNameLength = 18
      $0.courseItemHeight = 60
      $0.courseItemTextSize = 11
      $0.roomNameFontSize = 9
      $0.symbolFontSize = 14
      $0.symbolTimeFontSize = 14

      $0.symbolFontColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
      $0.symbolTimeFontColor = UIColor(displayP3Red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    }
  }

  private func setUI() {
    [
      timetable,
      timetableEmptyView,
      timetableTitleBackground,
      initView
    ].forEach { view.addSubview($0) }

    [
      timetableTitle,
      titleChangeButton
    ].forEach { timetableTitleBackground.addSubview($0 )}
  }

  private func setLayout() {
    timetable.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).inset (80)
      $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
    }

    timetableEmptyView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
      $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-80)
      $0.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
      $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
    }

    timetableTitleBackground.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
      $0.leading.equalToSuperview().offset(15)
      $0.trailing.equalToSuperview().offset(-15)
      $0.height.equalTo(60)
    }

    timetableTitle.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(timetableTitleBackground.snp.leading).offset(10)
      $0.trailing.equalTo(titleChangeButton.snp.leading).offset(-10)
    }

    titleChangeButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(timetableTitle.snp.trailing).offset(10)
      $0.trailing.equalTo(timetableTitleBackground.snp.trailing).offset(-12)
      $0.width.equalTo(18)
      $0.height.equalTo(18)
    }

    initView.snp.makeConstraints {
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

  private func setDelegate() {
    timetable.delegate = self
    timetable.dataSource = self
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
    present(alert, animated: true)
  }


  func addButtonTapped() {
    let majorVC = UINavigationController(rootViewController: SelectMajorViewController())
    if let sheet = majorVC.sheetPresentationController {
      sheet.prefersGrabberVisible = true
    }

    present(majorVC, animated: true)
  }

  func listButtonTapped() {
    let listVC = TimetableListViewController()
    listVC.delegate = self

    let listNC = UINavigationController(rootViewController: listVC)
    if let sheet = listNC.sheetPresentationController {
      sheet.prefersGrabberVisible = true
    }

    present(listNC, animated: true)
  }
}

extension TimetableViewController: ElliotableDelegate, ElliotableDataSource, TimetableDelegate {

  func updateTimetable() {
    viewModel.fetchTimetable()
  }

  func elliotable(
    elliotable: Elliotable,
    didSelectCourse selectedCourse: ElliottEvent
  ) {
    suwikiAlert(
      title: "\(selectedCourse.courseName) | \(selectedCourse.professor)",
      message: selectedCourse.roomName,
      style: .actionSheet,
      UIAlertAction(
        title: "삭제",
        style: .destructive
      ) { [weak self] _ in
        guard let self = self else { return }
        self.viewModel.deleteCourse(courseId: selectedCourse.courseId)
        self.updateTimetable()
      }
    )
  }

  func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) { }

  func elliotable(
    elliotable: Elliotable,
    at dayPerIndex: Int
  ) -> String {
    return viewModel.weekdays[dayPerIndex]
  }
  
  func numberOfDays(in elliotable: Elliotable) -> Int {
    return viewModel.weekdays.count
  }
  
  func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
    return viewModel.elliottEvent
  }
}

protocol TimetableDelegate: AnyObject {
  func updateTimetable()
}
