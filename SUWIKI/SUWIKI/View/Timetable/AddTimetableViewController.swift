//
//  AddTimetableViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/29.
//

import UIKit

import SnapKit
import Then


class AddTimetableViewController: UIViewController {

    //MARK: UI
    
    private let timetableNameTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        $0.rightView = paddingView
        $0.rightViewMode = .always
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
        $0.placeholder = "시간표 이름을 입력하세요!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "시간표 추가"
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

    private func setupUI() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(timetableNameTextField)
    }
    
    private func setupConstraints() {
        self.timetableNameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(48)
        }
    }

    @objc func rightButtonTapped() {
        dismiss(animated: true)
    }
    
}
