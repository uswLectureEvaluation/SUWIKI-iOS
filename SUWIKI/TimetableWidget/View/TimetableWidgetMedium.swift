//
//  TimetableWidgetMedium.swift
//  TimetableWidgetExtension
//
//  Created by 한지석 on 1/16/24.
//

import SwiftUI

import Common

struct TimetableWidgetMedium: View {

    @StateObject var viewModel = TimetableWidgetViewModel()

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                weekday
                if viewModel.courses.count > 0 {
                    VStack {
                        ForEach(viewModel.courses) { course in
                            WidgetCell(color: .timetableColors[course.color],
                                       courseName: course.courseName,
                                       startTime: course.startTime,
                                       endTime: course.endTime)
                        }
                        Spacer()
                    }
                    .padding(.top, 2)
                    .padding(.leading, 12)
                } else {
                    dayOff
                        .padding(.top, 2)
                        .padding(.leading, 12)
                }

            }
            if viewModel.eLearning.count > 0 {
                Divider()
                    .padding(.bottom, 4)
                HStack {
                    VStack(alignment: .leading) {
                        Text("이러닝")
                            .font(.system(size: 17, weight: .semibold))
                        Spacer()
                    }
                    VStack {
                        ForEach(viewModel.eLearning) { eLearning in
                            WidgetCell(color: .timetableColors[eLearning.color],
                                       courseName: eLearning.courseName)
                        }
                        Spacer()
                    }
                    .padding(.top, 2)
                    .padding(.leading, 4)
                }
            }
        }
    }

    var weekday: some View {
        VStack(alignment: .leading) {
            Text(viewModel.weekday)
                .font(.system(size: 20, weight: .semibold))
            Text(viewModel.date)
                .font(.system(size: 10, weight: .light))
            Spacer()
        }
    }

    var dayOff: some View {
        HStack {
            Rectangle()
                .frame(width: 4, height: 16)
                .foregroundStyle(Color.blue)
            Text("오늘은 강의가 없어요!")
                .font(.system(size: 12, weight: .semibold))
            Spacer()
        }
    }

}
