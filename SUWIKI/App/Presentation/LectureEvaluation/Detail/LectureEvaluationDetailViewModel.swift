//
//  LectureEvaluationDetailViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

import DIContainer
import Domain

// 데이터 상태에 따른 View 분기 처리
final class LectureEvaluationDetailViewModel: ObservableObject {
    var fetchDetailLectureUseCase: FetchDetailLectureUseCase = DIContainer.shared.resolve(type: FetchDetailLectureUseCase.self)
    var fetchEvaluatePostUseCase: FetchEvaluationPostsUseCase = DIContainer.shared.resolve(type: FetchEvaluationPostsUseCase.self)
    var fetchExamPostUseCase: FetchExamPostsUseCase = DIContainer.shared.resolve(type: FetchExamPostsUseCase.self)
    var purchaseExamPostUseCase: PurchaseExamPostUseCase = DIContainer.shared.resolve(type: PurchaseExamPostUseCase.self)
    var id: Int
    @Published var requestState: RequestState = .notRequest
    @Published var postType: PostType = .evaluate
    @Published var detailLecture: DetailLecture = DetailLecture.mockdata
    @Published var evaluation: Evaluation = .init(written: false,
                                                  posts: [])
    @Published var exam: Exam = .init(posts: [],
                                      isPurchased: false,
                                      isWritten: false,
                                      isExamPostsExists: false)
    @Published var evaluatePostWriteButtonClicked = false
    @Published var examPostWriteButtonClicked = false
    @Published var isPurchaseImpossible = false
    @Published var isEvaluationWritten = false
    @Published var isExamWritten = false
    /// state enum 정의, isLoading -> isFinished 되었을 경우 view 띄워버리기

    init(id: Int) {
        self.id = id
        Task {
            do {
                let detailLecture = try await fetchDetailLectureUseCase.excute(id: id)
                let fetchEvaluation = try await fetchEvaluatePostUseCase.execute(lectureId: id, page: 1)
                let fetchExam = try await fetchExamPostUseCase.execute(id: id, page: 1)
                await MainActor.run {
                    self.detailLecture = detailLecture
                    self.evaluation = fetchEvaluation
                    self.exam = fetchExam
                    requestState = .success
                }
            } catch {
                print("@Log LectureEvaluationDetialVM Fetch - \(error.localizedDescription)")
                requestState = .failed(error)
            }
        }
    }

    func fetchExamPost() async throws {
        let fetchExam = try await fetchExamPostUseCase.execute(id: id, page: 1)
        await MainActor.run {
            self.exam = fetchExam
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
