//
//  AnnouncementView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/3/24.
//

import SwiftUI

struct AnnouncementView: View {

    @StateObject var viewModel = AnnouncementViewModel()

    var body: some View {
        VStack {
            announcementList
        }
        .navigationTitle("공지사항")
    }

    var announcementList: some View {
        List {
            ForEach(viewModel.announcement) { announcement in
                NavigationLink {
                    AnnouncementDetailView(id: announcement.id)
                } label: {
                    VStack(alignment: .leading) {
                        Text(announcement.title)
                            .font(.h6)
                            .tint(.black)
                            .padding(.bottom, 4)
                        Text(announcement.date)
                            .font(.c6)
                            .tint(Color(uiColor: .gray95))
                    }
                }
            }
        }
    }
}

#Preview {
    AnnouncementView()
}
