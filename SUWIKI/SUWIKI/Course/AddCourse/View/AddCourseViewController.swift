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
    var viewModel = DepartmentCategoryViewModel()
    
    private let categoryTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.isScrollEnabled = false
        $0.register(cellType: CategoryCell.self)
    }
    
    private let courseTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(cellType: CourseCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetUp()
        addSubView()
        setUpTableView()
    }

    func navigationSetUp() {
        self.title = "시간표 추가"
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightButtonTapped))
        let leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }

    func addSubView() {
        self.view.addSubview(self.categoryTableView)
        self.view.addSubview(self.courseTableView)
    }

    func setUpTableView() {
        self.categoryTableView.snp.makeConstraints {
            $0.top.equalTo(additionalSafeAreaInsets.top)
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(225)
        }
        self.courseTableView.snp.makeConstraints {
            $0.top.equalTo(categoryTableView.snp.bottom)
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
    
    @objc func rightButtonTapped() {
        print("Right")
    }
    
    @objc func leftButtonTapped() {
        print("Left")
    }

}

extension AddCourseViewController: UITableViewDelegate, UITableViewDataSource {

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
        return 50 // 시간표 갯수
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
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath) as CourseCell
            cell.courseName.text = "데이터베이스설계및관리"
            cell.classification.text = "전핵"
            cell.major.text = "정보보호⎪"
            cell.professor.text = "김명숙⎪"
            cell.grade.text = "3학년"
            cell.courseTime.text = "IT306(수6,7,8)"
            return cell
        }
    }
//

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
