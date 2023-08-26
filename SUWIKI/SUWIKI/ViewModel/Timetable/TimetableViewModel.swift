//
//  TimeTableViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import Foundation

import Combine
import Elliotable

final class TimetableViewModel {
    
    let coreDataManager = CoreDataManager.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var elliottEvent: [ElliottEvent] = []
    
    func bind() {
        
    }
    
//    func tempIsFinished() {
//        let addController = AddCourseViewController()
//        addController.viewModel.$isFinished
//            .receive(on: DispatchQueue.main)
//            .sink { isFinished in
//                print("@Log sink - \(isFinished)")
//                self.getCourse()
//            }
//            .store(in: &addController.cancellable)
//    }
    
    
    func getCourse() {
        let course = coreDataManager.fetchCourse()
        elliottEvent = []
        for i in 0..<course.count {
            let event = ElliottEvent(courseId: course[i].courseId ?? "",
                                     courseName: course[i].courseName ?? "",
                                     roomName: course[i].roomName ?? "",
                                     professor: course[i].professor ?? "",
                                     courseDay: ElliotDay(rawValue: Int(course[i].courseDay)) ?? .monday,
                                     startTime: course[i].startTime ?? "",
                                     endTime: course[i].endTime ?? "",
                                     backgroundColor: .timetableColors[Int(course[i].timetableColor)])
            elliottEvent.append(event)
        }
    }
    
    func deleteCourse(uuid: String) {
        guard let index = elliottEvent.firstIndex(where: { $0.courseId == uuid }) else { return }
        elliottEvent.remove(at: index)
        coreDataManager.deleteCourse(uuid: uuid)
    }
    
}
