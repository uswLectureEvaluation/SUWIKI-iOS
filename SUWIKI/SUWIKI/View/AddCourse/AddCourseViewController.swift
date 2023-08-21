//
//  AddCourseViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/21.
//

import UIKit

import Then
import SnapKit

class AddCourseViewController: UIViewController {

    let addCourseView = AddCourseView()
    
    let changeColorButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .timetableColors[0]
        $0.tintColor = .white
        $0.setTitle("시간표 색상 변경", for: .normal)
    }
    
    let addButton = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .primaryColor
        $0.tintColor = .white
        $0.setTitle("추가", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setConstratints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    
    func setNavigationBar() {
        self.title = "강의 정보"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        
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
    
    private func setUI() {
        self.view.backgroundColor = .systemGray6
        addCourseView.layer.cornerRadius = 12
        self.view.addSubview(addCourseView)
        self.view.addSubview(changeColorButton)
        self.view.addSubview(addButton)
    }
    
    private func setConstratints() {
        
        addCourseView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(303)
        }
        
        changeColorButton.snp.makeConstraints {
            $0.top.equalTo(addCourseView.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(60)
        }
        
        addButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-36)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(60)
        }
        
    }
    
    @objc func rightButtonTapped() {
        dismiss(animated: true)
    }
    

}
