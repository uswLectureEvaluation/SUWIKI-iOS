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
    var lectureEvaluation: LectureEvaluationHomeFeature.State = .init()
    var userInfo: UserInfoFeature.State = .init()
  }

  enum Action {
    case lectureEvaluation(LectureEvaluationHomeFeature.Action)
    case userInfo(UserInfoFeature.Action)
    case _initialize
    case _userInfoResponse(Result<UserInfo, Error>)
    case _setLoginStatus(Bool)
  }

  var body: some ReducerOf<Self> {
    Scope(state: \.lectureEvaluation, action: \.lectureEvaluation) {
      LectureEvaluationHomeFeature()
    }
    Scope(state: \.userInfo, action: \.userInfo) {
      UserInfoFeature()
    }
    Reduce { state, action in
      state.lectureEvaluation.isLoggedIn = state.isLoggedIn
      state.userInfo.isLoggedIn = state.isLoggedIn
      switch action {
      case ._initialize:
        guard
          let _ = KeychainManager.shared.read(token: .AccessToken),
          let _ = KeychainManager.shared.read(token: .RefreshToken)
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
        
      case .lectureEvaluation: return .none
      case .userInfo: return .none
      }
    }
  }
}
