//
//  TabBarView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/2/24.
//

import SwiftUI

import DIContainer

struct TabBarView: View {
  
  let lectureEvaluationHomeView = DIContainer.shared.resolve(type: LectureEvaluationHomeView.self)
  let appState: AppState
  
  init(appState: AppState) {
    self.appState = appState
    UITabBar.appearance().standardAppearance.backgroundColor = .white
  }
  
  var body: some View {
    TabView {
      TimetableWrapperView()
        .ignoresSafeArea()
        .tabItem {
          Image(systemName: "calendar.badge.clock")
          Text("시간표")
        }
      lectureEvaluationHomeView
        .environmentObject(appState)
        .tabItem {
          Image(systemName: "books.vertical")
          Text("강의평가")
        }
      UserInfoView()
        .environmentObject(appState)
        .tabItem {
          Image(systemName: "person")
          Text("내 정보")
        }
    }
  }
}
