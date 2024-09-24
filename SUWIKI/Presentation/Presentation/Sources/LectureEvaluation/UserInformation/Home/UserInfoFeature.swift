//
//  UserInfoFeature.swift
//  Presentation
//
//  Created by 한지석 on 9/24/24.
//

import ComposableArchitecture

import Common
import Domain
import DIContainer

@Reducer
struct UserInfoFeature {

  @Inject var userInfoUseCase: UserInfoUseCase

  @Reducer(state: .equatable)
  enum Destination {
    case login(LoginFeature)
  }

  @Reducer
  struct Path {
    @ObservableState
    enum State: Equatable {
      case manageAccount(ManageAccountFeature.State)
      //      case userPostView
      //      case announcementView
      //      case userPointView
    }

    enum Action {
      case manageAccount(ManageAccountFeature.Action)
      //      case userPost
      //      case announcement
      //      case userPoint
    }

    var body: some ReducerOf<Self> {
      Scope(
        state: \.manageAccount,
        action: \.manageAccount
      ) {
        ManageAccountFeature()
      }
    }
  }

  @ObservableState
  struct State: Equatable {
    var userInfo: UserInfo?
    var requestState: RequestState
    var isLoggedIn: Bool
    @Presents var destination: Destination.State?
    var path = StackState<Path.State>()

    init() {
      self.userInfo = nil
      self.requestState = .notRequest
      self.isLoggedIn = false
      self.destination = nil
    }
  }

  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case destination(PresentationAction<Destination.Action>)
    case path(StackAction<Path.State, Path.Action>)

    case viewAction(ViewAction)
    case internalAction(InternalAction)

    enum ViewAction {
      case loginButtonTapped
      case manageButtonTapped
    }

    enum InternalAction {
      case initialize
      case fetchUserInfo
      case setUserInfo(Result<UserInfo, Error>)
      case loginViewPresented
    }
  }

  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce {
      state,
      action in
      switch action {
      case .binding:
        return .none

      case let .viewAction(viewAction):
        switch viewAction {
        case .loginButtonTapped:
          return .send(.internalAction(.loginViewPresented))

        case .manageButtonTapped:
          guard let userInfo = state.userInfo else { return .none }
          state.path.append(
            .manageAccount(
              ManageAccountFeature.State(
                userInfo: userInfo,
                isLoggedIn: state.isLoggedIn
              )
            )
          )
          return .none
        }

      case let .internalAction(internalAction):
        switch internalAction {
        case .initialize:
          state.userInfo = nil
          state.requestState = .notRequest
          state.isLoggedIn = false
          return .send(.internalAction(.fetchUserInfo))

        case .fetchUserInfo:
          state.requestState = .isProgress
          return .run { send in
            do {
              let userInfo = try await userInfoUseCase.execute()
              await send(.internalAction(.setUserInfo(.success(userInfo))))
            } catch {
              await send(.internalAction(.setUserInfo(.failure(error))))
            }
          }

        case let .setUserInfo(.success(userInfo)):
          state.userInfo = userInfo
          state.requestState = .success
          return .none

        case .setUserInfo(.failure):
          state.userInfo = nil
          state.requestState = .success
          return .none

        case .loginViewPresented:
          state.destination = .login(LoginFeature.State())
          return .none
        }

      case .destination:
        return .none

      case .path:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
    .forEach(\.path, action: \.path) {
      Path()
    }
  }
}
