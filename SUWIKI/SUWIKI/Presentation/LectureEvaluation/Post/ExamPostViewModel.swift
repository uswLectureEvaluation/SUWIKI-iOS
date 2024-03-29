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
    let examTypeList = ["중간고사", "기말고사"]
    var cancellables = Set<AnyCancellable>()
    let id: Int
    let lectureName: String
    let professor: String
    let semesterList: [String]
    @Published var examInfos: [(ExamInfoType, Bool)] = ExamInfoType.allCases.map { ($0, false) }
    @Published var selectedSemester: String
    @Published var examInfoArray: [String] = [] // 교재 피피티
    @Published var examType: String = "중간고사" // 중간고사 or 기말고사
    @Published var examDifficulty: DifficultyType = .notSelected
    @Published var content: String = ""
    @Published var isWriteEnabled = false
    @Published var isWritten = false
    @Published var isDataEmpty = false

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

        $examDifficulty
            .combineLatest($examInfoArray, $content)
            .map { examDifficulty, examInfoArray, content in
                return examDifficulty != .notSelected && !examInfoArray.isEmpty && content.count >= 10
            }
            .filter { $0 == true }
            .receive(on: RunLoop.main)
            .sink {
                self.isWriteEnabled = $0
            }
            .store(in: &cancellables)
    }

    func settingExamInfo(type: String) {
        if examInfoArray.contains(type) {
            let removeIndex = examInfoArray.firstIndex(of: type)!
            examInfoArray.remove(at: removeIndex)
        } else {
            examInfoArray.append(type)
        }
    }

    func write() async throws {
        if isWriteEnabled {
            let examInfo = examInfoArray.joined(separator: ", ")
            if try await useCase.execute(id: self.id,
                                         lectureName: self.lectureName,
                                         professor: self.professor,
                                         selectedSemester: self.selectedSemester,
                                         examInfo: examInfo,
                                         examType: self.examType,
                                         examDifficulty: self.examDifficulty.description,
                                         content: self.content) {

            } else {
                await MainActor.run {
                    isWritten.toggle()
                }
            }
        } else {
            await MainActor.run {
                isDataEmpty.toggle()
            }
        }
    }
}
