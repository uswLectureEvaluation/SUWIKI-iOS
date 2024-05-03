//
//  LectureEvaluationHomeView.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import SwiftUI

import Domain

struct LectureEvaluationHomeView: View {

    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = LectureEvaluationHomeViewModel()
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(uiColor: .systemGray6)
                    .ignoresSafeArea()
                lectureList
            }
            .navigationTitle(viewModel.major)
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable {
                Task {
                    viewModel.fetchPage = 1
                    viewModel.searchPage = 1
                    try await viewModel.fetch()
                }
            }
            .onSubmit(of: .search) {
                Task {
                    try await viewModel.search()
                }
            }
            .toolbar {
                Menu {
                    optionMenu
                    selectedMajor
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .tint(Color(uiColor: .primaryColor))
                }
            }
            .navigationDestination(for: Lecture.self) { lecture in
                LectureEvaluationDetailView(id: lecture.id)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                print("@Login - \(appState.isLoggedIn)")
            }
            .sheet(isPresented: $viewModel.isMajorSelectSheetPresented) {
                LectureEvaluationMajorSelectView(selectedMajor: $viewModel.major)
            }
            .sheet(isPresented: $viewModel.isLoginViewPresented) {
                LoginView()
            }
        }
    }

    var lectureList: some View {
        VStack {
            List {
                header
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                ForEach(viewModel.lecture, id: \.id) { lecture in
                    LectureCell(lecture: lecture)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .onAppear {
                            if viewModel.lecture.last == lecture {
                                Task {
                                    try await viewModel.update()
                                }
                            }
                        }
                        .onTapGesture {
                            if appState.isLoggedIn {
                                path.append(lecture)
                            } else {
                                viewModel.isLoginViewPresented.toggle()
                            }
                        }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .background(Color(uiColor: .systemGray6))
                .listRowSeparator(.hidden)
            }
            .background(Color(uiColor: .systemGray6))
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .listRowSpacing(12)
            .padding(.horizontal, 24)
            .environment(\.defaultMinListRowHeight, 10)
        }
    }

    var header: some View {
        HStack {
            Text(viewModel.option.description)
                .font(.h5)
                .foregroundStyle(Color(uiColor: .gray6A))
            Spacer()
        }
        .background(Color(uiColor: .systemGray6))
    }

    var optionMenu: some View {
        Picker(selection: $viewModel.option) {
            ForEach(LectureOption.allCases, id: \.self) { option in
                Button {
                    viewModel.option = option
                } label: {
                    Text("\(option.description)")
                }
                .tag(option)
            }

        } label: {
            Text("다음으로 정렬")
            Text("\(viewModel.option.description)")
        }
        .pickerStyle(.menu)
    }

    var selectedMajor: some View {
        Button {
            viewModel.isMajorSelectSheetPresented.toggle()
//            KeychainManager.shared.delete(token: .AccessToken)
//            KeychainManager.shared.delete(token: .RefreshToken)
//            appState.isLoggedIn = false
        } label: {
            Text("학과 선택하기")
            Text(viewModel.major)
        }
    }

    //TODO: EmptyView - 검색 데이터 없을 경우
}

#Preview {
    LectureEvaluationHomeView()
}
