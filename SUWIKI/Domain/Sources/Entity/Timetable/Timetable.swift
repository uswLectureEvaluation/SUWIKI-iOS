//
//  Timetable.swift
//  Domain
//
//  Created by 한지석 on 5/2/24.
//

import Foundation

public struct Timetable {
    public let id: String
    public let name: String
    public let semester: String
    public let courses: [TimetableCourse]

    public init(
        id: String,
        name: String,
        semester: String,
        courses: [TimetableCourse]
    ) {
        self.id = id
        self.name = name
        self.semester = semester
        self.courses = courses
    }
}
