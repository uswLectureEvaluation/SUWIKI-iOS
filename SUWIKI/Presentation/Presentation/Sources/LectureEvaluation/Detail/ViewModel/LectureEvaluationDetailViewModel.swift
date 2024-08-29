//
//  LectureEvaluationDetailViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

import Common
import DIContainer
import Domain

final class LectureEvaluationDetailViewModel: ObservableObject {
  @Inject var fetchDetailLectureUseCase: FetchDetailLectureUseCase
  @Inject var fetchEvaluatePostUseCase: FetchEvaluationPostsUseCase
  @Inject var fetchExamPostUseCase: FetchExamPostsUseCase
  @Inject var purchaseExamPostUseCase: PurchaseExamPostUseCase
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
  var id: Int
  
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
