//
//  IsPostEmptyView.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import SwiftUI

struct IsPostEmptyView: View {
  
  @Binding var postType: PostType
  @Binding var evaluatePostWriteButtonClicked: Bool
  @Binding var examPostWriteButtonClicked: Bool
  
  var body: some View {
    if postType == .evaluate {
      evaluateEmpty
    } else {
      examEmpty
    }
  }
  
  var evaluateEmpty: some View {
    VStack(spacing: 0) {
      Text("첫 강의평가를 작성하고\n10포인트를 획득하세요.")
        .foregroundStyle(Color(uiColor: .gray95))
        .font(.h4)
        .lineSpacing(4)
        .padding(.bottom, 28)
      Button {
        evaluatePostWriteButtonClicked.toggle()
      } label: {
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 158, height: 40)
          .foregroundStyle(Color(uiColor: .primaryColor))
          .overlay {
            Text("강의평가 작성하기")
              .font(.b2)
              .foregroundStyle(Color(uiColor: .white))
          }
      }
    }
  }
  
  var examEmpty: some View {
    VStack(spacing: 0) {
      Text("첫 시험정보를 작성하고\n10포인트를 획득하세요.")
        .foregroundStyle(Color(uiColor: .gray95))
        .font(.h4)
        .lineSpacing(4)
        .padding(.bottom, 28)
      Button {
        examPostWriteButtonClicked.toggle()
      } label: {
        RoundedRectangle(cornerRadius: 10)
          .frame(width: 158, height: 40)
          .foregroundStyle(Color(uiColor: .primaryColor))
          .overlay {
            Text("시험정보 작성하기")
              .font(.b2)
              .foregroundStyle(Color(uiColor: .white))
          }
      }
    }
  }
}
