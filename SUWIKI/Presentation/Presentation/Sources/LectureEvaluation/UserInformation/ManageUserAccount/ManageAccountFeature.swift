//
//  ManageAccountFeature.swift
//  Presentation
//
//  Created by 한지석 on 9/24/24.
//

import ComposableArchitecture

import Domain
import Keychain

@Reducer
struct ManageAccountFeature {

  @ObservableState
  struct State: Equatable {
    var userInfo: UserInfo
    var isLoggedIn: Bool
    @Presents var alert: AlertState<Action.Alert>?

    init(
      userInfo: UserInfo,
      isLoggedIn: Bool
    ) {
      self.userInfo = userInfo
      self.isLoggedIn = isLoggedIn
      self.alert = nil
    }
  }

  enum Action {
    case alert(PresentationAction<Alert>)
    case logoutButtonTapped
    case logout

    @CasePathable
    enum Alert: Equatable {
      case logout
    }
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .logoutButtonTapped:
        state.alert = AlertState {
          TextState("로그아웃")
        } actions: {
          ButtonState(role: .destructive, action: .logout) {
            TextState("확인")
          }
          ButtonState(role: .cancel) {
            TextState("취소")
          }
        } message: {
          TextState("정말로 로그아웃 하시겠습니까?")
        }
        return .none

      case .logout:
        KeychainManager.shared.delete(token: .AccessToken)
        KeychainManager.shared.delete(token: .RefreshToken)
        return .none

      case .alert(.presented(.logout)):
        return .send(.logout)

      case .alert:
        return .none
      }
    }
  }
}
