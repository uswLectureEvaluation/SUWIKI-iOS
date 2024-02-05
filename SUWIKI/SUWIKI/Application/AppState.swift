//
//  AppState.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool

    init() {
        if KeychainManager.shared.read(token: .AccessToken) != nil &&
            KeychainManager.shared.read(token: .RefreshToken) != nil {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
}
