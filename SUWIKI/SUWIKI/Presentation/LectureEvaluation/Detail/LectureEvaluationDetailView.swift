//
//  LectureEvaluationDetailView.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import SwiftUI

enum PostType {
    case evaluate
    case exam
}

struct LectureEvaluationDetailView: View {

    @StateObject var viewModel: LectureEvaluationDetailViewModel

    init(id: Int) {
        self._viewModel = StateObject(wrappedValue: LectureEvaluationDetailViewModel(id: id))
    }

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                if viewModel.requestState == .success {
                    lectureType
                    name
                    majorAndProfessor
                    difficultyAndHomeworkAndTeam
                    avarageBox
                        .padding(.bottom, 24)
                    postTypeButtons
                        .padding(.bottom, 12)
                    if viewModel.postType == .evaluate {
                        evaluatePost()
                    } else {
                        examPost()
                    }
                    Spacer()
                } else {
                    ProgressView()
                }
            }
        }
    }

    @ViewBuilder
    func evaluatePost() -> some View {
        if !viewModel.evaluatePosts.isEmpty {
            evaluatePostList
        } else {
            IsPostEmptyView(postType: $viewModel.postType)
                .padding(.top, 60)
        }
    }


    @ViewBuilder
    func examPost() -> some View{
        if viewModel.examPostInfo.isExamPostsExists {
            if viewModel.examPostInfo.isPurchased {
                examPostList
            } else {
                //TODO: 시험정보 구매 버튼 구현 필요
                ExamCell(isPurchased: false,
                         semester: ExamPost.MockData.semester,
                         examType: ExamPost.MockData.examType,
                         difficulty: ExamPost.MockData.difficulty,
                         sourceOfExam: ExamPost.MockData.sourceOfExam,
                         content: ExamPost.MockData.content)
                .opacity(0.5)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 24)
            }
        } else {
            IsPostEmptyView(postType: $viewModel.postType)
                .padding(.top, 60)
        }
    }

    var postTypeButtons: some View {
        HStack(spacing: 0) {
            Button {
                viewModel.postType = .evaluate
            } label: {
                Text("강의평가")
                    .font(.h6)
                    .foregroundStyle(Color(uiColor: viewModel.postType == .evaluate ? .basicBlack : .gray95))
            }
            Button {
                viewModel.postType = .exam
            } label: {
                Text("시험정보")
                    .font(.h6)
                    .foregroundStyle(Color(uiColor: viewModel.postType == .exam ? .basicBlack : .gray95))
            }
            .padding(.leading, 12)
            Spacer()
        }
        .padding(.leading, 26)
    }

    var examPostList: some View {
        List {
            ForEach(viewModel.examPosts, id: \.id) { post in
                ExamCell(isPurchased: viewModel.examPostInfo.isPurchased,
                         semester: post.semester,
                         examType: post.examType,
                         difficulty: post.difficulty,
                         sourceOfExam: post.sourceOfExam,
                         content: post.content)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .background(Color(uiColor: .systemGray6))
            .listRowSeparator(.hidden)
        }
        .background(Color(uiColor: .systemGray6))
        .scrollIndicators(.hidden)
        .listRowSpacing(10)
        .listStyle(.plain)
        .padding(.horizontal, 24)
    }

    // 얘네 코드 줄이기
    var evaluatePostList: some View {
        List {
            ForEach(viewModel.evaluatePosts, id: \.id) { post in
                EvaluateCell(semester: post.selectedSemester,
                             totalAvg: post.totalAvarage,
                             content: post.content)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .background(Color(uiColor: .systemGray6))
            .listRowSeparator(.hidden)
        }
        .background(Color(uiColor: .systemGray6))
        .scrollIndicators(.hidden)
        .listRowSpacing(10)
        .listStyle(.plain)
        .padding(.horizontal, 24)
    }

    var lectureType: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 53, height: 21)
            .foregroundStyle(Color(uiColor: .white))
            .shadow(radius: 3)
            .overlay {
                Text(viewModel.detailLecture.lectureType)
                    .font(.c4)
                    .foregroundStyle(Color(uiColor: .gray6A))
            }
            .padding(.top, 20)
    }

    var name: some View {
        Text(viewModel.detailLecture.name)
            .font(.h3)
            .foregroundStyle(Color(uiColor: .basicBlack))
            .padding(.top, 8)
    }

    var majorAndProfessor: some View {
        HStack(spacing: 0) {
            Text(viewModel.detailLecture.major)
                .font(.b7)
                .foregroundStyle(Color(uiColor: .gray6A))
            Rectangle()
                .frame(width: 1, height: 14)
                .foregroundStyle(Color(uiColor: .grayDA))
                .padding(.horizontal, 4)
            Text(viewModel.detailLecture.professor)
                .font(.b7)
                .foregroundStyle(Color(uiColor: .gray6A))
        }
        .padding(.top, 4)
    }

    var difficultyAndHomeworkAndTeam: some View {
        HStack(spacing: 12) {
            averageLabel(type: .difficulty, average: viewModel.detailLecture.lectureDifficultyAvg)
            averageLabel(type: .homework, average: viewModel.detailLecture.lectureHomeworkAvg)
            averageLabel(type: .team, average: viewModel.detailLecture.lectureTeamAvg)
        }
        .padding(.top, 14)
    }

    var avarageBox: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.white)
            .shadow(radius: 4, x: 0, y: 0)
            .frame(height: 86)
            .overlay(alignment: .leading) {
                HStack {
                    totalAvarage
                        .padding(.leading, 20)
                    Rectangle()
                        .frame(width: 1, height: 49)
                        .foregroundStyle(Color(uiColor: .grayF6))
                        .padding(.horizontal, 12)
                    statistics
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
    }

    var totalAvarage: some View {
        VStack(spacing: 0) {
            Text(avgToString(viewModel.detailLecture.lectureTotalAvg))
                .font(.h1)
                .foregroundStyle(Color(uiColor: .primaryColor))
            Stars(avarage: viewModel.detailLecture.lectureTotalAvg,
                  width: 15,
                  height: 15)
        }
    }

    var statistics: some View {
        VStack {
            averageSummary(averageType: .honey, ratio: viewModel.detailLecture.lectureHoneyAvg)
            averageSummary(averageType: .learning, ratio: viewModel.detailLecture.lectureLearningAvg)
            averageSummary(averageType: .satisfaction, ratio: viewModel.detailLecture.lectureSatisfactionAvg)
        }
    }
}

extension LectureEvaluationDetailView {

    func averageLabel(
        type: DetailLabelType,
        average: Int
    ) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 66, height: 26)
            .foregroundStyle(type.backgroundColor)
            .overlay {
                Text("\(type.title) \(type.descriptions[average])")
                    .font(.c1)
                    .foregroundStyle(type.fontColor)
            }
    }

    func drawingProgressBar(ratio: Double) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 100, height: 6)
            .foregroundStyle(Color(uiColor: .grayF6))
            .overlay(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 20 * ratio, height: 6)
                    .foregroundStyle(Color(uiColor: .primaryColor))
            }
    }

    func averageSummary(
        averageType: DetailAverageType,
        ratio: Double
    ) -> some View {
        HStack(spacing: 0) {
            Text(averageType.title)
                .frame(width: 37, alignment: .leading)
                .font(.c5)
                .foregroundStyle(Color(uiColor: .basicBlack))
            drawingProgressBar(ratio: ratio)
                .padding(.horizontal, 10)
            Text(String(format: "%.1f", ratio))
                .font(.c1)
        }
    }

    func avgToString(_ avg: Double) -> String {
        return String(format: "%.1f", avg)
    }
}

enum DetailLabelType {
    case difficulty
    case homework
    case team

    var title: String {
        switch self {
        case .difficulty:
            "학점"
        case .homework:
            "과제"
        case .team:
            "팀플"
        }
    }

    var descriptions: [String] {
        switch self {
        case .difficulty:
            ["잘줌", "보통", "하드"]
        case .homework:
            ["없음", "보통", "많음"]
        case .team:
            ["없음", "있음"]
        }
    }

    var fontColor: Color {
        switch self {
        case .difficulty:
            Color(uiColor: .easyFont)
        case .homework:
            Color(uiColor: .normalFont)
        case .team:
            Color(uiColor: .hardFont)
        }
    }

    var backgroundColor: Color {
        switch self {
        case .difficulty:
            Color(uiColor: .easyBackground)
        case .homework:
            Color(uiColor: .normalBackground)
        case .team:
            Color(uiColor: .hardBackground)
        }
    }
}

enum DetailAverageType {
    case honey
    case learning
    case satisfaction

    var title: String {
        switch self {
        case .honey:
            "꿀강지수"
        case .learning:
            "배움지수"
        case .satisfaction:
            "만족도"
        }
    }
}
