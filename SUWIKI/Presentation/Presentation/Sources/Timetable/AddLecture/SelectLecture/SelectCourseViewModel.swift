//
//  AddCourseViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import Foundation

import Domain

final class SelectCourseViewModel {
  
  var course: FetchCourse
  
  init(course: FetchCourse) {
    self.course = course
  }
  
  var classification: String {
    course.classification
  }
  
  var courseDay: String {
    course.courseDay
  }
  
  var courseName: String {
    course.courseName
  }
  
  var startTime: String {
    course.startTime
  }
  
  var endTime: String {
    course.endTime
  }
  
  var major: String {
    "\(String(describing: course.major))⎪"
  }
  
  var professor: String {
    "\(String(describing: course.professor))⎪"
  }
  
  var credit: String {
    "⎪\(course.credit)학점"
  }
  
  var roomName: String {
    course.roomName
  } 
  
  var grade: String {
    "\(course.num)학년"
  }
}
