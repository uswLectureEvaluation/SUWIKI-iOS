//
//  BaseInterceptor.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/16.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor{
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        <#code#>
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        <#code#>
    }
}
