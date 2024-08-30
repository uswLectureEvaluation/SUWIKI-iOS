//
//  DepartmentCategoryViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/02.
//

import UIKit
import Combine

import SnapKit
import Then

class SelectMajorViewController: UIViewController {

  private let emptyLabel = UILabel().then {
    $0.text = ""
  }
  private let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
    $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
    $0.register(cellType: MajorCell.self)
  }

  private var viewModel = SelectMajorViewModel()
  private var cancellable = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemGray6
    bind()
    setUI()
    setLayout()
    setDelegate()
  }

  override func viewWillAppear(_ animated: Bool) {
    setStyle()
  }

  func bind() {
    viewModel.$major
      .receive(on: RunLoop.main)
      .sink { [weak self] _ in
        guard let self else { return }
        self.tableView.reloadData()
      }
      .store(in: &cancellable)
  }

  private func setStyle() {
    navigationItem.title = "학과 선택"
    navigationController?.navigationBar.backgroundColor = .systemGray6
    navigationItem.largeTitleDisplayMode = .always
    navigationController?.navigationBar.prefersLargeTitles = true

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
    view.addSubview(emptyLabel)
    view.addSubview(tableView)
  }

  private func setLayout() {
    emptyLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.equalTo(view.safeAreaLayoutGuide)
      $0.trailing.equalTo(view.safeAreaLayoutGuide)
      $0.height.equalTo(0)
    }

    tableView.snp.makeConstraints {
      $0.top.equalTo(emptyLabel.snp.bottom).offset(16)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.leading.equalTo(view.safeAreaLayoutGuide)
      $0.trailing.equalTo(view.safeAreaLayoutGuide)
    }
  }

  private func setDelegate() {
    tableView.delegate = self
    tableView.dataSource = self
  }

  @objc
  func rightButtonTapped() {
    dismiss(animated: true)
  }

  @objc
  func bookmarkButtonTapped(_ sender: UIButton) {
    viewModel.toggleBookmark(name: viewModel.major[sender.tag].name)
    tableView.reloadData()
  }
}

extension SelectMajorViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return viewModel.majorNumberOfRowsInSection
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as MajorCell
    cell.selectionStyle = .default
    cell.updateUI(viewModel.major[indexPath.row])
    cell.bookmarkButton.addTarget(
      self,
      action: #selector(bookmarkButtonTapped),
      for: .touchUpInside
    )
    cell.bookmarkButton.tag = indexPath.row
    return cell
  }

  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    viewModel.pushVC(
      major: viewModel.major[indexPath.row].name,
      currentVC: self,
      animated: true
    )
  }
}
