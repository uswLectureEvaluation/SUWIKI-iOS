//
//  ViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/23.
//

import UIKit

import Combine
import SnapKit
import Then

class SelectCourseViewController: UIViewController {

    var cancellable = Set<AnyCancellable>()
    var viewModel: SelectCourseListViewModel
    var isFinished = PassthroughSubject<Void, Never>()
    let searchEmptyView = SearchCourseEmptyView()
    
    init(viewModel: SelectCourseListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchController = UISearchController()
    
    private let courseTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        $0.register(cellType: CourseCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("@Log SearchText -\(viewModel.searchText)-")
        print("@Log - \(viewModel.courseNumbersOfRowsInSection)")
        self.view.backgroundColor = .systemGray6
        binding()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    private func binding() {
        viewModel.$courseList
            .receive(on: RunLoop.main)
            .sink { _ in
                self.courseTableView.reloadData()
            }
            .store(in: &cancellable)
    }

    private func setupNavigationBar() {
        self.navigationItem.title = viewModel.major
        
        searchController.searchBar.placeholder = "강의를 검색하세요!"
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.tintColor = .gray
            
        let rightButton = UIBarButtonItem(customView: button)
        rightButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        rightButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }

}

//MARK: SearchController
extension SelectCourseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

//MARK: SearchBar
extension SelectCourseViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = ""
        courseTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Button")
        guard let searchText = searchBar.text else { return }
        viewModel.searchText = searchText
        viewModel.removeSpacingFromSearchText()
        viewModel.searchedCourseList = viewModel.courseList.filter {
            $0.courseName?.lowercased().contains(viewModel.searchText.lowercased()) ?? false }
        if viewModel.searchedCourseList.isEmpty {
            searchEmptyView.updateUI(searchText: "'\(searchText)'")
            courseTableView.backgroundView?.isHidden = false
        } else {
            courseTableView.backgroundView?.isHidden = true
        }
        courseTableView.reloadData()
        searchBar.searchTextField.resignFirstResponder()
    }
    
}

//MARK: TableView
extension SelectCourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupUI() {
        //MARK: searchBar를 addSubview하지 않으면 searchController가 출력되지 않는 버그 존재
        let searchBar = UISearchBar()
        self.view.addSubview(searchBar)
        self.view.addSubview(self.courseTableView)
    }
    
    func setupTableView() {
        self.courseTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        courseTableView.delegate = self
        courseTableView.dataSource = self
//        courseTableView.backgroundView = searchEmptyView
        courseTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.searchText.isEmpty {
            return viewModel.courseNumbersOfRowsInSection // 시간표 갯수 viewModel.count
        } else {
            return viewModel.searchedCourseNumbersOfRowsInSection
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var firebaseCourse: FirebaseCourse
        if viewModel.searchText.isEmpty {
            firebaseCourse = viewModel.courseList[indexPath.row]
        } else {
            firebaseCourse = viewModel.searchedCourseList[indexPath.row]
        }
        viewModel.pushVC(firebaseCourse: firebaseCourse,
                         currentVC: self,
                         animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as CourseCell
        let selectCourseViewModel = viewModel.courseViewModelAtIndex(indexPath.row)
        cell.viewModel = selectCourseViewModel
        return cell
    }
        
}
