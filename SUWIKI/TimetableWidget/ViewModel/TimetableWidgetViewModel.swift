//
//  TimetableWidgetViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 1/16/24.
//

import Foundation

enum WidgetType {
    case systemSmall
    case systemMedium
}

final class TimetableWidgetViewModel: ObservableObject {
    
    var courses: [CourseForWidget] = []
    var eLearning: [CourseForWidget] = []
    @Published var date = ""
    @Published var weekday = ""
    
    init() {
        let id = UserDefaults.shared.value(forKey: "id") as? String
        Task {
            let coreDataCourses = try CoreDataManager.shared.fetchCourses(id: id ?? "") ?? []
            let weekday = Calendar.current.component(.weekday, from: Date())
            if weekday != 1 || weekday != 7 {
                self.courses = coreDataCourses.filter {
                    $0.courseDay == Calendar.current.component(.weekday, from: Date()) - 1
                }.map {
                    CourseForWidget(id: UUID(),
                                    professor: $0.professor ?? "미정",
                                    roomName: $0.roomName ?? "미정",
                                    courseName: $0.courseName ?? "미정",
                                    courseDay: Int($0.courseDay),
                                    startTime: $0.startTime ?? "미정",
                                    endTime: $0.endTime ?? "미정",
                                    color: Int($0.timetableColor))
                }.sorted { pre, next in
                    let preTime = pre.startTime.split(separator: ":").map { Int(String($0))! }.first!
                    let nextTime = next.startTime.split(separator: ":").map { Int(String($0))! }.first!
                    if preTime < nextTime {
                        return true
                    } else {
                        return false
                    }
                }
            } else {
                self.courses = []
            }
            self.eLearning = coreDataCourses.filter {
                $0.courseDay == 6
            }.map {
                CourseForWidget(id: UUID(),
                                professor: $0.professor ?? "미정",
                                roomName: $0.roomName ?? "미정",
                                courseName: $0.courseName ?? "미정",
                                courseDay: Int($0.courseDay),
                                startTime: $0.startTime ?? "미정",
                                endTime: $0.endTime ?? "미정",
                                color: Int($0.timetableColor))
            }
            self.getDateAndDay()
        }
    }
    
    func getDateAndDay() {
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        let weekday = calendar.component(.weekday, from: date)
        self.date = dateFormatter.string(from: date)
        self.weekday = self.dayToString(weekDay: weekday)
    }
    
    private func dayToString(weekDay: Int) -> String {
        switch weekDay {
        case 1: "일"
        case 2: "월"
        case 3: "화"
        case 4: "수"
        case 5: "목"
        case 6: "금"
        case 7: "토"
        default: "요일 불러오기에 실패했어요!"
        }
    }
    
    
    
}
