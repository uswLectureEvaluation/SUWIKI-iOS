//
//  ExamPostViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 3/28/24.
//

import Foundation
import Combine

final class ExamPostViewModel: ObservableObject {

    var useCase: WriteExamPostUseCase = DIContainer.shared.resolve(type: WriteExamPostUseCase.self)
    let id: Int
    let lectureName: String
    let professor: String
    let semesterList: [String]
    let examTypeList = ["중간고사", "기말고사"]
    @Published var examInfos: [(ExamInfoType, Bool)] = ExamInfoType.allCases.map { ($0, false) }
    @Published var selectedSemester: String
    @Published var examInfo: [String] = [] // 교재 피피티
    @Published var examType: String = "중간고사" // 중간고사 or 기말고사
    @Published var examDifficulty: DifficultyType = .notSelected
    @Published var content: String = ""

    init(
        id: Int,
        lectureName: String,
        professor: String,
        semester: String)
    {
        self.id = id
        self.lectureName = lectureName
        self.professor = professor
        let splitedSemester = semester.split(separator: ", ").map { String($0) }
        self.semesterList = splitedSemester
        self.selectedSemester = splitedSemester[0]

        $difficultyType
            .combineLatest($homeworkType, $teamplayType, $content)
            .map { difficultyType, homeworkType, teamplayType, content in
                return difficultyType != .notSelected && homeworkType != .notSelected && teamplayType != .notSelected && !content.isEmpty
            }
            .filter { $0 == true }
            .receive(on: RunLoop.main)
            .sink {
                self.isWriteEnabled = $0
            }
            .store(in: &cancellables)
    }

    func settingExamInfo(type: String) {
        if examInfo.contains(type) {
            let removeIndex = examInfo.firstIndex(of: type)!
            examInfo.remove(at: removeIndex)
        } else {
            examInfo.append(type)
        }
    }

    func write() async throws {
        try await useCase.execute(id: self.id,
                                  lectureName: self.lectureName,
                                  professor: self.professor,
                                  selectedSemester: self.selectedSemester,
                                  examInfo: "",
                                  examType: self.examType,
                                  examDifficulty: self.examDifficulty.description,
                                  content: self.content)
    }
}
