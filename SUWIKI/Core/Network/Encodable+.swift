//
//  Encodable+.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionary = jsonData as? [String: Any] else { return [:] }
        return dictionary
    }
}
