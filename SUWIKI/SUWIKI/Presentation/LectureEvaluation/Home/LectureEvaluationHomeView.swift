//
//  LectureEvaluationHomeView.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import SwiftUI

struct LectureEvaluationHomeView: View {

    var repository = DefaultLectureRepository()

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                Task {
                    print(try await repository.load(option: .modifiedDate, page: 1, major: nil))
                }
            }, label: {
                Text("GET")
            })
        }
    }
}

#Preview {
    LectureEvaluationHomeView()
}
