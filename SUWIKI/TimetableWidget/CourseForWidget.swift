//
//  TimetableWidgetModel.swift
//  TimetableWidgetExtension
//
//  Created by 한지석 on 1/16/24.
//

import Foundation

struct CourseForWidget: Codable {
    let id: UUID
    let professor: String
    let roomName: String
    let courseName: String
    let courseDay: String
    let startTime: String
    let endTime: String
}
