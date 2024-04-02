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
        ZStack {
            TabView {
                TimetableWrapperView()
                    .tabItem {
                        Text("A")
                    }
                lectureEvaluationHomeView
                    .environmentObject(appState)
                    .tabItem {
                        Text("B")
                    }
            }
        }

    }
}

//#Preview {
//    TabBarView()
//}
