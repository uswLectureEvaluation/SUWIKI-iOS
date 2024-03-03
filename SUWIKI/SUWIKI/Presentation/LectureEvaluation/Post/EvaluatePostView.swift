//
//  EvaluatePostView.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import SwiftUI

struct EvaluatePostView: View {

    var semesterList: [String] = ["2022-1", "2022-2"]
    @State var semester: String = ""
    @State var text: String = ""
    @State var honey: Double = 2.5

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack(alignment: .leading,
                   spacing: 0) {
                semesterAndAverageView
                    .padding(.bottom, 16)
                honeyView
                    .padding(.bottom, 12)
                learningView
                    .padding(.bottom, 12)
                satisfactionView
                    .padding(.bottom, 12)
                difficultyView
                    .padding(.bottom, 20)
                homeworkView
                    .padding(.bottom, 20)
                teamplayView
                    .padding(.bottom, 25)
                contentView
                Spacer()
            }
        }
    }

    var semesterAndAverageView: some View {
        HStack(spacing: 0) {
            Picker("", selection: $semester) {
                ForEach(semesterList, id: \.self) { semester in
                    Text(semester)
                }
            }
            .pickerStyle(.menu)
            .tint(Color(uiColor: .gray95))
            Spacer()
            Stars(avarage: honey, width: 16, height: 16)
                .padding(.horizontal, 4)
            Text(honey.description)
                .font(.b4)
                .foregroundStyle(Color(uiColor: .primaryColor))
        }
        .padding(.leading, 12)
        .padding(.trailing, 24)
    }

    var honeyView: some View {
        HStack(spacing: 0) {
            Text("꿀강지수")
                .frame(width: 58, height: 21)
                .font(.h5)
            Slider(value: $honey, in: 0...5, step: 0.5)
                .padding(.leading, 12)
                .padding(.trailing, 4)
            Text(honey.description)
                .font(.h6)
                .foregroundStyle(Color(uiColor: .primaryColor))
        }
        .padding(.horizontal, 24)
    }

    var learningView: some View {
        HStack(spacing: 0) {
            Text("배움지수")
                .frame(width: 58, height: 21)
                .font(.h5)
            Slider(value: $honey, in: 0...5, step: 0.5)
                .padding(.leading, 12)
                .padding(.trailing, 4)
            Text(honey.description)
                .font(.h6)
                .foregroundStyle(Color(uiColor: .primaryColor))
        }
        .padding(.horizontal, 24)
    }

    var satisfactionView: some View {
        HStack(spacing: 0) {
            HStack {
                Text("만족도")
                    .font(.h5)
                Spacer()
            }
            .frame(width: 58, height: 21)

            Slider(value: $honey, in: 0...5, step: 0.5)
                .padding(.leading, 12)
                .padding(.trailing, 4)
            Text(honey.description)
                .font(.h6)
                .foregroundStyle(Color(uiColor: .primaryColor))
        }
        .padding(.horizontal, 24)
    }

    var difficultyView: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("학점")
                    .font(.b4)
                Spacer()
            }
            .frame(width: 52,
                   height: 21)
            .padding(.trailing, 12)
            ForEach(DifficultyType.allCases, id: \.self) { type in
                if type != .notSelected {
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: type.width, height: 26)
                            .foregroundStyle(Color(uiColor: .grayF6))
                            .overlay {
                                Text(type.description)
                                    .font(.c1)
                                    .foregroundStyle(Color(uiColor: .gray95))
                            }
                    }
                    .padding(.trailing, 4)
                }
            }
        }
        .padding(.horizontal, 24)
    }

    var homeworkView: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("과제")
                    .font(.b4)
                Spacer()
            }
            .frame(width: 52,
                   height: 21)
            .padding(.trailing, 12)
            ForEach(HomeworkType.allCases, id: \.self) { type in
                if type != .notSelected {
                    Button {

                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 35, height: 26)
                            .foregroundStyle(Color(uiColor: .grayF6))
                            .overlay {
                                Text(type.description)
                                    .font(.c1)
                                    .foregroundStyle(Color(uiColor: .gray95))
                            }
                    }
                    .padding(.trailing, 4)
                }
            }
        }
        .padding(.horizontal, 24)
    }

    var teamplayView: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("조모임")
                    .font(.b4)
                Spacer()
            }
            .frame(width: 52,
                   height: 21)
            .padding(.trailing, 12)
            ForEach(TeamplayType.allCases, id: \.self) { type in
                if type != .notSelected {
                    Button {

                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 35, height: 26)
                            .foregroundStyle(Color(uiColor: .grayF6))
                            .overlay {
                                Text(type.description)
                                    .font(.c1)
                                    .foregroundStyle(Color(uiColor: .gray95))
                            }
                    }
                    .padding(.trailing, 4)
                }
            }
        }
        .padding(.horizontal, 24)
    }

    var contentView: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(Color(uiColor: .white))
            .padding(.horizontal, 24)
            .frame(height: 200)
            .overlay {
                TextEditor(text: $text)
                    .font(.b7)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 36)
            }

    }
}

#Preview {
    EvaluatePostView()
}
