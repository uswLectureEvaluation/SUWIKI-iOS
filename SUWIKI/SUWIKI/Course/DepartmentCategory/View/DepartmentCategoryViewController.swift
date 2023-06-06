//
//  DepartmentCategoryViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/02.
//

import UIKit

import SnapKit
import Then

class DepartmentCategoryViewController: UIViewController {

    var viewModel = DepartmentCategoryViewModel()
    
    private let tableView = UITableView().then {
        $0.register(cellType: DepartmentCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addSubView() {
        self.view.addSubview(self.tableView)
    }

    func setUpTableView() {
        self.tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(10)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

}

extension DepartmentCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.department.section.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.department.section[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.department.name[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as DepartmentCell
        cell.justLabel.text = viewModel.department.name[indexPath.section][indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let courseViewController = CourseViewController()
//        self.navigationController?.pushViewController(courseViewController, animated: true)
//    }
}
