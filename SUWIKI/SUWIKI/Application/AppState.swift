//
//  AppState.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Inject var repository: UserRepository
    init() {
        if KeychainManager.shared.read(token: .AccessToken) != nil &&
            KeychainManager.shared.read(token: .RefreshToken) != nil {
            Task {
                do {
                    let _ = try await repository.userInfo()
                    self.isLoggedIn = true
                } catch {
                    KeychainManager.shared.delete(token: .AccessToken)
                    KeychainManager.shared.delete(token: .RefreshToken)
                }
            }
        }
    }
}
