//
//  UnFilledStar.swift
//  SUWIKI
//
//  Created by 한지석 on 2/29/24.
//

import SwiftUI

struct UnFilledStar: View {
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: width, height: height)
            .foregroundStyle(Color(uiColor: .grayDA))
    }
}
