//
//  AnnouncementDetailView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import SwiftUI

struct AnnouncementDetailView: View {

    @StateObject var viewModel: AnnouncementDetailViewModel

    init(id: Int) {
        self._viewModel = StateObject(wrappedValue: AnnouncementDetailViewModel(id: id))
    }

    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
            VStack {
                if viewModel.requestState == .success {
                    if let announcement = viewModel.announcement {
                        HStack {
                            Text(announcement.title)
                                .font(.h6)
                            Spacer()
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 4)
                        .padding(.horizontal, 24)
                        HStack {
                            Text(announcement.date)
                                .font(.c6)
                                .tint(Color(uiColor: .gray95))
                            Spacer()
                        }
                        .padding(.bottom, 16)
                        .padding(.horizontal, 24)
                        Divider()
                            .padding(.bottom, 24)
                        if let content = announcement.content {
                            Text(content)
                                .font(.b7)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 24)
                        }
                        Divider()
                            .padding(.top, 24)
                        Spacer()
                    }
                } else {
                    ProgressView()
                }
            }
        }
    }
}
