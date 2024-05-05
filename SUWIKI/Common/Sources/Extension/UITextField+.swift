//
//  UITextField+.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import UIKit
import Combine

extension UITextField {
    public var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap(\.text)
            .eraseToAnyPublisher()
    }
}
