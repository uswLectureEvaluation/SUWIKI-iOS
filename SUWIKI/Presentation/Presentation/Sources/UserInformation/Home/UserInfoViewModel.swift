//
//  UserInfoViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import Common
import DIContainer
import Domain

final class UserInfoViewModel: ObservableObject {
  
  @Inject var userInfoUseCase: UserInfoUseCase
  @Published var userInfo: UserInfo? = nil
  @Published var requestState: RequestState = .notRequest
  @Published var isLoginViewPresented = false
  
  init() {
    self.requestState = .isProgress
    Task {
      try await getUserInfo()
    }
  }
  
  @MainActor
  func getUserInfo() async throws {
    self.requestState = .isProgress
    do {
      self.userInfo = try await userInfoUseCase.execute()
    } catch {
      self.userInfo = nil
    }
    self.requestState = .success
  }
}
