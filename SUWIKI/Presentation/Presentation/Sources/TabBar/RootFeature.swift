//
//  RootFeature.swift
//  Presentation
//
//  Created by 한지석 on 9/6/24.
//

import Domain

import DIContainer
import Keychain

import ComposableArchitecture

@Reducer
struct RootFeature {

  @Inject var userRepository: UserRepository

  @ObservableState
  struct State: Equatable {
    var isLoggedIn: Bool = false
  }

  enum Action {
    case _initialize
    case _userInfoResponse(Result<UserInfo, Error>)
    case _setLoginStatus(Bool)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case ._initialize:
        guard
          let accessToken = KeychainManager.shared.read(token: .AccessToken),
          let refreshToken = KeychainManager.shared.read(token: .RefreshToken)
        else {
          return .send(._setLoginStatus(false))
        }

        return .run { send in
          do {
            let userInfo = try await userRepository.userInfo()
            await send(._userInfoResponse(.success(userInfo)))
          } catch {
            await send(._userInfoResponse(.failure(error)))
          }
        }

      case ._userInfoResponse(.success):
        return .send(._setLoginStatus(true))

      case ._userInfoResponse(.failure):
        return .send(._setLoginStatus(false))

      case let ._setLoginStatus(status):
        state.isLoggedIn = status
        return .none
      }
    }
  }
}
