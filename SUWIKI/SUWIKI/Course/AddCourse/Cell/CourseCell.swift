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
    
    let courseTime = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    let grade = UILabel().then {
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabels()
        setUpLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addLabels() {
        contentView.addSubview(courseName)
        contentView.addSubview(classification)
        contentView.addSubview(major)
        contentView.addSubview(professor)
        contentView.addSubview(courseTime)
        contentView.addSubview(grade)
    }
    
    func setUpLabels() {
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
        courseTime.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalTo(major.snp.bottom).offset(5)
        }
        
    }

}
