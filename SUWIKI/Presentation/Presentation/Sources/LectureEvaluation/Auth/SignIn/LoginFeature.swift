//
//  LoginFeature.swift
//  Presentation
//
//  Created by 한지석 on 9/9/24.
//

import Domain
import DIContainer

import ComposableArchitecture

@Reducer
struct LoginFeature {

  @Inject var useCase: SignInUseCase

  @ObservableState
  struct State: Equatable {
    var id: String
    var password: String
    var isPasswordVisible: Bool
    var isLoginInProgress: Bool
    var isInvalid: Bool
    var isButtonDisabled: Bool {
      id.count < 6 || id.count > 20 || password.count < 8 || password.count > 20
    }
  }

  enum Action {
    case idChanged(String)
    case idClearButtonTapped
    case passwordChanged(String)
    case passwordClearButtonTapped
    case togglePasswordVisibility
    case loginButtonTapped

    case _loginResponse(Result<Bool, Error>)
    case _setInvalid(Bool)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .idChanged(id):
        state.id = id
        state.isInvalid = false
        return .none

      case .idClearButtonTapped:
        state.id = ""
        state.isInvalid = true
        return .none

      case let .passwordChanged(password):
        state.password = password
        state.isInvalid = false
        return .none

      case .passwordClearButtonTapped:
        state.password = ""
        state.isInvalid = true
        return .none

      case .togglePasswordVisibility:
        state.isPasswordVisible.toggle()
        return .none
        
      case .loginButtonTapped:
        state.isLoginInProgress = true
        return .run { [id = state.id, password = state.password] send in
          let response = try await useCase.excute(
            id: id,
            password: password
          )
          await send(._loginResponse(.success(response)))
        }

      case let ._loginResponse(.success(isLoggedIn)):
        state.isLoginInProgress = false
        if !isLoggedIn {
          return .send(._setInvalid(true))
        }
        return .none

      case ._loginResponse(.failure):
        state.isLoginInProgress = false
        return .send(._setInvalid(true))

      case let ._setInvalid(isInvalid):
        state.isInvalid = isInvalid
        return .none
      }
    }
  }
}
