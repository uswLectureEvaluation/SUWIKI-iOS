//
//  EvaluatePostView.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import SwiftUI

import Common

struct EvaluationPostView: View {
  
  @Environment(\.dismiss) var dismiss
  @StateObject var viewModel: EvaluationPostViewModel
  
  init(
    id: Int,
    lectureName: String,
    professor: String,
    semester: String
  ) {
    self._viewModel = StateObject(wrappedValue: EvaluationPostViewModel(id: id,
                                                                        lectureName: lectureName,
                                                                        professor: professor,
                                                                        semester: semester))
  }
  
  init(
    id: Int,
    lectureName: String,
    professor: String,
    semester: String,
    isModified: Bool,
    honeyPoint: Double,
    learningPoint: Double,
    satisfactionPoint: Double,
    difficultyType: DifficultyType,
    homeworkType: HomeworkType,
    teamplayType: TeamplayType,
    content: String,
    averagePoint: Double
  ) {
    self._viewModel = StateObject(wrappedValue: EvaluationPostViewModel(id: id,
                                                                        lectureName: lectureName,
                                                                        professor: professor,
                                                                        semester: semester,
                                                                        isModified: isModified,
                                                                        honeyPoint: honeyPoint,
                                                                        learningPoint: learningPoint,
                                                                        satisfactionPoint: satisfactionPoint,
                                                                        difficultyType: difficultyType,
                                                                        homeworkType: homeworkType,
                                                                        teamplayType: teamplayType,
                                                                        content: content,
                                                                        averagePoint: averagePoint))
  }
  
  var body: some View {
    ZStack {
      Color(uiColor: .systemGray6)
        .ignoresSafeArea()
      VStack(alignment: .leading,
             spacing: 0) {
        closeButton
          .padding(.top, 24)
          .padding(.bottom, 24)
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
          .padding(.bottom, 40)
        postButton
          .padding(.bottom, 20)
      }
    }
    .alert("비어있는 항목이 있어요.", isPresented: $viewModel.isDataEmpty) {
      Button("확인") { }
    } message: {
      Text("정확한 강의평가를 위해 항목을 채워주세요!")
    }
  }
  
  var closeButton: some View {
    ZStack {
      Text("강의평가")
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
  
  var semesterAndAverageView: some View {
    HStack(spacing: 0) {
      Picker("", selection: $viewModel.selectedSemester) {
        ForEach(viewModel.semesterList, id: \.self) { semester in
          Text(semester)
        }
      }
      .pickerStyle(.menu)
      .tint(Color(uiColor: .gray))
      Spacer()
      //TODO: 평균으로 수정
      Stars(avarage: viewModel.averagePoint, width: 16, height: 16)
        .padding(.horizontal, 4)
      Text(String(format: "%.1f", viewModel.averagePoint))
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
      Slider(value: $viewModel.honeyPoint, in: 0...5, step: 0.5)
        .padding(.leading, 12)
        .padding(.trailing, 4)
      Text(viewModel.honeyPoint.description)
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
      Slider(value: $viewModel.learningPoint, in: 0...5, step: 0.5)
        .padding(.leading, 12)
        .padding(.trailing, 4)
      Text(viewModel.learningPoint.description)
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
      
      Slider(value: $viewModel.satisfactionPoint, in: 0...5, step: 0.5)
        .padding(.leading, 12)
        .padding(.trailing, 4)
      Text(viewModel.satisfactionPoint.description)
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
            viewModel.difficultyType = type
          } label: {
            RoundedRectangle(cornerRadius: 5)
              .frame(width: type.width, height: 26)
              .foregroundStyle(viewModel.difficultyType == type ?
                               Color(type.background) : Color(uiColor: .grayF6))
              .overlay {
                Text(type.description)
                  .font(.c1)
                  .foregroundStyle(viewModel.difficultyType == type ?
                                   Color(type.font) : Color(uiColor: .gray95))
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
            viewModel.homeworkType = type
          } label: {
            RoundedRectangle(cornerRadius: 5)
              .frame(width: 35, height: 26)
              .foregroundStyle(viewModel.homeworkType == type ?
                               Color(type.background) : Color(uiColor: .grayF6))
              .overlay {
                Text(type.description)
                  .font(.c1)
                  .foregroundStyle(viewModel.homeworkType == type ?
                                   Color(type.font) : Color(uiColor: .gray95))
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
        Text("팀플")
          .font(.b4)
        Spacer()
      }
      .frame(width: 52,
             height: 21)
      .padding(.trailing, 12)
      ForEach(TeamplayType.allCases, id: \.self) { type in
        if type != .notSelected {
          Button {
            viewModel.teamplayType = type
          } label: {
            RoundedRectangle(cornerRadius: 5)
              .frame(width: 35, height: 26)
              .foregroundStyle(viewModel.teamplayType == type ?
                               Color(type.background) : Color(uiColor: .grayF6))
              .overlay {
                Text(type.description)
                  .font(.c1)
                  .foregroundStyle(viewModel.teamplayType == type ?
                                   Color(type.font) : Color(uiColor: .gray95))
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
      .frame(minHeight: 150, maxHeight: .infinity)
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
        var isFinished = false
        if viewModel.isModified {
          isFinished = try await viewModel.update()
        } else {
          isFinished = try await viewModel.write()
        }
        if isFinished {
          dismiss()
        }
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
