//
//  LectureEvaluationDetailViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2/6/24.
//

import Foundation

//4591
final class LectureEvaluationDetailViewModel: ObservableObject {
    var fetchDetailLectureUseCase: FetchDetailLectureUseCase = DIContainer.shared.resolve(type: FetchDetailLectureUseCase.self)
    @Published var detailLecture: DetailLecture = DetailLecture.mockdata

    @MainActor
    init() {
        Task {
            do {
                self.detailLecture = try await fetchDetailLectureUseCase.excute(id: 4591)
            } catch {
                print("@Log LectureEvaluationDetialVM Fetch - \(error.localizedDescription)")
            }
        }
    }
}
