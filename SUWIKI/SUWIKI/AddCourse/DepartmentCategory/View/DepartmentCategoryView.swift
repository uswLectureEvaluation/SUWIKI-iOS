//
//  ViewController.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/23.
//

import UIKit

import SnapKit
import Then
import RxSwift
import ReactorKit

class DepartmentCategoryView: UIViewController, View {
    
    typealias Reactor = DepartmentCategoryReactor
    
    var disposeBag = DisposeBag()    
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .blue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        setUpView()
    }
    
    func addSubView() {
        self.view.addSubview(self.tableView)
    }

    func setUpView() {
        self.tableView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalToSuperview()
        }
    }
    
    func bind(reactor: Reactor) {
        print("Hi")
    }

}


