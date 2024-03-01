//
//  LectureEvaluationDetailViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

enum PostType {
    case evaluate
    case exam
}
//4591
final class LectureEvaluationDetailViewModel: ObservableObject {
    var fetchDetailLectureUseCase: FetchDetailLectureUseCase = DIContainer.shared.resolve(type: FetchDetailLectureUseCase.self)
    var fetchEvaluatePostUseCase: FetchEvaluatePostsUseCase = DIContainer.shared.resolve(type: FetchEvaluatePostsUseCase.self)
    var id: Int
    @Published var postType: PostType = .evaluate
    @Published var detailLecture: DetailLecture = DetailLecture.mockdata
    @Published var evaluatePosts: [EvaluatePost] = EvaluatePost.mockData

    init(id: Int) {
        self.id = id
        Task {
            do {
                let detailLecture = try await fetchDetailLectureUseCase.excute(id: id)
                let evaluatePosts = try await fetchEvaluatePostUseCase.execute(lectureId: id, page: 1)
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
