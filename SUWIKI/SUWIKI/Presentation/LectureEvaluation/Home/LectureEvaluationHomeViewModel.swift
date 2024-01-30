//
//  LectureEvaluationHomeViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

//"modifiedDate",
//"lectureSatisfactionAvg",
//"lectureHoneyAvg",
//"lectureLearningAvg",
//"lectureTotalAvg"
//@StateObject var viewModel = LectureEvaluationHomeViewModel()
//@State var index: Int = 0

final class LectureEvaluationHomeViewModel: ObservableObject {

    var useCase: FetchLectureUseCase = DIContainer.shared.resolve(type: FetchLectureUseCase.self)

    @Published var lecture: [Lecture] = []
    @Published var option: LectureOption = .modifiedDate
    @Published var page: Int = 1
    @Published var major: String? = nil

    init() {
        Task {
            try await fetch()
        }
    }

    func fetch() async throws {
        do {
            let fetchLecture = try await useCase.fetch(option: option,
                                                       page: page,
                                                       major: major)
            DispatchQueue.main.async {
                self.lecture += fetchLecture
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
