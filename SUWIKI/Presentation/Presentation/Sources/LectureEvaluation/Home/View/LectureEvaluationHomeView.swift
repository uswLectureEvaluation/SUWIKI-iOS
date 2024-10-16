//
//  LectureEvaluationHomeView.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import SwiftUI

import Common
import Domain

import ComposableArchitecture

struct LectureEvaluationHomeView: View {

  @EnvironmentObject var appState: AppState
  @Bindable var store: StoreOf<LectureEvaluationHomeFeature>

  init(store: StoreOf<LectureEvaluationHomeFeature>) {
    self.store = store
  }

  var body: some View {
    NavigationStack {
      ZStack {
        Color(uiColor: .systemGray6)
          .ignoresSafeArea()
        lectureList
      }
      .navigationTitle(store.major)
      .navigationBarTitleDisplayMode(.large)
      .searchable(
        text: $store.searchText.sending(\.searchTextChanged),
        placement: .navigationBarDrawer(displayMode: .always)
      )
      .refreshable {
        store.send(.viewAction(.refresh))
      }
      .onSubmit(of: .search) {
        store.send(.viewAction(.searchButtonTapped))
      }
      .toolbar {
        Menu {
          optionMenu
          selectedMajor
        } label: {
          Image(systemName: "ellipsis.circle")
            .tint(Color(uiColor: .primaryColor))
        }
      }
      .onAppear {
        store.send(.internalAction(.initialize))
      }
      .sheet(
        item: $store.scope(
          state: \.destination?.selectMajor,
          action: \.destination.selectMajor
        )
      ) { store in
        LectureEvaluationMajorSelectView(store: store)
      }
      .sheet(
        item: $store.scope(
          state: \.destination?.login,
          action: \.destination.login
        )
      ) { store in
        LoginView(store: store)
      }
    }
  }

  private var lectureList: some View {
    VStack {
      List {
        header
          .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
          .listRowSeparator(.hidden)
        ForEach(
          store.lectures,
          id: \.id
        ) { lecture in
          LectureCell(lecture: lecture)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .onAppear {
              if store.lectures.last == lecture {
                store.send(.internalAction(.updateLectures))
              }
            }
            .onTapGesture {
              store.send(.viewAction(.lectureTapped(lecture)))
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .background(Color(uiColor: .systemGray6))
        .listRowSeparator(.hidden)
      }
      .background(Color(uiColor: .systemGray6))
      .scrollIndicators(.hidden)
      .listStyle(.plain)
      .listRowSpacing(12)
      .padding(.horizontal, 24)
      .environment(\.defaultMinListRowHeight, 10)
    }
  }

  private var header: some View {
    HStack {
      Text(store.option.description)
        .font(.h5)
        .foregroundStyle(Color(uiColor: .gray6A))
      Spacer()
    }
    .background(Color(uiColor: .systemGray6))
  }

  private var optionMenu: some View {
    Picker(selection: $store.option.sending(\.optionChanged)) {
      ForEach(LectureOption.allCases, id: \.self) { option in
        Button {
          store.send(.optionChanged(option))
        } label: {
          Text("\(option.description)")
        }
        .tag(option)
      }

    } label: {
      Text("다음으로 정렬")
      Text("\(store.option.description)")
    }
    .pickerStyle(.menu)
  }

  private var selectedMajor: some View {
    Button {
      store.send(.viewAction(.majorButtonTapped))
    } label: {
      Text("학과 선택하기")
      Text(store.major)
    }
  }
}
