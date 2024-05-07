//
//  AnnouncementDetailViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer
import Domain

final class AnnouncementDetailViewModel: ObservableObject {

    @Inject var useCase: FetchDetailAnnouncementUseCase
    @Published var announcement: Announcement? = nil
    @Published var requestState: RequestState = .notRequest

    @MainActor
    init(id: Int) {
        requestState = .isProgress
        Task {
            self.announcement = try await useCase.execute(id: id)
            requestState = .success
        }
    }
}
