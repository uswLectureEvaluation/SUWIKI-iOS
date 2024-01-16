//
//  TimetableWidgetModel.swift
//  TimetableWidgetExtension
//
//  Created by 한지석 on 1/16/24.
//

import Foundation

struct CourseForWidget: Identifiable, Codable {
    let id: UUID
    let professor: String
    let roomName: String
    let courseName: String
    let courseDay: Int
    let startTime: String
    let endTime: String
}
