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
    var isMajorViewPresented: Bool
    var isLoginViewPresented: Bool

    init() {
      self.lectures = []
      self.option = .modifiedDate
      self.fetchLectures = []
      self.fetchPage = 1
      self.searchPage = 1
      self.major = "전체"
      self.searchText = ""
      self.isMajorViewPresented = false
      self.isLoginViewPresented = false
    }
  }
  
  enum Action {
    case searchButtonTapped
    case majorButtonTapped
    case lectureTapped
    case listScroll
    case searchTextChanged(String)
    case optionChanged(LectureOption)
    case refresh

    case _initialize
    case _fetchLectures
    case _fetchSearchLectures
    case _updateLectures
    
    case _setLectures([Lecture])
    case _appendLectures([Lecture])
    case _setMajor(String)
    case _majorViewDismiss(Bool)
    case _loginViewDismiss(Bool)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .searchButtonTapped:
        state.searchPage = 1
        return .send(._fetchSearchLectures)

      case .listScroll: return .none

      case let .searchTextChanged(searchText):
        state.searchText = searchText
        if searchText.isEmpty {
          state.lectures = state.fetchLectures
        }
        return .none

      case .majorButtonTapped:
        state.isMajorViewPresented = true
        return .none

      case .lectureTapped:
        return .none

      case let .optionChanged(option):
        state.option = option
        state.fetchPage = 1
        state.searchPage = 1
        return .send(._fetchLectures)

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
        return .send(._fetchLectures)

      case let ._majorViewDismiss(isPresented):
        state.isMajorViewPresented = isPresented
        return .none

      case ._loginViewDismiss:
        state.isLoginViewPresented = false
        return .none
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
