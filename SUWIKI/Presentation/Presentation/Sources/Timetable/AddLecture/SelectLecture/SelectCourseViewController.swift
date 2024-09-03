//
//  ViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/23.
//

import UIKit
import Combine

import Domain

import SnapKit
import Then

class SelectCourseViewController: UIViewController {

  private let searchEmptyView = SearchCourseEmptyView()
  private let searchController = UISearchController()
  private let searchBar = UISearchBar()
  private let courseTableView = UITableView(frame: .zero, style: .insetGrouped).then {
    $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
    $0.register(cellType: CourseCell.self)
  }

  private var viewModel: SelectCourseListViewModel
  private var cancellable = Set<AnyCancellable>()

  init(viewModel: SelectCourseListViewModel) {
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
    setDelegate()
    bind()
  }

  override func viewWillAppear(_ animated: Bool) {
    setStyle()
  }

  private func bind() {
    viewModel.$searchedCourseList
      .combineLatest(viewModel.$searchText)
      .receive(on: RunLoop.main)
      .sink { [weak self] searchedCourseList, searchText in
        guard let self else { return }
        if searchText.isEmpty {
          courseTableView.backgroundView?.isHidden = false
        } else {
          if searchedCourseList.isEmpty {
            searchEmptyView.updateUI(searchText: "'\(searchText)'")
            courseTableView.backgroundView?.isHidden = false
          } else {
            courseTableView.backgroundView?.isHidden = true
          }
        }
        courseTableView.reloadData()
      }
      .store(in: &cancellable)

    NotificationCenter.default.publisher(
      for: UISearchTextField.textDidChangeNotification,
      object: searchController.searchBar.searchTextField
    )
    .compactMap { $0.object as? UISearchTextField }
    .map { $0.text ?? "" }
    .removeDuplicates()
    .assign(to: \.searchText, on: viewModel)
    .store(in: &cancellable)
  }

  private func setStyle() {
    view.backgroundColor = .systemGray6

    searchController.searchBar.placeholder = "강의를 검색하세요!"
    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self

    courseTableView.backgroundView = searchEmptyView

    navigationItem.title = viewModel.major
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .systemGray6

    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    button.tintColor = .gray

    let rightButton = UIBarButtonItem(customView: button)
    rightButton.customView?.translatesAutoresizingMaskIntoConstraints = false
    rightButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
    rightButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

    navigationItem.rightBarButtonItem = rightButton
  }

  private func setUI() {
    [
      searchBar,
      courseTableView
    ].forEach { view.addSubview($0) }
  }

  private func setLayout() {
    courseTableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
      $0.bottom.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
  }

  private func setDelegate() {
    searchController.searchBar.delegate = self
    courseTableView.delegate = self
    courseTableView.dataSource = self
    courseTableView.reloadData()
  }
}

extension SelectCourseViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) { }
}

extension SelectCourseViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.searchText = ""
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    searchBar.searchTextField.resignFirstResponder()
  }
}

extension SelectCourseViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return 90
  }

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    if viewModel.searchText.isEmpty {
      return viewModel.courseNumbersOfRowsInSection
    } else {
      return viewModel.searchedCourseNumbersOfRowsInSection
    }
  }

  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    var fetchCourse: FetchCourse
    if viewModel.searchText.isEmpty {
      fetchCourse = viewModel.courseList[indexPath.row]
    } else {
      fetchCourse = viewModel.searchedCourseList[indexPath.row]
    }
    viewModel.pushVC(
      fetchCourse: fetchCourse,
      currentVC: self,
      animated: true
    )
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as CourseCell
    let selectCourseViewModel = viewModel.courseViewModelAtIndex(indexPath.row)
    cell.viewModel = selectCourseViewModel
    return cell
  }
}
