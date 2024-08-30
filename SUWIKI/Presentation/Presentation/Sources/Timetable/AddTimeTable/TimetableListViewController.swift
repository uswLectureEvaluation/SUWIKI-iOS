//
//  TimetableListViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import UIKit
import Combine

import SnapKit
import Then

class TimetableListViewController: UIViewController, UINavigationControllerDelegate {
  
  weak var delegate: TimetableDelegate?

  private let emptyLabel = UILabel()
  private let tableView = UITableView(frame: .zero, style: .insetGrouped)

  let viewModel = TimetableListViewModel()
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setLayout()
    setTableView()
    bind()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setStyle()
    viewModel.fetchTimetableList()
  }

  private func bind() {
    viewModel.$timetable
      .receive(on: RunLoop.main)
      .sink { [weak self] _ in
        guard let self else { return }
        self.tableView.reloadData()
      }
      .store(in: &cancellables)
  }

  private func setStyle() {
    tableView.do {
      $0.tableHeaderView = UIView(
        frame: CGRect(
          x: 0.0,
          y: 10.0,
          width: 0.0,
          height: CGFloat.leastNonzeroMagnitude
        )
      )
      $0.register(cellType: TimetableListCell.self)
    }

    view.backgroundColor = .systemGray6

    navigationItem.title = "시간표 목록"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .systemGray6

    let addButton = UIBarButtonItem(title: "추가", primaryAction: UIAction { [weak self] _ in self?.addButtonTapped() })
    let flexibleSpaceItem = UIBarButtonItem(systemItem: .flexibleSpace)
    navigationController?.isToolbarHidden = false
    setToolbarItems([flexibleSpaceItem, addButton], animated: true)

    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    button.addAction(UIAction { [weak self] _ in self?.dismiss(animated: true) },
                     for: .touchUpInside)
    button.tintColor = .gray

    let rightButton = UIBarButtonItem(customView: button)
    rightButton.customView?.translatesAutoresizingMaskIntoConstraints = false
    rightButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
    rightButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
    navigationItem.rightBarButtonItem = rightButton
  }

  private func setUI() {
    view.addSubview(emptyLabel)
    view.addSubview(tableView)
  }

  private func setLayout() {
    emptyLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
      $0.leading.equalTo(view.safeAreaLayoutGuide)
      $0.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(0)
    }
    tableView.snp.makeConstraints {
      $0.top.equalTo(emptyLabel.snp.bottom).offset(0)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.leading.equalTo(view.safeAreaLayoutGuide)
      $0.trailing.equalTo(view.safeAreaLayoutGuide)
    }
  }

  private func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func addButtonTapped() {
    let addVC = AddTimetableViewController(viewModel: AddTimetableViewModel())
    self.navigationController?.pushViewController(addVC, animated: true)
  }
  
  private func customAlert(index: Int) {
    suwikiAlert(
      title: "시간표를 삭제하시겠어요?",
      UIAlertAction(
        title: "삭제",
        style: .destructive,
        handler: { [weak self] _ in
          guard let self else { return }
          self.viewModel.deleteTimetable(index: index, currentVC: self)
        }
      )
    )
  }
}

extension TimetableListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return viewModel.timetableNumberOfRowsInSection
  }
  
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as TimetableListCell
    cell.updateUI(
      semester: viewModel.timetable[indexPath.row].semester,
      title: viewModel.timetable[indexPath.row].name,
      action: UIAction { [weak self] _ in
        guard let self else { return }
        self.customAlert(index: indexPath.row)
      }
    )
    return cell
  }
  
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return 80
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    viewModel.updateTimetable(index: indexPath.row)
    delegate?.updateTimetable()
    dismiss(animated: true)
  }
}
