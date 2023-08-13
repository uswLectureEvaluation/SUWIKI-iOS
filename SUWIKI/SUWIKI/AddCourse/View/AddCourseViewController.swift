//
//  ViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/23.
//

import UIKit

import Combine
import CombineCocoa
import SnapKit
import Then
// 32
class AddCourseViewController: UIViewController {
    
    var cancellable = Set<AnyCancellable>()
    var viewModel = AddCourseListViewModel()
    var isFinished = PassthroughSubject<Void, Never>()
    
//    var searchController: UISearchController!/
    
    private let searchBar = UISearchBar().then {
//        $0.barTintColor = .white
//        $0.tintColor = .white
//        $0.color
//        $0.searchTextField.tintColor = .white
//        $0.searchTextField.backgroundColor = .white
        $0.searchBarStyle = .minimal
        $0.backgroundColor = UIColor.systemGray6
//        $0.setTextFieldColor(.white)
        $0.placeholder = "시간표 검색"
    }
    
//    private let searchBar = UILabel().then {
//        $0.text = "Hi"
//    }
    
//    tableView.contentInsetAdjustmentBehavior = .never
//    tableView.insetsContentViewsToSafeArea = false
//    tableView.insetsLayoutMarginsFromSafeArea = false
//    tableView.preservesSuperviewLayoutMargins = false
    
    private let categoryTableView = UITableView(frame: .zero, style: .insetGrouped).then {
//        $0.preservesSuperviewLayoutMargins = false
//        $0.insetsLayoutMarginsFromSafeArea = false
//        $0.insetsContentViewsToSafeArea = false
//        $0.contentInsetAdjustmentBehavior = .never
        $0.isScrollEnabled = false
        $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        $0.register(cellType: CategoryCell.self)
    }
    
    private let courseTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        $0.register(cellType: CourseCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        addSubView()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationSetUp()
    }
    //        searchControllerSetting()
//        viewModel.getCourse()

    func navigationSetUp() {
        self.title = "시간표 추가"
//        navigationcon
        navigationController?.navigationBar.backgroundColor = .systemGray6
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightButtonTapped))
            
        let leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func rightButtonTapped() {
        
        let isDuplicated = viewModel.saveCourse()
        if isDuplicated {
            print("@Log isDuplicated")
        } else {
            isFinished.send()
            dismiss(animated: true)
        }
//
//        viewModel
//            .$isFinished
//            .receive(on: DispatchQueue.main)
//            .assign(to: \., on: <#T##Root#>)
    }
    
    @objc func leftButtonTapped() {
//        viewModel.tempStringToDate()
    }

}

//MARK: SearchController
extension AddCourseViewController {
    func searchControllerSetting() {

    }
}

//MARK: TableView
extension AddCourseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func addSubView() {
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.categoryTableView)
        self.view.addSubview(self.courseTableView)
    }

    //            $0.top.equalTo(additionalSafeAreaInsets.top)
    func setUpTableView() {
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(44)
        }
        self.categoryTableView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(88)
        }
        self.courseTableView.snp.makeConstraints {
            $0.top.equalTo(categoryTableView.snp.bottom).offset(24)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.reloadData()
        courseTableView.delegate = self
        courseTableView.dataSource = self
        courseTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == categoryTableView {
            return 44
        }
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == categoryTableView {
            return 2
        }
        return viewModel.numbersOfRowsInSection // 시간표 갯수 viewModel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCourse(indexPath.row)
        if viewModel.selectedIndex == -1 {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == categoryTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath) as CategoryCell
            switch indexPath {
            case [0, 0]:
                cell.categoryNameLabel.text = "학과"
                cell.selectedLabel.text = "컴퓨터공학과"
            case [0, 1]:
                cell.categoryNameLabel.text = "학년"
                cell.selectedLabel.text = "4학년"
            default:
                print("Hi")
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath) as CourseCell
            let addCourseViewModel = viewModel.courseViewModelAtIndex(indexPath.row)
            cell.viewModel = addCourseViewModel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView == courseTableView {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == courseTableView {
            if editingStyle == .delete {
                print("@Log delete")
            }
        }
   }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let courseViewController = CourseViewController()
//        self.navigationController?.pushViewController(courseViewController, animated: true)
//    }
        
}





//    func setUpDataSource() {
//        dataSource = RxTableViewSectionedReloadDataSource<DepartmentSection> { _, tableView, indexPath, item in
//            let cell = tableView.dequeueReusableCell(for: indexPath) as DepartmentCell
//            cell.justLabel.text = "\(item.name)"
//            return cell
//        }
//        dataSource?.titleForHeaderInSection = { dataSource, index in
//            return dataSource.sectionModels[index].header
//        }
//    }
//
//    func bind() {
//        Observable.just(departmentSection())
//            .bind(to: tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//
//        tableView.rx
//            .itemSelected
//            .subscribe { [weak self] indexPath in
//                guard let self = self else { return }
//                let vc = CourseView()
//                self.navigationController?.pushViewController(CourseView, animated: true)
//                self.viewModel.selectedMajor(major: dataSource[indexPath].name)
//            }
//            .disposed(by: disposeBag)
//    }
//
//    func departmentSection() -> [DepartmentSection] {
//        [
//            DepartmentSection(items: ["간호학과", "건설환경공학", "건축학과", "경영학과", "경제금융학과", "공예디자인학과", "관현악과", "국악과", "국어국문학", "국제개발협력학과", "기계공학과"].map { Department(name: $0) }, header: "ㄱ"),
//            DepartmentSection(items: [Department(name: "도시부동산학과")], header: "ㄷ"),
//            DepartmentSection(items: ["러시아어문학", "레저스포츠학과"].map { Department(name: $0) }, header: "ㄹ"),
//            DepartmentSection(items: ["문화컨텐츠테크놀러지학과", "미디어SW학과"].map { Department(name: $0) }, header: "ㅁ"),
//            DepartmentSection(items: ["사학", "산업공학과", "성악과", "소방행정학과(야)", "시스템반도체융복합학과", "식품영양학과", "신소재공학과"].map { Department(name: $0) }, header: "ㅅ"),
//            DepartmentSection(items: ["아동가족복지학과", "연극과", "영어영문학", "영화영상과", "외식경영학과", "운동건강관리학과", "융합화학산업", "의류학과", "일어일문학"].map { Department(name: $0) }, header: "ㅇ"),
//            DepartmentSection(items: ["작곡과", "전기공학과", "전자공학과", "전자재료공학", "정보보호학과", "정보통신공학과", "조소과", "중어중문학"].map { Department(name: $0) }, header: "ㅈ"),
//            DepartmentSection(items: [Department(name: "체육학과")], header: "ㅊ"),
//            DepartmentSection(items: ["커뮤니케이션디자인학과", "컴퓨터SW학과", "클라우드융복합학과"].map { Department(name: $0) }, header: "ㅋ"),
//            DepartmentSection(items: ["패션디자인학과", "피아노과"].map { Department(name: $0) }, header: "ㅌ"),
//            DepartmentSection(items: ["행정학", "호텔경영학과", "화학공학과", "환경에너지공학", "회계학과", "회화과"].map { Department(name: $0) }, header: "ㅎ")
//        ]
//    }
