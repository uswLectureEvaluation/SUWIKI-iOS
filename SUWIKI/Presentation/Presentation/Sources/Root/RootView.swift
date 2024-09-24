//
//  TabBarView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/2/24.
//

import SwiftUI

import Common
import Domain
import DIContainer

import ComposableArchitecture

public struct RootView: View {

  let store: StoreOf<RootFeature>

  public init() {
    self.store = Store(initialState: RootFeature.State()) {
      RootFeature()
    }
  }

  public var body: some View {
    TabBarView(store: store)
      .onAppear {
        store.send(._initialize)
      }
  }
}

struct TabBarView: View {

  let store: StoreOf<RootFeature>

  init(store: StoreOf<RootFeature>) {
    self.store = store
    UITabBar.appearance().standardAppearance.backgroundColor = .white
  }

  public var body: some View {
    TabView {
      TimetableWrapperView()
        .ignoresSafeArea()
        .tabItem {
          Image(systemName: "calendar.badge.clock")
          Text("시간표")
        }
      LectureEvaluationHomeView(
        store: store.scope(
          state: \.lectureEvaluation,
          action: \.lectureEvaluation
        )
      )
      .tabItem {
        Image(systemName: "books.vertical")
        Text("강의평가")
      }
      UserInfoView(
        store: store.scope(
          state: \.userInfo,
          action: \.userInfo
        )
      )
        .tabItem {
          Image(systemName: "person")
          Text("내 정보")
        }
    }
  }
}
