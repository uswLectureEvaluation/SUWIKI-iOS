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


class AddCourseViewController: UIViewController {
    
    var cancellable = Set<AnyCancellable>()
    var viewModel = DepartmentCategoryViewModel()
    
    private let categoryTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(cellType: DepartmentCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetUp()
        addSubView()
        setUpTableView()
    }

    func navigationSetUp() {
        self.title = "Hi"
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(rightButtonTapped))
        let leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(leftButtonTapped))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
    }

    func addSubView() {
        self.view.addSubview(self.categoryTableView)
    }

    func setUpTableView() {
        self.categoryTableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(10)
        }
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.reloadData()
    }
    
    @objc func rightButtonTapped() {
        print("Right")
    }
    
    @objc func leftButtonTapped() {
        print("Left")
    }

}

extension AddCourseViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.department.section.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return viewModel.department.section[section]
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as DepartmentCell
        cell.justLabel.text = "학과 - 어디학과"
        return cell
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
