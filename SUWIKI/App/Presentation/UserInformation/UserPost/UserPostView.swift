//
//  UserPostView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import SwiftUI

struct UserPostView: View {
  
  @StateObject var viewModel = UserPostViewModel()
  
  var body: some View {
    ZStack {
      Color(uiColor: .systemGray6)
        .ignoresSafeArea()
      VStack {
        if viewModel.requestState == .success {
          postTypeButtons
            .padding(.top, 8)
          if viewModel.postType == .evaluate {
            evaluationPosts
          } else {
            examPosts
          }
          Spacer()
        } else {
          ProgressView()
        }
      }
    }
    .sheet(isPresented: $viewModel.isEvaluationPostModifyClicked) {
      if let selectedLecture = viewModel.selectedEvaluationPost {
        let difficultyType = DifficultyType(rawValue: selectedLecture.lectureDifficultyAvg + 1) ?? .notSelected
        let homeworkType = HomeworkType(rawValue: selectedLecture.lectureHomeworkAvg + 1) ?? .notSelected
        let teamplayType = TeamplayType(rawValue: selectedLecture.lectureTeamAvg + 1) ?? .notSelected
        EvaluationPostView(id: selectedLecture.id,
                           lectureName: selectedLecture.name,
                           professor: selectedLecture.professor,
                           semester: selectedLecture.semester,
                           isModified: true,
                           honeyPoint: selectedLecture.lectureHoneyAvg,
                           learningPoint: selectedLecture.lectureLearningAvg,
                           satisfactionPoint: selectedLecture.lectureSatisfactionAvg,
                           difficultyType: difficultyType,
                           homeworkType: homeworkType, 
                           teamplayType: teamplayType,
                           content: selectedLecture.content,
                           averagePoint: selectedLecture.lectureTotalAvg)
      }
    }
    .sheet(isPresented: $viewModel.isExamPostModifyClicked) {
      if let selectedLecture = viewModel.selectedExamPost {
        ExamPostView(id: selectedLecture.id,
                     lectureName: selectedLecture.name,
                     professor: selectedLecture.professor,
                     semester: selectedLecture.semesterList,
                     examInfo: selectedLecture.sourceOfExam,
                     examType: selectedLecture.examType,
                     examDifficulty: selectedLecture.difficulty,
                     content: selectedLecture.content)
      }
    }
  }
  
  var postTypeButtons: some View {
    HStack(spacing: 0) {
      Button {
        viewModel.postType = .evaluate
      } label: {
        VStack {
          Text("강의평가")
            .font(.h6)
            .foregroundStyle(
              Color(uiColor: viewModel.postType == .evaluate ? .basicBlack : .gray95)
            )
          Rectangle()
            .frame(width: 60, height: 2)
            .foregroundStyle(Color(uiColor: viewModel.postType == .evaluate ? .basicBlack : .systemGray6))
        }
      }
      .frame(width: 60, height: 36)
      Button {
        viewModel.postType = .exam
      } label: {
        VStack {
          Text("시험정보")
            .font(.h6)
            .foregroundStyle(
              Color(uiColor: viewModel.postType == .exam ? .basicBlack : .gray95)
            )
          Rectangle()
            .frame(width: 60, height: 2)
            .foregroundStyle(Color(uiColor: viewModel.postType == .exam ? .basicBlack : .systemGray6))
            .padding(.leading, 1)
        }
      }
      .frame(width: 60, height: 36)
      .padding(.leading, 12)
      Spacer()
    }
    .padding(.horizontal, 24)
  }
  
  var evaluationPosts: some View {
    ScrollView {
      ForEach(viewModel.userEvaluationPosts, id: \.self) { post in
        HStack {
          Text(post.name)
            .font(.h6)
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 21)
            .foregroundStyle(Color(uiColor: .white))
            .overlay {
              Text(post.selectedSemester)
                .font(.c4)
                .foregroundStyle(Color(uiColor: .gray6A))
            }
          Spacer()
          Button {
            viewModel.selectedEvaluationPost = post
            viewModel.isEvaluationPostModifyClicked.toggle()
          } label: {
            RoundedRectangle(cornerRadius: 10)
              .frame(width: 40, height: 21)
              .foregroundStyle(Color(uiColor: .white))
              .overlay {
                Text("수정")
                  .font(.c4)
                  .foregroundStyle(Color(uiColor: .gray6A))
              }
          }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        Divider()
      }
    }
  }
  
  var examPosts: some View {
    ScrollView {
      ForEach(viewModel.userExamPosts, id: \.self) { post in
        HStack {
          Text(post.name)
            .font(.h6)
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 21)
            .foregroundStyle(Color(uiColor: .white))
            .overlay {
              Text(post.selectedSemester)
                .font(.c4)
                .foregroundStyle(Color(uiColor: .gray6A))
            }
          Spacer()
          Button {
            viewModel.selectedExamPost = post
            viewModel.isExamPostModifyClicked.toggle()
          } label: {
            RoundedRectangle(cornerRadius: 10)
              .frame(width: 40, height: 21)
              .foregroundStyle(Color(uiColor: .white))
              .overlay {
                Text("수정")
                  .font(.c4)
                  .foregroundStyle(Color(uiColor: .gray6A))
              }
          }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        Divider()
      }
    }
  }
}
