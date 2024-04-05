//
//  EvaluatePostViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation
import Combine

final class EvaluationPostViewModel: ObservableObject {

    var writeEvaluationPostUseCase: WriteEvaluationPostUseCase = DIContainer.shared.resolve(type: WriteEvaluationPostUseCase.self)
    @Inject var updateEvaluationPostUseCase: UpdateEvaluationPostUseCase
    var id: Int
    var lectureName: String
    var professor: String
    var isModified: Bool
    @Published var semesterList: [String]
    @Published var selectedSemester: String
    @Published var honeyPoint: Double
    @Published var learningPoint: Double
    @Published var satisfactionPoint: Double
    @Published var difficultyType: DifficultyType
    @Published var homeworkType: HomeworkType
    @Published var teamplayType: TeamplayType
    @Published var content: String
    @Published var averagePoint: Double
    @Published var isWriteEnabled = false
    @Published var isDataEmpty = false
    @Published var isWritten = false
    var cancellables = Set<AnyCancellable>()

    init(
        id: Int,
        lectureName: String,
        professor: String,
        semester: String,
        isModified: Bool = false,
        honeyPoint: Double = 2.5,
        learningPoint: Double = 2.5,
        satisfactionPoint: Double = 2.5,
        difficultyType: DifficultyType = .notSelected,
        homeworkType: HomeworkType = .notSelected,
        teamplayType: TeamplayType = .notSelected,
        content: String = "",
        averagePoint: Double = 2.5
    ) {
        self.id = id
        self.lectureName = lectureName
        self.professor = professor
        let splitedSemester = semester.split(separator: ", ").map { String($0) }
        self.semesterList = splitedSemester
        self.selectedSemester = splitedSemester[0]
        self.isModified = isModified
        self.honeyPoint = honeyPoint
        self.learningPoint = learningPoint
        self.satisfactionPoint = satisfactionPoint
        self.difficultyType = difficultyType
        self.homeworkType = homeworkType
        self.teamplayType = teamplayType
        self.content = content
        self.averagePoint = averagePoint

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
            .receive(on: RunLoop.main)
            .sink {
                self.isWriteEnabled = $0
            }
            .store(in: &cancellables)
    }

    func write() async throws -> Bool {
        if isWriteEnabled {
            if try await writeEvaluationPostUseCase.execute(id: self.id,
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
            if try await updateEvaluationPostUseCase.execute(id: self.id,
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

    func setAveragePoint() {
        self.averagePoint = (honeyPoint + learningPoint + satisfactionPoint) / 3
    }
}
