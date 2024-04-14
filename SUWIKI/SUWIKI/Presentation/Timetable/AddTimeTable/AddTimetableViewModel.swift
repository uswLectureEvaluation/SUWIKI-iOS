//
//  AddTimetableViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import Foundation
//import Combine

final class AddTimetableViewModel {
    
    @Inject var useCase: SaveTimetableUseCase

    var semester: [String] = []
    var selectedSemester = ""
    @Published var name = ""
    
    private(set) lazy var addTimetableIsVaild = $name.map { $0.count > 0 }.eraseToAnyPublisher()
    
    init() {
        self.semester = calculateSemester()
        self.selectedSemester = semester[1]
    }
    
    func calculateSemester() -> [String] {
        let currentYear = Calendar.current.component(.year, from: Date())
        let currentMonth = Calendar.current.component(.month, from: Date())
        var semester: [String] = []
        if currentMonth <= 6 {
            semester = ["\(currentYear)년 여름학기", "\(currentYear)년 1학기", "\(currentYear - 1)년 겨울학기"]
        } else {
            semester = ["\(currentYear)년 겨울학기", "\(currentYear)년 2학기", "\(currentYear)년 여름학기"]
        }
        return semester
    }
    
    func updateSelectedSemester(with semester: String) {
        self.selectedSemester = semester
    }
    
    func addTimetable() {
        useCase.execute(name: name, semester: selectedSemester)
    }
}
