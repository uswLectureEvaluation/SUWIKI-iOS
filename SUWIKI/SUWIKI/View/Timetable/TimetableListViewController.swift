//
//  TimetableListViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import UIKit

import SnapKit
import Then

class TimetableListViewController: UIViewController, UINavigationControllerDelegate {
    
    private let emptyLabel = UILabel().then {
        $0.text = ""
    }
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        $0.register(cellType: TimetableListCell.self)
    }
    
    
    let viewModel = TimetableListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "시간표 목록"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
//        let temp = UIBarButtonItem(title: "추가", primaryAction: UIAction { [weak self] _ in self?.addButtonTapped() })
        let addButton = UIBarButtonItem(title: "추가", primaryAction: UIAction { [weak self] _ in self?.addButtonTapped() })
        let flexibleSpaceItem = UIBarButtonItem(systemItem: .flexibleSpace)
        self.navigationController?.isToolbarHidden = false
//        navigationController?.setToolbarItems(, animated: false)
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
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    private func setupUI() {
        self.view.addSubview(self.emptyLabel)
        self.view.addSubview(self.tableView)
    }
    
    func setupTableView() {
        self.emptyLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(0)
        }
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(emptyLabel.snp.bottom).offset(0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
        tableView.reloadData()
    }
    
    func addButtonTapped() {
        let addVC = AddTimetableViewController(viewModel: AddTimetableViewModel())
        self.navigationController?.pushViewController(addVC, animated: true)
    }

}

extension TimetableListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.timetableNumberOfRowsInSection
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TimetableListCell
        cell.semesterLabel.text = viewModel.timetable[indexPath.row].semester
        cell.titleLabel.text = viewModel.timetable[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

