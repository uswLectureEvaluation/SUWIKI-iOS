//
//  LectureCell.swift
//  SUWIKI
//
//  Created by 한지석 on 1/29/24.
//

import SwiftUI

struct LectureCell: View {

    let lecture: Lecture

    var body: some View {
        RoundedRectangle(cornerSize: .init(width: 10, height: 10))
            .foregroundStyle(Color.white)
            .overlay(alignment: .topLeading) {
                info
            }
            .frame(height: 100)
            .padding(.horizontal, 24)
    }

    var info: some View {
        VStack(alignment: .leading,
               spacing: 0) {
            HStack(spacing: 0) {
                Text(lecture.name)
                    .font(.h3)
                Spacer()
                RoundedRectangle(cornerSize: CGSize(width: 10,
                                                    height: 10))
                .foregroundStyle(Color(uiColor: .grayF6))
                .frame(width: 33, height: 21)
                .overlay {
                    Text(lecture.lectureType)
                        .font(.c4)
                        .foregroundStyle(Color(uiColor: .gray6A))
                }
            }
            .padding(.top, 16)

            HStack(spacing: 0) {
                Text(lecture.major)
                    .font(.b7)
                Rectangle()
                    .frame(width: 1, height: 14)
                    .padding(.horizontal, 4)
                Text(lecture.professor)
                    .font(.b7)
            }
            .foregroundStyle(Color(uiColor: .gray6A))
            .padding(.top, 4)
            HStack(spacing: 0) {
                Image(systemName: "star.fill")
                    .frame(width: 16, height: 16)
                    .padding(.top, 6)
                    .padding(.trailing, 4)
                Text(avgToString(lecture.lectureTotalAvg))
                    .font(.b1)
                    .padding(.top, 7)
            }
            .foregroundStyle(Color(uiColor: .primaryColor))
        }
               .padding(.leading, 14)
    }

    func avgToString(_ avg: Double) -> String {
        return String(format: "%.1f", avg)
    }

}

#Preview {
    LectureCell(lecture: Lecture(id: 0, name: "강의명", major: "개설학과", professor: "교수명", lectureType: "전핵", lectureTotalAvg: 5.0))
}
