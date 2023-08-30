//
//  AddTimetableViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import Foundation
import Combine

final class AddTimetableViewModel {
    
    @Published var name = ""
    var semester: [String] = []
    var selectedSemester = ""
    
    private(set) lazy var addTimetableIsVaild = $name.map { $0.count > 0 }.eraseToAnyPublisher()
    
    init() {
        self.semester = calculateSemester()
        self.selectedSemester = semester[1]
    }
    
    //TODO: 학기 계산 알고리즘
//    func addTimetableIsVaild() {
//
//    }
    
    func calculateSemester() -> [String] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        var semester: [String] = []
        if currentMonth <= 6 {
            semester = ["\(currentYear) 여름학기", "\(currentYear) 1학기", "\(currentYear - 1) 겨울학기"]
        } else {
            semester = ["\(currentYear) 겨울학기", "\(currentYear) 2학기", "\(currentYear) 여름학기"]
        }
        return semester
    }
    
    func updateSelectedSemester(with semester: String) {
        self.selectedSemester = semester
    }
    
}
