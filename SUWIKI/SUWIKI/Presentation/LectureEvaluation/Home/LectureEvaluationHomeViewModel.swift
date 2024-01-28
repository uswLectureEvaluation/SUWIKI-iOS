//
//  LectureEvaluationHomeViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

final class LectureEvaluationHomeViewModel: ObservableObject {

    var useCase: FetchLectureUseCase = DIContainer.shared.resolve(type: FetchLectureUseCase.self)

    @Published var lecture: [Lecture] = []
    @Published var option: LectureOption = .modifiedDate
    @Published var page: Int = 1
    @Published var major: String? = nil

    init() {
        Task {
            try await fetch()
        }
    }

    func bind()  {
    }

    func fetch() async throws {
        do {
            let fetchLecture = try await useCase.fetch(option: option,
                                                       page: page,
                                                       major: major)
            DispatchQueue.main.async {
                self.lecture += fetchLecture
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

//$option
//    .receive(on: DispatchQueue.main)
//    .sink { [weak self] data in
//        print("@LOGG - \(data)")
//        self?.page = 1
//        Task { [weak self] in
//            try await self?.fetch()
//        }
//    }
//    .store(in: &cancellables)
//        $option
//            .flatMap { [weak self] _ in
//                Future<Void, Never> { promise in
//                    Task { [weak self] in
//                        self?.page = 1
//                        try await self?.fetch()
//                        promise(.success(()))
//                    }
//                }
//            }
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                print("@Log Completion- \(completion)")
//            }
//            .store(in: &cancellables)
