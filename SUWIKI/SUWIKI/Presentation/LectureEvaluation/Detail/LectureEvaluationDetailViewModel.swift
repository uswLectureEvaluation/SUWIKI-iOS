//
//  LectureEvaluationDetailViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

// 데이터 상태에 따른 View 분기 처리
final class LectureEvaluationDetailViewModel: ObservableObject {
    var fetchDetailLectureUseCase: FetchDetailLectureUseCase = DIContainer.shared.resolve(type: FetchDetailLectureUseCase.self)
    var fetchEvaluatePostUseCase: FetchEvaluatePostsUseCase = DIContainer.shared.resolve(type: FetchEvaluatePostsUseCase.self)
    var fetchExamPostUseCase: FetchExamPostsUseCase = DIContainer.shared.resolve(type: FetchExamPostsUseCase.self)
    var purchaseExamPostUseCase: PurchaseExamPostUseCase = DIContainer.shared.resolve(type: PurchaseExamPostUseCase.self)
    var id: Int
    @Published var requestState: RequestState = .notRequest
    @Published var postType: PostType = .evaluate
    @Published var detailLecture: DetailLecture = DetailLecture.mockdata
    @Published var evaluatePosts: [EvaluatePost] = []
    @Published var examPosts: [ExamPost] = []
    @Published var examPostInfo: ExamPostInfo = .init(posts: [], 
                                                      isPurchased: false,
                                                      isWritten: false,
                                                      isExamPostsExists: false)
    @Published var evaluatePostWriteButtonClicked = false
    @Published var examPostWriteButtonClicked = false
    @Published var isPurchaseImpossible = false
    /// state enum 정의, isLoading -> isFinished 되었을 경우 view 띄워버리기

    init(id: Int) {
        self.id = id
        Task {
            do {
                let detailLecture = try await fetchDetailLectureUseCase.excute(id: id)
                let evaluatePosts = try await fetchEvaluatePostUseCase.execute(lectureId: id, page: 1)
                let examPostInfo = try await fetchExamPostUseCase.execute(id: id, page: 1)
                await MainActor.run {
                    self.detailLecture = detailLecture
                    self.evaluatePosts = evaluatePosts
                    self.examPosts = examPostInfo.posts
                    self.examPostInfo = examPostInfo
                    requestState = .success
                }
            } catch {
                print("@Log LectureEvaluationDetialVM Fetch - \(error.localizedDescription)")
                requestState = .failed(error)
            }
        }
    }

    func fetchExamPost() async throws {
        let examPostInfo = try await fetchExamPostUseCase.execute(id: id, page: 1)
        await MainActor.run {
            self.examPosts = examPostInfo.posts
            self.examPostInfo = examPostInfo
        }
    }

    func purchase() async throws {
        let success = try await purchaseExamPostUseCase.execute(id: self.id)
        if success {
            try await fetchExamPost()
        } else {
            isPurchaseImpossible.toggle()
        }
    }
}
