//
//  EvaluateCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2/29/24.
//

import SwiftUI

struct EvaluateCell: View {

    var semester: String
    var totalAvg: Double
    var content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            semesterLabel
                .padding(.top, 12)
                .padding(.bottom, 14)
            avarageStar
                .padding(.bottom, 14)
            postContent
                .padding(.bottom, 12)
        }
        .padding(.horizontal, 12)
        .background(Color.white)
    }

    var semesterLabel: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50, height: 21)
                .foregroundStyle(Color(uiColor: .grayF6))
                .overlay {
                    Text(semester)
                        .font(.c4)
                        .foregroundStyle(Color(uiColor: .gray6A))
                }
            Spacer()
        }

    }

    var avarageStar: some View {
        Stars(avarage: totalAvg,
              width: 12,
              height: 12)
    }

    var postContent: some View {
        Text(content)
            .font(.b7)
            .lineSpacing(2)
            .truncationMode(.tail)
    }
}

#Preview {
    EvaluateCell(semester: "2022-2", totalAvg: 3.5, content: "거의 한 학기 팀플하시는데...팀원 잘 만나면 잘 모르겠네요.굉장히 오거의 한 학기 팀플하시는데...팀원 잘 만나면 잘 모르겠네요.굉장히오픈 마인드시긴해요.\n전 이 교수님 적응하기 힘들었어요.\n굉장히 오픈 마인드시긴해요.\n전 이 교수님 적응하기 힘들었어요.")
}
