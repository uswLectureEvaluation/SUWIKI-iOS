//
//  UserPostViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

import Common
import DIContainer
import Domain

final class UserPostViewModel: ObservableObject {
  
  @Inject var fetchEvaluationUseCase: FetchUserEvaluationPostsUseCase
  @Inject var fetchExamUseCase: FetchUserExamPostsUseCase
  
  @Published var postType: PostType = .evaluate
  @Published var userEvaluationPosts: [UserEvaluationPost] = []
  @Published var userExamPosts: [UserExamPost] = []
  @Published var selectedEvaluationPost: UserEvaluationPost? = nil
  @Published var selectedExamPost: UserExamPost? = nil
  @Published var requestState: RequestState = .notRequest
  @Published var isEvaluationPostModifyClicked = false
  @Published var isExamPostModifyClicked = false
  
  init() {
    self.requestState = .isProgress
    Task {
      let evaluationPosts = try await fetchEvaluationUseCase.execute()
      let examPosts = try await fetchExamUseCase.execute()
      await MainActor.run {
        self.userEvaluationPosts = evaluationPosts
        self.userExamPosts = examPosts
        self.requestState = .success
      }
    }
  }
}
