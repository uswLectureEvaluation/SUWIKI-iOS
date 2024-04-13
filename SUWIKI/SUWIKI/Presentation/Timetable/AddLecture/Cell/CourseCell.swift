//
//  CourseCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/02.
//

import UIKit

import Reusable
import SnapKit
import Then

class CourseCell: UITableViewCell, Reusable {
    
    var viewModel: SelectCourseViewModel! {
        didSet {
            configureUI()
        }
    }

    //MARK: UI
    
    let courseName = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let classification = UILabel().then {
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.cornerRadius = 10.0
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    let major = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let professor = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let roomName = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    let grade = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    let credit = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLabels() {
        [courseName, classification, grade, major, professor, roomName, credit].forEach {
            contentView.addSubview($0)
        }
        
        classification.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).offset(-10)
            $0.top.equalToSuperview().offset(15)
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
        courseName.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(15)
        }
        major.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(courseName.snp.bottom).offset(5)
        }
        professor.snp.makeConstraints {
            $0.leading.equalTo(major.snp.trailing)
            $0.top.equalTo(courseName.snp.bottom).offset(5)
        }
        grade.snp.makeConstraints {
            $0.leading.equalTo(professor.snp.trailing)
            $0.top.equalTo(courseName.snp.bottom).offset(5)
        }
        roomName.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(major.snp.bottom).offset(5)
        }
        credit.snp.makeConstraints {
            $0.leading.equalTo(roomName.snp.trailing)
            $0.top.equalTo(major.snp.bottom).offset(5)
        }
    }
    
    func configureUI() {
        self.classification.text = viewModel.classification
        self.courseName.text = viewModel.courseName
        self.grade.text = viewModel.grade
        self.credit.text = viewModel.credit
        self.major.text = viewModel.major
        self.professor.text = viewModel.professor
        self.roomName.text = viewModel.roomName
    }

}
