//
//  BaseInterceptor.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/16.
//

import Foundation
import Alamofire
import KeychainSwift
import SwiftyJSON

class BaseInterceptor: RequestInterceptor{
    
    let keychain = KeychainSwift()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
            guard urlRequest.url?.absoluteString.hasPrefix("https://api.suwiki.kr/") == true,
                  let accessToken = keychain.get("AccessToken") else {
                      completion(.success(urlRequest))
                      return
                  }
        
            print("adapt")
            var urlRequest = urlRequest
            urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")

            completion(.success(urlRequest))
           
        }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let test = request.task?.response as? HTTPURLResponse
        print(test?.statusCode)
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            print("donottry")
            completion(.doNotRetryWithError(error))
            return
        }
        print("retry")
        let url = "https://api.suwiki.kr/user/refresh"
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("RefreshToken") ?? "")
        ]
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let data = response.data
            let json = JSON(data!)
            switch response.result{
            case .success(_):
                self.keychain.clear()
                self.keychain.set(json["RefreshToken"].stringValue, forKey: "RefreshToken")
                self.keychain.set(json["AccessToken"].stringValue, forKey: "AccessToken")
                print("keychainSet")
                completion(.retry)
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
            
            
        }
        }
    
    
}

