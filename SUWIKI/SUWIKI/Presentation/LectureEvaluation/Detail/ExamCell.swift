//
//  ExamCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2/29/24.
//

import SwiftUI

struct ExamCell: View {

    var semester: String
    var examType: String
    var difficulty: String
    var sourceOfExam: String
    var content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            semesterAndExamType
                .padding(.top, 12)
                .padding(.bottom, 10)
            examDifficultyLabel
                .padding(.bottom, 4)
            sourceOfExamLabel
                .padding(.bottom, 10)
            postContent
                .padding(.bottom, 12)
        }
        .padding(.horizontal, 12)
        .background(Color.white)
    }

    var semesterAndExamType: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50, height: 21)
                .foregroundStyle(Color(uiColor: .grayF6))
                .overlay {
                    Text(semester)
                        .font(.c4)
                        .foregroundStyle(Color(uiColor: .gray6A))
                }
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50, height: 21)
                .foregroundStyle(Color(uiColor: .grayF6))
                .overlay {
                    Text(examType)
                        .font(.c4)
                        .foregroundStyle(Color(uiColor: .gray6A))
                }
            Spacer()
        }
    }

    var examDifficultyLabel: some View {
        HStack(spacing: 0) {
            Text("난이도")
                .font(.c2)
                .foregroundStyle(Color(uiColor: .gray95))
                .padding(.trailing, 4)
            Text(difficulty)
                .font(.c2)
                .foregroundStyle(Color(uiColor: .basicBlack))
        }
    }

    var sourceOfExamLabel: some View {
        HStack(spacing: 0) {
            Text("시험유형")
                .font(.c2)
                .foregroundStyle(Color(uiColor: .gray95))
                .padding(.trailing, 4)
            Text(sourceOfExam)
                .font(.c2)
                .foregroundStyle(Color(uiColor: .basicBlack))
        }
    }

    var postContent: some View {
        Text(content)
            .font(.b7)
            .lineSpacing(2)
            .truncationMode(.tail)
    }

}

#Preview {
    ExamCell(semester: "2022-2",
             examType: "기말고사",
             difficulty: "쉬움",
             sourceOfExam: "교재, PPT",
             content: "시험 전 강의 시간에 교수님이 시험에 나올 것이라고 알려주신 세 부분 중 두 부분에 대해 작성하는 문제가 나왔다. OSI 7계층에 대해 논술하라는 문제와 CSMACD에 대해 설명하라는 문제가 출제되었다.")
}
