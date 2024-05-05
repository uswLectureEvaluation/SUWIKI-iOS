//
//  Stars.swift
//  SUWIKI
//
//  Created by 한지석 on 2/29/24.
//

import SwiftUI

/// https://developer.apple.com/documentation/swiftui/view/mask(alignment:_:)
public struct Stars: View {
    var avarage: Double
    var width: CGFloat
    var height: CGFloat

    public init(
        avarage: Double,
        width: CGFloat, 
        height: CGFloat
    ) {
        self.avarage = avarage
        self.width = width
        self.height = height
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { index in
                if avarage > CGFloat(index) {
                    /// 3.4일 경우 3과 4사이일 때
                    if avarage < CGFloat(index + 1) {
                        drawingStarRatio(ratio: Double(avarage * 10).truncatingRemainder(dividingBy: 10) * 1.5)
                    } else {
                        FilledStar(width: width, height: height)
                    }
                } else {
                    UnFilledStar(width: width, height: height)
                }
            }
        }
    }

    func drawingStarRatio(ratio: Double) -> some View {
        ZStack {
            UnFilledStar(width: width, height: height)
            FilledStar(width: width, height: height)
                .mask {
                    Rectangle()
                        .size(width: ratio,
                              height: 15)
                }
        }
    }
}
