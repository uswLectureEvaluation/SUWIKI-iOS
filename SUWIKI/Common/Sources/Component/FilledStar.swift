//
//  FilledStar.swift
//  SUWIKI
//
//  Created by 한지석 on 2/29/24.
//

import SwiftUI

public struct FilledStar: View {
  var width: CGFloat
  var height: CGFloat
  
  public init(
    width: CGFloat,
    height: CGFloat
  ) {
    self.width = width
    self.height = height
  }
  
  public var body: some View {
    Image(systemName: "star.fill")
      .resizable()
      .frame(width: width, height: height)
      .foregroundStyle(Color(uiColor: .primaryColor))
  }
}
