//
//  ManageAccountViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/11/24.
//

import Foundation

import Domain
import Keychain

final class ManageAccountViewModel: ObservableObject {

    @Published var isLogoutButtonTapped = false

    let userInfo: UserInfo

    init(userInfo: UserInfo) {
        self.userInfo = userInfo
    }

    func logout() {
        KeychainManager.shared.delete(token: .AccessToken)
        KeychainManager.shared.delete(token: .RefreshToken)
    }

}
