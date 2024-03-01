//
//  LectureEvaluationDetailView.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import SwiftUI

struct LectureEvaluationDetailView: View {

    @StateObject var viewModel = LectureEvaluationDetailViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .systemGray6)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    lectureType
                    name
                    majorAndProfessor
                    difficultyAndHomeworkAndTeam
                    avarageBox
                        .padding(.bottom, 24)
                    postTypeButtons
                        .padding(.bottom, 12)
                    postList
                    Spacer()
                }
            }
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
        .padding(.leading, 24)
    }

    var postList: some View {
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
            .foregroundStyle(Color(uiColor: .grayF6))
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
            averageLabel(type: .difficulty, average: viewModel.detailLecture.lectureDifficultyAvg.description)
            averageLabel(type: .homework, average: viewModel.detailLecture.lectureHomeworkAvg.description)
            averageLabel(type: .team, average: viewModel.detailLecture.lectureTeamAvg.description)
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
        average: String
    ) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 66, height: 26)
            .foregroundStyle(type.backgroundColor)
            .overlay {
                Text("\(type.title) \(average)")
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

#Preview {
    LectureEvaluationDetailView(viewModel: LectureEvaluationDetailViewModel())
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

    var fontColor: Color {
        switch self {
        case .difficulty:
            Color(uiColor: .difficultyFont)
        case .homework:
            Color(uiColor: .homeworkFont)
        case .team:
            Color(uiColor: .teamFont)
        }
    }

    var backgroundColor: Color {
        switch self {
        case .difficulty:
            Color(uiColor: .difficultyBackground)
        case .homework:
            Color(uiColor: .homeworkBackground)
        case .team:
            Color(uiColor: .teamBackground)
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

extension UIColor {
    static let difficultyBackground = UIColor(red: 236 / 255, green: 237 / 255, blue: 1, alpha: 1)
    static let difficultyFont = UIColor(red: 61 / 255, green: 78 / 255, blue: 251 / 255, alpha: 1)
    static let homeworkBackground = UIColor(red: 234 / 255, green: 248 / 255, blue: 236 / 255, alpha: 1)
    static let homeworkFont = UIColor(red: 45 / 255, green: 185 / 255, blue: 66 / 255, alpha: 1)
    static let teamBackground = UIColor(red: 255 / 255, green: 241 / 255, blue: 229 / 255, alpha: 1)
    static let teamFont = UIColor(red: 253 / 255, green: 135 / 255, blue: 59 / 255, alpha: 1)
}
