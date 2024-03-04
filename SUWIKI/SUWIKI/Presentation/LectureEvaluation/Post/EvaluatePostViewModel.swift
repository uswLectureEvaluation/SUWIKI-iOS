//
//  EvaluatePostViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation

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
    }

    func write() async throws {
        print(try await writeEvaluatePostUseCase.execute(id: self.id,
                                                         lectureName: self.lectureName,
                                                         professor: self.professor,
                                                         selectedSemester: self.selectedSemester,
                                                         satisfaction: self.satisfactionPoint,
                                                         learning: self.learningPoint,
                                                         honey: self.honeyPoint,
                                                         team: self.teamplayType.point,
                                                         difficulty: self.difficultyType.point,
                                                         homework: self.homeworkType.point,
                                                         content: self.content))
    }
}
