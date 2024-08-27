//
//  ExamCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2/29/24.
//

import SwiftUI

struct ExamCell: View {

  var isPurchased: Bool
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
      if isPurchased {
        postContent
          .padding(.bottom, 12)
      } else {
        redactedPost
          .padding(.bottom, 12)
      }
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
            .redacted(reason: isPurchased ? [] : .placeholder)
        }
      RoundedRectangle(cornerRadius: 10)
        .frame(width: 50, height: 21)
        .foregroundStyle(Color(uiColor: .grayF6))
        .overlay {
          Text(examType)
            .font(.c4)
            .foregroundStyle(Color(uiColor: .gray6A))
            .redacted(reason: isPurchased ? [] : .placeholder)
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
        .redacted(reason: isPurchased ? [] : .placeholder)
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
        .redacted(reason: isPurchased ? [] : .placeholder)
    }
  }

  var postContent: some View {
    Text(content)
      .font(.b7)
      .lineSpacing(2)
      .truncationMode(.tail)
  }

  var redactedPost: some View {
    VStack(alignment: .leading) {
      Text(content)
        .font(.b7)
        .lineSpacing(2)
        .truncationMode(.tail)
        .redacted(reason: .placeholder)
      Text("")
      Text("wefpjofeowfppwjejewojpwefpjofeowfppwjejewojp")
        .font(.b7)
        .lineSpacing(2)
        .truncationMode(.tail)
        .redacted(reason: .placeholder)
      Text("")
      Text("wefpjofeowfppwjejewojpwefpjofeowfppwj")
        .font(.b7)
        .lineSpacing(2)
        .truncationMode(.tail)
        .redacted(reason: .placeholder)
    }
  }
}
