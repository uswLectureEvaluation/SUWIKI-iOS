//
//  AddTimetableViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/29.
//

import UIKit
import Combine

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
    
    private let semesterPickerView = UIPickerView().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
    }
    
    private let addButton = UIButton().then {
        $0.backgroundColor = .lightGray
        $0.setTitle("추가", for: UIControl.State())
    }
    
    private var cancellables: Set<AnyCancellable> = []
    let viewModel: AddTimetableViewModel
    
    init(viewModel: AddTimetableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        binding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func binding() {
        bindingViewToViewModel()
        bindingViewModelToView()
    }
    
    private func bindingViewToViewModel() {
        self.timetableNameTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.name, on: viewModel)
            .store(in: &cancellables)
    }
    
    private func bindingViewModelToView() {
        viewModel.addTimetableIsVaild
            .receive(on: RunLoop.main)
            .sink { [weak self]  isVaild in
                self?.addButton.isEnabled = isVaild
                self?.addButton.backgroundColor = isVaild ? .primaryColor : .lightGray
            }
            .store(in: &cancellables)
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
        self.view.addSubview(semesterPickerView)
        self.view.addSubview(addButton)
        semesterPickerView.delegate = self
        semesterPickerView.dataSource = self
        semesterPickerView.selectRow(1, inComponent: 0, animated: false)
    }
    
    private func setupConstraints() {
        self.timetableNameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(48)
        }
        self.semesterPickerView.snp.makeConstraints {
            $0.top.equalTo(timetableNameTextField.snp.bottom).offset(24)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(132)
        }
        self.addButton.snp.makeConstraints {
            $0.top.equalTo(semesterPickerView.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(52)
        }
    }

    @objc func rightButtonTapped() {
        dismiss(animated: true)
    }
    
}

extension AddTimetableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.semester.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.semester[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.updateSelectedSemester(with: viewModel.semester[row])
    }
}
