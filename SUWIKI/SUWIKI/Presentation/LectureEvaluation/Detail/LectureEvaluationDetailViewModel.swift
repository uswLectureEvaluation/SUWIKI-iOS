//
//  LectureEvaluationDetailViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

//4591
final class LectureEvaluationDetailViewModel: ObservableObject {
    var fetchDetailLectureUseCase: FetchDetailLectureUseCase = DIContainer.shared.resolve(type: FetchDetailLectureUseCase.self)
    var fetchEvaluatePostUseCase: FetchEvaluatePostsUseCase = DIContainer.shared.resolve(type: FetchEvaluatePostsUseCase.self)
    @Published var detailLecture: DetailLecture = DetailLecture.mockdata
    @Published var evaluatePosts: [EvaluatePost] = []

    init() {
        Task {
            do {
                let detailLecture = try await fetchDetailLectureUseCase.excute(id: 3568)
                let evaluatePosts = try await fetchEvaluatePostUseCase.execute(lectureId: 3568, page: 1)
                await MainActor.run {
                    self.detailLecture = detailLecture
                    self.evaluatePosts = evaluatePosts
                    print("@Log - \(evaluatePosts)")
                }
            } catch {
                print("@Log LectureEvaluationDetialVM Fetch - \(error.localizedDescription)")
            }
        }
    }
}
