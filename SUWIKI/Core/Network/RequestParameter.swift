//
//  RequestParameter.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

public enum RequestParameter {
    case plain
    case query(_ parameter: Encodable)
    case body(_ parameter: Encodable)
    case both(query: Encodable, json: Encodable)
}
