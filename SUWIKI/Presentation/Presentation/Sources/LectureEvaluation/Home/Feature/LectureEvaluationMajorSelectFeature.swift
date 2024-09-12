//
//  LectureEvaluationMajorSelectFeature.swift
//  Presentation
//
//  Created by 한지석 on 9/11/24.
//

import ComposableArchitecture

import Common
import DIContainer
import Domain

@Reducer
struct LectureEvaluationMajorSelectFeature {
  @Inject var fetchMajorsUseCase: FetchMajorsUseCase
  @Inject var fetchCourseCountUseCase: FetchCourseCountUseCase

  @ObservableState
  struct State: Equatable {
    var majors: IdentifiedArrayOf<Major>
    var searchText: String
    var selectedMajor: String
    var fetchState: RequestState = .notRequest
    var bookmarks: [String]

    var searchMajors: IdentifiedArrayOf<Major> {
      let filteredMajors = majors.filter { major in
        searchText.isEmpty || major.name.localizedCaseInsensitiveContains(searchText)
      }.sorted { $0.bookmark && $1.bookmark }
      return IdentifiedArray(uniqueElements: filteredMajors)
    }
  }

  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case _onAppear
    case _fetchMajors
    case _fetchBookmarks
    case _setMajors([Major])
    case _applyBookmarks

    case searchTextChanged(String)
    case bookmarkButtonTapped(Major)
    case majorSelected(String)
  }

  var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case ._onAppear:
        return .concatenate(
          .send(._fetchMajors),
          .send(._fetchBookmarks)
        )

      case ._fetchMajors:
        state.fetchState = .isProgress
        return .run { send in
          let allMajorCount = fetchCourseCountUseCase.execute(major: "전체")
          var majors = [Major(name: "전체", courseCount: allMajorCount)]
          let fetchMajors = fetchMajorsUseCase.execute()
          for fetchMajor in fetchMajors {
            let fetchMajorCount = fetchCourseCountUseCase.execute(major: fetchMajor)
            majors.append(
              Major(
                name: fetchMajor,
                courseCount: fetchMajorCount
              )
            )
          }
          await send(._setMajors(majors))
        }

      case ._fetchBookmarks:
        guard let bookmarks = UserDefaults.shared.array(forKey: "bookmark") as? [String] else {
          return .none
        }
        state.bookmarks = bookmarks
        return .none

      case let ._setMajors(majors):
        state.majors = IdentifiedArray(uniqueElements: majors)
        return .send(._applyBookmarks)

      case ._applyBookmarks:
        for bookmark in state.bookmarks {
          let index = state.majors.firstIndex { $0.name == bookmark }!
          state.majors[index].bookmark = true
        }
        state.majors.sort { $0.bookmark && !$1.bookmark }

        state.fetchState = .success
        return .none

      case let .searchTextChanged(searchText):
        state.searchText = searchText
        return .none

      case let .bookmarkButtonTapped(major):
        let index = state.majors.firstIndex(where: { $0.id == major.id })!
        state.majors[index].bookmark.toggle()
        return .run { [majors = state.majors] _ in
          let bookmarks = majors.filter(\.bookmark).map(\.name)
          UserDefaults.shared.set(bookmarks, forKey: "bookmark")
        }

      case let .majorSelected(major):
        state.selectedMajor = major
        return .none
      }
    }
  }
}
