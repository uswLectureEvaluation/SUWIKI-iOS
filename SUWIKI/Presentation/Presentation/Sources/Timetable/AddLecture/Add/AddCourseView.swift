//
//  AddCourseView.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/21.
//

import UIKit

import Domain

import Then
import SnapKit

class AddCourseView: UIView {
  
  private let classficationLabel = UILabel().then {
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 16
    $0.textAlignment = .center
    $0.textColor = .white
    $0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
  }
  
  private let courseTitleLabel = UILabel().then {
    $0.textColor = .gray
    $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
  }
  
  private let courseNameLabel = UILabel().then {
    $0.numberOfLines = 1
    $0.adjustsFontSizeToFitWidth = true
    $0.minimumScaleFactor = 0.5
    $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
  }
  
  private let gradeLabel = UILabel().then {
    $0.textColor = .gray
    $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
  }
  
  private let barImage = UIImageView().then {
    $0.tintColor = .gray
    $0.image = UIImage(named: "bar")
  }
  
  private let creditLabel = UILabel().then {
    $0.text = "3학점"
    $0.textColor = .gray
    $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
  }
  
  private let majorTitleLabel = UILabel().then {
    $0.text = "학과"
    $0.textColor = .gray
    $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
  }
  
  private let majorLabel = UILabel().then {
    $0.text = "컴퓨터SW"
    $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
  }
  
  private let professorTitleLabel = UILabel().then {
    $0.text = "교수"
    $0.textColor = .gray
    $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
  }
  
  private let professorLabel = UILabel().then {
    $0.text = "김대엽"
    $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
  }
  
  private let roomNameLabel = UILabel().then {
    $0.textColor = .white
    $0.text = "IT301(목3,4)"
    $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
  }
  
  private let bottomBackground = UIView().then {
    $0.layer.maskedCorners = [CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner]
    $0.layer.cornerRadius = 12
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setStyle()
    setUI()
    setLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setStyle() {
    backgroundColor = .white
  }

  private func setUI() {
    [
      bottomBackground,
      classficationLabel,
      courseTitleLabel,
      courseNameLabel,
      gradeLabel,
      barImage,
      creditLabel,
      majorTitleLabel,
      majorLabel,
      professorTitleLabel,
      professorLabel,
      roomNameLabel
    ].forEach { addSubview($0) }
  }
  
  private func setLayout() {
    classficationLabel.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(12)
      $0.trailing.equalTo(self.snp.trailing).offset(-12)
      $0.width.equalTo(52)
      $0.height.equalTo(32)
    }
    
    courseTitleLabel.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(32)
      $0.leading.equalTo(self.snp.leading).offset(16)
      $0.height.equalTo(16)
    }
    
    courseNameLabel.snp.makeConstraints {
      $0.top.equalTo(courseTitleLabel.snp.bottom).offset(4)
      $0.leading.equalTo(self.snp.leading).offset(16)
      $0.trailing.equalTo(self.snp.trailing).offset(-16)
      $0.height.equalTo(35)
    }
    
    gradeLabel.snp.makeConstraints {
      $0.top.equalTo(courseNameLabel.snp.bottom).offset(4)
      $0.leading.equalTo(self.snp.leading).offset(16)
      $0.height.equalTo(22)
    }
    
    barImage.snp.makeConstraints {
      $0.top.equalTo(courseNameLabel.snp.bottom).offset(6)
      $0.leading.equalTo(gradeLabel.snp.trailing).offset(6)
      $0.height.equalTo(17)
    }
    
    creditLabel.snp.makeConstraints {
      $0.top.equalTo(courseNameLabel.snp.bottom).offset(4)
      $0.leading.equalTo(barImage.snp.trailing).offset(6)
      $0.height.equalTo(22)
    }
    
    majorTitleLabel.snp.makeConstraints {
      $0.top.equalTo(gradeLabel.snp.bottom).offset(16)
      $0.leading.equalTo(self.snp.leading).offset(16)
      $0.height.equalTo(16)
    }
    
    majorLabel.snp.makeConstraints {
      $0.top.equalTo(majorTitleLabel.snp.bottom).offset(4)
      $0.leading.equalTo(self.snp.leading).offset(16)
      $0.height.equalTo(22)
    }
    
    professorTitleLabel.snp.makeConstraints {
      $0.top.equalTo(majorLabel.snp.bottom).offset(16)
      $0.leading.equalTo(self.snp.leading).offset(16)
      $0.height.equalTo(16)
    }
    
    professorLabel.snp.makeConstraints {
      $0.top.equalTo(professorTitleLabel.snp.bottom).offset(4)
      $0.leading.equalTo(self.snp.leading).offset(16)
      $0.height.equalTo(22)
    }
    
    bottomBackground.snp.makeConstraints {
      $0.bottom.equalTo(self.snp.bottom)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(48)
    }
    
    roomNameLabel.snp.makeConstraints {
      $0.trailing.equalTo(bottomBackground.snp.trailing).offset(-12)
      $0.centerY.equalTo(bottomBackground.snp.centerY)
      $0.height.equalTo(22)
    }
  }
  
  func updateUI(
    course: FetchCourse,
    _ colorNumber: Int
  ) {
    classficationLabel.text = course.classification
    courseNameLabel.text = course.courseName
    addCourseView.gradeLabel.text = "\(course.num)학년"
    addCourseView.creditLabel.text = "\(course.credit)학점"
    addCourseView.majorLabel.text = course.major
    addCourseView.professorLabel.text = course.professor
    addCourseView.roomNameLabel.text = course.roomName
    addCourseView.bottomBackground.backgroundColor = .timetableColors[colorNumber]
    addCourseView.classficationLabel.backgroundColor = .timetableColors[colorNumber]
  }
}
