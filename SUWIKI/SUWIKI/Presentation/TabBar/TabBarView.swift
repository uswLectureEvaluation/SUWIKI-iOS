//
//  TabBarView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/2/24.
//

import SwiftUI

struct TabBarView: View {
    
    let lectureEvaluationHomeView = DIContainer.shared.resolve(type: LectureEvaluationHomeView.self)
    let appState: AppState
    
    var body: some View {
        TabView {
            TimetableWrapperView()
                .ignoresSafeArea()
                .tabItem {
                    Text("시간표")
                }
            lectureEvaluationHomeView
                .environmentObject(appState)
                .tabItem {
                    Text("강의평가")
                }
            UserInfoView()
                .environmentObject(appState)
                .tabItem {
                    Text("내 정보")
                }
        }
    }
}

//#Preview {
//    TabBarView()
//}
