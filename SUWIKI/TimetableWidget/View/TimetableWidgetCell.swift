//
//  TimetableWidgetCell.swift
//  TimetableWidgetExtension
//
//  Created by 한지석 on 1/16/24.
//

import SwiftUI

struct WidgetCell: View {
  let color: UIColor
  let courseName: String
  let startTime: String?
  let endTime: String?

  init(
    color: UIColor,
    courseName: String,
    startTime: String? = nil,
    endTime: String? = nil
  ) {
    self.color = color
    self.courseName = courseName
    self.startTime = startTime
    self.endTime = endTime
  }

  var body: some View {
    HStack {
      Rectangle()
        .frame(
          width: 4,
          height: 16
        )
        .foregroundStyle(
          Color(
            uiColor: color
          )
        )
      Text(
        courseName
      )
      .font(
        .system(
          size: 12,
          weight: .semibold
        )
      )
      if let startTime = startTime, let endTime = endTime {
        Text(
          "\(startTime) - \(endTime)"
        )
        .font(
          .system(
            size: 12,
            weight: .light
          )
        )
      }
      Spacer()
    }
  }
}

