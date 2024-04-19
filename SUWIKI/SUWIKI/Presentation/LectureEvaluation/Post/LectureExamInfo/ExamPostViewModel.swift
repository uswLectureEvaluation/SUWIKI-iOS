//
//  ExamPostViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 3/28/24.
//

import Foundation
import Combine

import DIContainer

final class ExamPostViewModel: ObservableObject {

    @Inject var writeExamPostUseCase: WriteExamPostUseCase
    @Inject var updateExamPostUseCase: UpdateExamPostUseCase

    let examTypeList = ["중간고사", "기말고사"]
    var cancellables = Set<AnyCancellable>()
    let id: Int
    let lectureName: String
    let professor: String
    let semesterList: [String]
    let isModified: Bool
    @Published var examInfos: [(ExamInfoType, Bool)] = ExamInfoType.allCases.map { ($0, false) }
    @Published var selectedSemester: String
    @Published var examInfoArray: [String] = [] // 교재 피피티
    @Published var examType: String // 중간고사 or 기말고사
    @Published var examDifficulty: DifficultyType
    @Published var content: String = ""
    @Published var isWriteEnabled = false
    @Published var isWritten = false
    @Published var isDataEmpty = false

    init(
        id: Int,
        lectureName: String,
        professor: String,
        semester: String,
        isModified: Bool = false,
        examInfo: String = "",
        examType: String = "중간고사",
        examDifficulty: DifficultyType = .notSelected,
        content: String = ""
    ) {
        self.id = id
        self.lectureName = lectureName
        self.professor = professor
        let splitedSemester = semester.split(separator: ", ").map { String($0) }
        self.semesterList = splitedSemester
        self.selectedSemester = splitedSemester[0]
        self.isModified = isModified
        self.examType = examType
        self.examDifficulty = examDifficulty
        self.content = content
        self.examInfoArray = examInfo.split(separator: ", ").map { String($0) }
        examInfoArray.forEach { item in
            if let index = examInfos.firstIndex(where: { $0.0.description == item }) {
                examInfos[index].1.toggle()
            }
        }

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

    func write() async throws -> Bool {
        if isWriteEnabled {
            let examInfo = examInfoArray.joined(separator: ", ")
            if try await writeExamPostUseCase.execute(id: self.id,
                                                      lectureName: self.lectureName,
                                                      professor: self.professor,
                                                      selectedSemester: self.selectedSemester,
                                                      examInfo: examInfo,
                                                      examType: self.examType,
                                                      examDifficulty: self.examDifficulty.description,
                                                      content: self.content) {
                return true
            } else {
                await MainActor.run {
                    isWritten.toggle()
                }
                return false
            }
        } else {
            await MainActor.run {
                isDataEmpty.toggle()
            }
            return false
        }
    }

    func update() async throws -> Bool {
        if isWriteEnabled {
            let examInfo = examInfoArray.joined(separator: ", ")
            if try await updateExamPostUseCase.execute(id: self.id,
                                                       selectedSemester: self.selectedSemester,
                                                       examInfo: examInfo,
                                                       examType: self.examType,
                                                       examDifficulty: self.examDifficulty.description,
                                                       content: self.content) {
                return true
            } else {
                return false
            }
        } else {
            await MainActor.run {
                isDataEmpty.toggle()
            }
            return false
        }
    }
}
