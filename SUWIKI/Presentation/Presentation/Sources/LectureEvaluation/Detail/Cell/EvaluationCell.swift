//
//  EvaluateCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2/29/24.
//

import SwiftUI

import Common

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
