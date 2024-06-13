//
//  LectureEvaluationMajorSelectView.swift
//  SUWIKI
//
//  Created by 한지석 on 3/31/24.
//

import SwiftUI

import Domain

struct LectureEvaluationMajorSelectView: View {

  @Binding var selectedMajor: String
  @StateObject var viewModel = LectureEvaluationMajorSelectViewModel()
  @Environment(\.dismiss) var dismiss

  var body: some View {
    NavigationView {
      ZStack {
        Color(uiColor: .systemGray6)
          .ignoresSafeArea()
        VStack {
          if viewModel.fetchState == .success {
            if viewModel.searchText.isEmpty {
              majorList(major: viewModel.major)
            } else {
              majorList(major: viewModel.searchMajor)
            }
          } else {
            ProgressView()
          }
        }
      }
      .searchable(text: $viewModel.searchText)
      .navigationTitle("학과 선택")
      .navigationBarTitleDisplayMode(.large)
    }
  }

  func majorList(major: [Major]) -> some View {
    List {
      ForEach(major) { major in
        HStack {
          Text("")
          Button {
            viewModel.toggleBookmark(name: major.name)
          } label: {
            Image(systemName: major.bookmark ? "star.fill" : "star")
              .foregroundStyle(Color(uiColor: .primaryColor))
          }
          .buttonStyle(.plain)
          Button {
            selectedMajor = major.name
            dismiss()
          } label: {
            Rectangle()
              .foregroundStyle(Color.white)
              .frame(maxWidth: .infinity)
              .overlay(alignment: .leading) {
                Text(major.name)
                  .font(.h7)
              }
          }
          .buttonStyle(.plain)
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
      }
    }
  }

}
