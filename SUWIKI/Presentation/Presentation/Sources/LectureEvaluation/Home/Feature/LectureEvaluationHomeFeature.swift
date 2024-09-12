//
//  LectureEvaluationHomeFeature.swift
//  Presentation
//
//  Created by 한지석 on 9/4/24.
//

import Domain
import DIContainer

import ComposableArchitecture

@Reducer
struct LectureEvaluationHomeFeature {
  @Inject var fetchUseCase: FetchLectureUseCase
  @Inject var searchUseCase: SearchLectureUseCase

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

    init() {
      self.lectures = []
      self.option = .modifiedDate
      self.fetchLectures = []
      self.fetchPage = 1
      self.searchPage = 1
      self.major = "전체"
      self.searchText = ""
      self.isLoggedIn = false
    }
  }

  enum Action: BindableAction {
    case binding(BindingAction<State>)

    case searchButtonTapped
    case majorButtonTapped
    case lectureTapped
    case listScroll
    case searchTextChanged(String)
    case optionChanged(LectureOption)
    case majorSelected(String)
    case showLoginView
    case refresh

    case _initialize
    case _fetchLectures
    case _fetchSearchLectures
    case _updateLectures

    case _setLectures([Lecture])
    case _appendLectures([Lecture])
    case _setMajor(String)
  }

  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .searchButtonTapped:
        state.searchText = ""
        return .none

      case .listScroll: return .none

      case let .searchTextChanged(searchText):
        state.searchText = searchText
        if searchText.isEmpty {
          state.lectures = state.fetchLectures
        }
        return .none

      case .majorButtonTapped:
//        state.destination = .selectMajor(LectureEvaluationMajorSelectFeature.State())
        return .none

      case .lectureTapped:
        return .none

      case let .optionChanged(option):
        state.option = option
        state.fetchPage = 1
        state.searchPage = 1
        return .send(._fetchLectures)

      case let .majorSelected(major):
        state.major = major
//        state.destination = nil
        return .send(._fetchLectures)

      case .showLoginView:
//        state.destination = .login(LoginFeature.State())
        return .none

      case .refresh:
        state.fetchPage = 1
        state.searchPage = 1
        return .send(._fetchLectures)

      case ._initialize:
        state.lectures = []
        state.option = .modifiedDate
        state.fetchLectures = []
        state.fetchPage = 1
        state.searchPage = 1
        state.major = "전체"
        state.searchText = ""
        return .send(._fetchLectures)

      case ._fetchLectures:
        return fetch(state)

      case ._fetchSearchLectures:
        return search(state)

      case ._updateLectures:
        if state.searchText.isEmpty {
          state.fetchPage += 1
          return fetch(state)
        } else {
          state.searchPage += 1
          return search(state)
        }

      case let ._setLectures(lectures):
        if state.searchText.isEmpty {
          state.fetchLectures = lectures
        }
        state.lectures = state.searchText.isEmpty ? state.fetchLectures : lectures
        return .none

      case let ._appendLectures(lectures):
        if state.searchText.isEmpty {
          state.fetchLectures.append(contentsOf: lectures)
        }
        state.lectures.append(contentsOf: lectures)
        return .none

      case let ._setMajor(major):
        state.major = major
        state.fetchPage = 1
        state.searchPage = 1
//        state.destination = nil
        return .send(._fetchLectures)
      }
    }
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
      await send(state.fetchPage == 1 ? ._setLectures(lectures) : ._appendLectures(lectures))
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
      await send(state.searchPage == 1 ? ._setLectures(lectures) : ._appendLectures(lectures))
    }
  }
}

extension LectureEvaluationHomeFeature {
  @Reducer(state: .equatable)
  enum Destination {
    case login(LoginFeature)
    case selectMajor(LectureEvaluationMajorSelectFeature)
  }
}

//      case let ._majorViewDismiss(isPresented):
//        return .none
//
//      case let ._loginViewDismiss(isPresented):
//        return .none

//      case let .destination(.presented(.login(._loginResponse(.success(isLoggedIn))))):
//        state.isLoggedIn = isLoggedIn
//        if isLoggedIn {
//          state.destination = nil
//        }
//        return .none
//
//      case let .destination(.presented(.selectMajor(.majorSelected(major)))):
//        return .send(._setMajor(major))
//
//      case let .destination(.dismiss):
//        state.destination = nil
//        return .none
//
//      case .destination:
//        return .none
