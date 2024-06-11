//
//  TimetableWrapperView.swift
//  SUWIKI
//
//  Created by 한지석 on 4/2/24.
//

import Foundation
import SwiftUI

struct TimetableWrapperView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> some UIViewController {
    let timetableStoryboard = UIStoryboard(name: "TimetableView", bundle: .main)
    let timetableController = timetableStoryboard.instantiateViewController(withIdentifier: "timetableVC") as! TimetableViewController
    let navigationController = UINavigationController(rootViewController: timetableController)
    return navigationController
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
