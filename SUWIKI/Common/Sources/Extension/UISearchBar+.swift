//
//  UISearchBar+.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/14.
//

import UIKit

extension UISearchBar {
  public func setTextFieldColor(_ color: UIColor) {
    for subView in self.subviews {
      for subSubView in subView.subviews {
        let view = subSubView as? UITextInputTraits
        if view != nil {
          let textField = view as? UITextField
          textField?.backgroundColor = color
          break
        }
      }
    }
  }
}
