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

    var viewModel = SelectMajorViewModel()
    var cancellable = Set<AnyCancellable>()

    private let emptyLabel = UILabel().then {
        $0.text = ""
    }
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 10.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        $0.register(cellType: MajorCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        binding()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    func binding() {
        viewModel.$isMajorsFetched
            .receive(on: RunLoop.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &cancellable)
    }

    private func setupNavigationBar() {
        self.navigationItem.title = "학과 선택"
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        button.tintColor = .gray
            
        let rightButton = UIBarButtonItem(customView: button)
        rightButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        rightButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func setupUI() {
        self.view.addSubview(self.emptyLabel)
        self.view.addSubview(self.tableView)
    }

    func setupTableView() {
        self.emptyLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(0)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.emptyLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    @objc
    func rightButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc
    func bookmarkButtonTapped(_ sender: UIButton) {
        print("Log Touched")
        viewModel.toggleBookmark(name: viewModel.major[sender.tag].name)
        tableView.reloadData()
    }

}

extension SelectMajorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.majorNumberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MajorCell
        cell.selectionStyle = .default
        cell.majorLabel.text = viewModel.major[indexPath.row].name
        cell.countLabel.text = "/ \(viewModel.major[indexPath.row].courseCount)"
        cell.bookmarkButton.addTarget(self,
                            action: #selector(bookmarkButtonTapped),
                            for: .touchUpInside)
        cell.bookmarkButton.tag = indexPath.row
        if viewModel.major[indexPath.row].bookmark {
            cell.bookmarkButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.bookmarkButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.pushVC(major: viewModel.major[indexPath.row].name,
                         currentVC: self,
                         animated: true)
    }

}
