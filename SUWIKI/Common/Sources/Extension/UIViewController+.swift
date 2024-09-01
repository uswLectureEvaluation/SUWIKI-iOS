//
//  UIViewController+.swift
//  Common
//
//  Created by 한지석 on 8/30/24.
//

import UIKit

extension UIViewController {
  public func suwikiAlert(
    title: String? = nil,
    message: String? = nil,
    style: UIAlertController.Style,
    _ customAction: UIAlertAction
  ) {
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: style
    )

    alertController.addAction(customAction)
    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
    alertController.addAction(cancelAction)
    present(alertController, animated: true, completion: nil)
  }

  @objc public func closeButtonTapped() {
    dismiss(animated: true)
  }
}
