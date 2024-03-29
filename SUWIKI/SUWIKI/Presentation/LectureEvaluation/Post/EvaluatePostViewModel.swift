//
//  EvaluatePostViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation
import Combine

final class EvaluatePostViewModel: ObservableObject {

    var writeEvaluatePostUseCase: WriteEvaluatePostUseCase = DIContainer.shared.resolve(type: WriteEvaluatePostUseCase.self)
    var id: Int
    var lectureName: String
    var professor: String
    @Published var semesterList: [String]
    @Published var selectedSemester: String
    @Published var honeyPoint: Double = 2.5
    @Published var learningPoint: Double = 2.5
    @Published var satisfactionPoint: Double = 2.5
    @Published var difficultyType: DifficultyType = .notSelected
    @Published var homeworkType: HomeworkType = .notSelected
    @Published var teamplayType: TeamplayType = .notSelected
    @Published var content: String = ""
    @Published var averagePoint: Double = 2.5
    @Published var isWriteEnabled = false
    var cancellables = Set<AnyCancellable>()

    init(
        id: Int,
        lectureName: String,
        professor: String,
        semester: String
    ) {
        self.id = id
        self.lectureName = lectureName
        self.professor = professor
        let splitedSemester = semester.split(separator: ", ").map { String($0) }
        self.semesterList = splitedSemester
        self.selectedSemester = splitedSemester[0]

        $honeyPoint
            .combineLatest($learningPoint, $satisfactionPoint)
            .sink { _ in
                self.setAveragePoint()
            }
            .store(in: &cancellables)

        $difficultyType
            .combineLatest($homeworkType, $teamplayType, $content)
            .map { difficultyType, homeworkType, teamplayType, content in
                return difficultyType != .notSelected && homeworkType != .notSelected && teamplayType != .notSelected && !content.isEmpty
            }
            .filter { $0 == true }
            .sink {
                self.isWriteEnabled = $0
            }
            .store(in: &cancellables)
    }

    func write() async throws {
        if isWriteEnabled {
            if try await writeEvaluatePostUseCase.execute(id: self.id,
                                                              lectureName: self.lectureName,
                                                              professor: self.professor,
                                                              selectedSemester: self.selectedSemester,
                                                              satisfaction: self.satisfactionPoint,
                                                              learning: self.learningPoint,
                                                              honey: self.honeyPoint,
                                                              team: self.teamplayType.point,
                                                              difficulty: self.difficultyType.point,
                                                              homework: self.homeworkType.point,
                                                              content: self.content) {
                    // dismiss
                } else {
                    // 이미 글 작성함
                }
        } else {
            print("데이터 누락")
        }
    }

    func setAveragePoint() {
        self.averagePoint = (honeyPoint + learningPoint + satisfactionPoint) / 3
    }
}
