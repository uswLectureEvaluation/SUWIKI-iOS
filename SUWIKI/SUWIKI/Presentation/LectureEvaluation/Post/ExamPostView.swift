//
//  ExamPostView.swift
//  SUWIKI
//
//  Created by 한지석 on 3/28/24.
//

import SwiftUI

struct ExamPostView: View {

    let semesterList = ["2022-1", "2022-2"]
    let examTypeList = ["중간고사", "기말고사"]
    var examInfoTypeList = ExamInfoType.allCases
    @State var semester = "수강학기"
    @State var examType = "시험종류"
    @State var difficultyType: DifficultyType = .notSelected
    @State var examInfoType: ExamInfoType = .notSelected
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ExamPostViewModel

    init(
        id: Int,
        lectureName: String,
        professor: String,
        semester: String
    ) {
        self._viewModel = StateObject(wrappedValue: ExamPostViewModel(id: id,
                                                                      lectureName: lectureName,
                                                                      professor: professor,
                                                                      semester: semester))
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                closeButton
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                semesterAndExamTypeView
                    .padding(.bottom, 16)
                difficultyView
                    .padding(.bottom, 16)
                examInfoTypeView
                    .padding(.bottom, 20)
                contentView
                    .padding(.bottom, 40)
                postButton
                    .padding(.bottom, 20)
            }
        }
    }

    var closeButton: some View {
        ZStack {
            Text("시험정보")
                .font(.h6)
            HStack(spacing: 0) {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color(uiColor: .gray95))
                }
            }
            .padding(.horizontal, 24)
        }
    }

    var semesterAndExamTypeView: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color(uiColor: .grayFB))
                .frame(width: 80, height: 30)
                .overlay {
                    Menu {
                        Picker("", selection: $viewModel.selectedSemester) {
                            ForEach(viewModel.semesterList, id: \.self) { semester in
                                Text(semester)
                                    .font(.b4)
                                    .tag(semester)
                            }
                        }
                    } label: {
                        Text(viewModel.selectedSemester)
                            .font(.b4)
                        Image(systemName: "chevron.up.chevron.down")
                            .resizable()
                            .frame(width: 8, height: 12)
                    }
                    .tint(Color(uiColor: .gray))
                }
                .padding(.bottom, 8)
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color(uiColor: .grayFB))
                .frame(width: 80, height: 30)
                .overlay {
                    Menu {
                        Picker("", selection: $viewModel.examType) {
                            ForEach(viewModel.examTypeList, id: \.self) { semester in
                                Text(semester)
                                    .font(.b4)
                                    .tag(semester)
                            }
                        }
                    } label: {
                        Text(viewModel.examType)
                            .font(.b4)
                        Image(systemName: "chevron.up.chevron.down")
                            .resizable()
                            .frame(width: 8, height: 12)
                    }
                    .tint(Color(uiColor: .gray))
                }
        }
        .padding(.horizontal, 20)
    }

    var difficultyView: some View {
        HStack(spacing: 0) {
            HStack {
                Text("난이도")
                    .font(.b4)
                Spacer()
            }
            .frame(width: 58,
                   height: 21)
            .padding(.trailing, 12)
            ForEach(DifficultyType.allCases, id: \.self) { type in
                if type != .notSelected {
                    Button {
                        viewModel.examDifficulty = type
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(viewModel.examDifficulty == type ?
                                    Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                            .frame(width: type.examWidth, height: 26)
                            .foregroundStyle(viewModel.examDifficulty == type ?
                                             Color(uiColor: .white) : Color(uiColor: .grayF6))
                            .overlay {
                                Text(type.exam)
                                    .font(.c1)
                                    .foregroundStyle(viewModel.examDifficulty == type ?
                                                     Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                            }
                    }
                    .padding(.trailing, 4)
                }
            }
        }
        .padding(.horizontal, 24)
    }

    var examInfoTypeView: some View {
        HStack(spacing: 0) {
            HStack {
                Text("시험유형")
                    .font(.b4)
                Spacer()
            }
            .frame(width: 58,
                   height: 21)
            .padding(.trailing, 12)
            ForEach($viewModel.examInfos, id: \.0.self) { type in
                if type.wrappedValue.0 != .notSelected {
                    Button {
                        viewModel.settingExamInfo(type: type.wrappedValue.0.description)
                        type.wrappedValue.1.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(type.wrappedValue.1 == true ?
                                    Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
                            .frame(width: 35, height: 26)
                            .foregroundStyle(type.wrappedValue.1 == true ?
                                             Color(uiColor: .white) : Color(uiColor: .grayF6))

                            .overlay {
                                Text(type.wrappedValue.0.description)
                                    .font(.c1)
                                    .foregroundStyle(type.wrappedValue.1 == true ?
                                                     Color(uiColor: .primaryColor) : Color(uiColor: .gray95))
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
            .frame(minHeight: 150, maxHeight: 300)
            .overlay {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $viewModel.content)
                        .font(.b7)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 36)
                    Text(viewModel.content.isEmpty ? "10글자 이상 입력해주세요." : "")
                        .font(.b7)
                        .foregroundStyle(Color.gray)
                        .padding(.top, 18)
                        .padding(.leading, 40)
                }
            }
    }

    var postButton: some View {
        Button {
            Task {
                //                try await viewModel.write()
            }
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 50)
                .padding(.horizontal, 24)
                .overlay {
                    Text("작성하기")
                        .font(.h5)
                        .foregroundStyle(Color(uiColor: .white))
                }
        }
    }

}
