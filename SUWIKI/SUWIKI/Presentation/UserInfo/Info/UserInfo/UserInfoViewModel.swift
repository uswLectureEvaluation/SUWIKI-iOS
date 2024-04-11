//
//  UserInfoViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

final class UserInfoViewModel: ObservableObject {
    @Inject var userInfoUseCase: UserInfoUseCase
    @Published var userInfo: UserInfo? = nil
    @Published var requestState: RequestState = .notRequest

    init() {
        self.requestState = .isProgress
        Task {
            try await getUserInfo()
        }
    }

    @MainActor
    func getUserInfo() async throws {
        do {
            self.userInfo = try await userInfoUseCase.execute()
        } catch {

        }
        self.requestState = .success
    }
}
