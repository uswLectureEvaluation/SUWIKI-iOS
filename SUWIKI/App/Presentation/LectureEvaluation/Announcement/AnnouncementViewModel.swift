//
//  AnnouncementViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import Domain
import DIContainer

final class AnnouncementViewModel: ObservableObject {
    @Inject var useCase: FetchAnnouncementUseCase
    @Published var announcement: [Announcement] = []

    init() {
        Task {
            try await fetch()
        }
    }

    @MainActor
    func fetch() async throws {
        do {
            self.announcement = try await useCase.execute()
        } catch {
            print(error.localizedDescription)
        }
    }
}
