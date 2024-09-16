//
//  LectureEvaluationHomeFeature.swift
//  Presentation
//
//  Created by 한지석 on 9/4/24.
//

import Foundation

import Domain
import DIContainer

import ComposableArchitecture

@Reducer
struct LectureEvaluationHomeFeature {
  @Inject var fetchUseCase: FetchLectureUseCase
  @Inject var searchUseCase: SearchLectureUseCase

  @Reducer(state: .equatable)
  enum Destination {
    case login(LoginFeature)
    case selectMajor(LectureEvaluationMajorSelectFeature)
  }

  @ObservableState
  struct State: Equatable {
    var lectures: [Lecture]
    var option: LectureOption
    var fetchLectures: [Lecture]
    var fetchPage: Int
    var searchPage: Int
    var major: String
    var searchText: String
    var isLoggedIn: Bool
    @Presents var destination: Destination.State?

    init() {
      self.lectures = []
      self.option = .modifiedDate
      self.fetchLectures = []
      self.fetchPage = 1
      self.searchPage = 1
      self.major = "전체"
      self.searchText = ""
      self.isLoggedIn = false
      self.destination = nil
    }
  }

  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case destination(PresentationAction<Destination.Action>)

    case viewAction(ViewAction)
    case internalAction(InternalAction)

    enum ViewAction {
      case searchButtonTapped
      case lectureTapped
      case listScroll
      case searchTextChanged(String)
      case optionChanged(LectureOption)
      case majorSelected(String)
      case refresh
      case loginViewPresented
      case majorViewPresented
    }

    enum InternalAction {
      case initialize
      case fetchLectures
      case fetchSearchLectures
      case updateLectures
      case setLectures([Lecture])
      case appendLectures([Lecture])
      case setMajor(String)
    }
  }

  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case let .viewAction(viewAction):
        switch viewAction {
        case .searchButtonTapped:
          return .none

        case .lectureTapped:
          return .none

        case .listScroll:
          return .none

        case let .searchTextChanged(searchText):
          state.searchText = searchText
          if searchText.isEmpty {
            state.lectures = state.fetchLectures
          }
          return .none

        case let .optionChanged(option):
          state.option = option
          state.fetchPage = 1
          state.searchPage = 1
          return .none

        case let .majorSelected(major):
          state.major = major
          state.destination = nil
          return .send(.internalAction(.fetchLectures))

        case .refresh:
          return .none

        case .loginViewPresented:
          state.destination = .login(LoginFeature.State())
          return .none

        case .majorViewPresented:
          state.destination = .selectMajor(LectureEvaluationMajorSelectFeature.State())
          return .none
        }

      case let .internalAction(internalAction):
        switch internalAction {
        case .initialize:
          state.lectures = []
          state.option = .modifiedDate
          state.fetchLectures = []
          state.fetchPage = 1
          state.searchPage = 1
          state.major = "전체"
          state.searchText = ""
          return .send(.internalAction(.fetchLectures))

        case .fetchLectures:
          return fetch(state)

        case .fetchSearchLectures:
          return search(state)

        case .updateLectures:
          if state.searchText.isEmpty {
            state.fetchPage += 1
            return fetch(state)
          } else {
            state.searchPage += 1
            return search(state)
          }

        case let .setLectures(lectures):
          if state.searchText.isEmpty {
            state.fetchLectures = lectures
          }
          state.lectures = state.searchText.isEmpty ? state.fetchLectures : lectures
          return .none

        case let .appendLectures(lectures):
          if state.searchText.isEmpty {
            state.fetchLectures.append(contentsOf: lectures)
          }
          state.lectures.append(contentsOf: lectures)
          return .none

        case let .setMajor(major):
          state.major = major
          state.fetchPage = 1
          state.searchPage = 1
          state.destination = nil
          return .send(.internalAction(.fetchLectures))
        }

      case let .destination(.presented(.login(._loginResponse(.success(isLoggedIn))))):
        state.isLoggedIn = isLoggedIn
        if isLoggedIn {
          state.destination = nil
        }
        return .none

      case let .destination(.presented(.selectMajor(.majorSelected(major)))):
        return .send(.internalAction(.setMajor(major)))

      case .destination(.dismiss):
        state.destination = nil
        return .none

      case .destination:
        return .none
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }
}

extension LectureEvaluationHomeFeature {
  func update(_ state: Self.State) -> Effect<Self.Action> {
    return fetch(state)
  }

  func fetch(_ state: Self.State) -> Effect<Self.Action> {
    return .run { send in
      let lectures = try await fetchUseCase.excute(
        option: state.option,
        page: state.fetchPage,
        major: state.major
      )
      await send(state.fetchPage == 1 ? .internalAction(.setLectures(lectures)) : .internalAction(.appendLectures(lectures)))
    }
  }

  func search(_ state: Self.State) -> Effect<Self.Action> {
    return .run { send in
      let lectures = try await searchUseCase.excute(
        searchText: state.searchText,
        option: state.option,
        page: state.searchPage,
        major: state.major
      )
      await send(state.searchPage == 1 ? .internalAction(.setLectures(lectures)) : .internalAction(.appendLectures(lectures)))
    }
  }
}
