//
//  LectureEvaluationMajorSelectView.swift
//  SUWIKI
//
//  Created by 한지석 on 3/31/24.
//

import SwiftUI

import Domain

import ComposableArchitecture

struct LectureEvaluationMajorSelectView: View {

  @Bindable var store: StoreOf<LectureEvaluationMajorSelectFeature>

  init(store: StoreOf<LectureEvaluationMajorSelectFeature>) {
    self.store = store
  }

  var body: some View {
    WithPerceptionTracking {
      NavigationView {
        ZStack {
          Color(uiColor: .systemGray6)
            .ignoresSafeArea()
          VStack {
            if store.fetchState == .success {
              if store.searchText.isEmpty {
                majorList(major: store.majors)
              } else {
                majorList(major: store.searchMajors)
              }
            } else {
              ProgressView()
            }
          }
        }
        .searchable(text: $store.searchText.sending(\.searchTextChanged))
        .navigationTitle("학과 선택")
        .navigationBarTitleDisplayMode(.large)
      }
    }
  }

  func majorList(major: IdentifiedArrayOf<Major>) -> some View {
    List {
      ForEach(major) { major in
        HStack {
          Text("")
          Button {
            store.send(.bookmarkButtonTapped(major))
          } label: {
            Image(systemName: major.bookmark ? "star.fill" : "star")
              .foregroundStyle(Color(uiColor: .primaryColor))
          }
          .buttonStyle(.plain)
          Button {
            store.send(.majorSelected(major.name))
          } label: {
            Rectangle()
              .foregroundStyle(Color.white)
              .frame(maxWidth: .infinity)
              .overlay(alignment: .leading) {
                Text(major.name)
                  .font(.h7)
              }
          }
          .buttonStyle(.plain)
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
      }
    }
  }

}
