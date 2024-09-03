//
//  AlamofireManager.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

/// 인터셉터 추가 예정
final class AlamofireManager {
  static let shared = AlamofireManager()
  
  let interceptor = BaseInterceptor()
  let loggers = [APIStatusLogger()] as [EventMonitor]
  var session: Session
  
  private init() {
    self.session = Session(interceptor: interceptor,
                           eventMonitors: loggers)
  }
}
