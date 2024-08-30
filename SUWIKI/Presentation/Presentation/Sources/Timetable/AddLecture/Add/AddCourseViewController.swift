//
//  AddCourseViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/21.
//

import UIKit
import Combine

import Then
import SnapKit

class AddCourseViewController: UIViewController {
  
  private let addCourseView = AddCourseView()
  private let changeColorButton = UIButton()
  private let addButton = UIButton()

  private let viewModel: AddCourseViewModel
  private var cancellables = Set<AnyCancellable>()

  init(viewModel: AddCourseViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setLayout()
    setAddCourseView()
    bind()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setStyle()
  }

  private func bind() {
    viewModel.$fetchCourse
      .receive(on: RunLoop.main)
      .sink { [weak self] course in
        guard let self else { return }
        self.addCourseView.updateUI(
          course: course,
          viewModel.timetableColorNumber
        )
      }
      .store(in: &cancellables)

    viewModel.$timetableColorNumber
      .receive(on: RunLoop.main)
      .sink { [weak self] colorNumber in
        guard let self else { return }
        self.addCourseView.changeColor(.timetableColors[colorNumber])
      }
      .store(in: &cancellables)
  }

  private func setStyle() {
    changeColorButton.do {
      $0.titleShadowColor(for: .highlighted)
      $0.backgroundColor = .systemGray5
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
      $0.layer.cornerRadius = 12
      $0.setTitleColor(.primaryColor, for: .normal)
      $0.setTitle("시간표 색상 변경", for: .normal)
      $0.addTarget(self, action: #selector(changeTimetableColorButtonTouchUpInside), for: .touchUpInside)
      $0.addTarget(self, action: #selector(changeTimetableColorButtonTouchCancel), for: .touchCancel)
      $0.addTarget(self, action: #selector(changeTimetableColorButtonTouchDown), for: .touchDown)
    }

    addButton.do {
      $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
      $0.layer.cornerRadius = 12
      $0.backgroundColor = .primaryColor
      $0.tintColor = .white
      $0.setTitle("추가", for: .normal)
      $0.addTarget(self, action: #selector(addButtonTouchUpInside), for: .touchUpInside)
      $0.addTarget(self, action: #selector(addButtonTouchCancel), for: .touchCancel)
      $0.addTarget(self, action: #selector(addButtonTouchDown), for: .touchDown)
    }

    view.backgroundColor = .systemGray6
    addCourseView.layer.cornerRadius = 12

    title = "강의 정보"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .systemGray6

    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    button.tintColor = .gray

    let rightButton = UIBarButtonItem(customView: button)
    rightButton.customView?.translatesAutoresizingMaskIntoConstraints = false
    rightButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
    rightButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

    navigationItem.rightBarButtonItem = rightButton
  }

  private func setUI() {
    [
      addCourseView,
      changeColorButton,
      addButton
    ].forEach { view.addSubview($0) }
  }
  
  private func setLayout() {
    addCourseView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(303)
    }
    
    changeColorButton.snp.makeConstraints {
      $0.top.equalTo(addCourseView.snp.bottom).offset(12)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(52)
    }
    
    addButton.snp.makeConstraints {
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-36)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(60)
    }
  }

  private func setAddCourseView() {
    addCourseView.updateUI(
      course: viewModel.fetchCourse,
      viewModel.timetableColorNumber
    )
  }

  @objc
  private func changeTimetableColorButtonTouchUpInside(_ sender: UIButton) {
    sender.backgroundColor = .systemGray5
    viewModel.changeTimetableColor()
  }

  @objc
  func changeTimetableColorButtonTouchCancel(_ sender: UIButton) {
    sender.backgroundColor = .systemGray5
  }
  
  @objc
  func changeTimetableColorButtonTouchDown(_ sender: UIButton) {
    sender.backgroundColor = .lightGray
  }
  
  @objc
  func addButtonTouchUpInside(_ sender: UIButton) {
    sender.setTitleColor(UIColor.white, for: .normal)
    sender.backgroundColor = .primaryColor
    Task {
      let isDuplicated = try await viewModel.saveCourse()
      if isDuplicated {
        customAlert()
      } else {
        NotificationCenter.default.post(
          name: Notification.Name("addCourse"),
          object: nil
        )
        self.dismiss(animated: true)
      }
    }
  }
  
  @objc
  func addButtonTouchCancel(_ sender: UIButton) {
    sender.setTitleColor(UIColor.white, for: .normal)
    sender.backgroundColor = .primaryColor
  }
  
  @objc
  func addButtonTouchDown(_ sender: UIButton) {
    sender.setTitleColor(UIColor.primaryColor, for: .normal)
    sender.backgroundColor = .systemGray2
  }
  
  
  @objc func rightButtonTapped() {
    self.dismiss(animated: true)
  }
  
  private func customAlert() {
    let alertController = UIAlertController(
      title: "중복되는 강의가 있어요",
      message: "선택한 시간에 이미 다른 강의가 있어요.\n강의 시간을 확인해주세요!",
      preferredStyle: .alert
    )
    let confirmAction = UIAlertAction(title: "확인", style: .default)
    alertController.addAction(confirmAction)
    present(alertController, animated: true, completion: nil)
  }
}
