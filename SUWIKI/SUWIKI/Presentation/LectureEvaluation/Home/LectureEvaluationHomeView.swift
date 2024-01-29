//
//  LectureEvaluationHomeView.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import SwiftUI

struct FilteringOption: Identifiable {
    let id: UUID
    let name: String
}
//"modifiedDate",
//"lectureSatisfactionAvg",
//"lectureHoneyAvg",
//"lectureLearningAvg",
//"lectureTotalAvg"
//@StateObject var viewModel = LectureEvaluationHomeViewModel()
//@State var index: Int = 0
struct LectureEvaluationHomeView: View {

    @State var searchText: String = ""
    @State var selection: String = "뭐임마"
    let dummy: [Lecture] = [
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9),
        Lecture(id: Int.random(in: 0...199), name: "데이터베이스", major: "정보보호학과", professor: "김명숙", lectureType: "전핵", lectureTotalAvg: 4.9)
    ]
    /// System 6

    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .systemGray6)
                    .ignoresSafeArea()
                lectureList
            }
            .navigationTitle("강의평가")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbar {
                Button {
                    print("tap!")
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .tint(Color(uiColor: .primaryColor))
                }
            }
        }

    }

    var lectureList: some View {
        VStack {
            List {
                header
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)

                ForEach(dummy) { lecture in
                    LectureCell(lecture: lecture)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
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

    var header: some View {
        HStack {
            Text("최근 올라온 강의")
                .font(.h5)
                .foregroundStyle(Color(uiColor: .gray6A))
            Spacer()
        }
        .background(Color(uiColor: .systemGray6))
    }

}

#Preview {
    LectureEvaluationHomeView()
}
