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
            guard urlRequest.url?.absoluteString.hasPrefix("https://api.suwiki.kr   ") == true,
                  let accessToken = keychain.get("AccessToken") else {
                      completion(.success(urlRequest))
                      return
                  }

            var urlRequest = urlRequest
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            completion(.success(urlRequest))
           
        }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
                // 위의 response 상수에 들어간 값이 어떤한 것을 의미하는지 모르겠습니다.
                completion(.doNotRetryWithError(error))
                return
            }
        
        let url = "https://api.suwiki.kr/user/refresh"
        
        let headers: HTTPHeaders = [
            "Authorization" : String(keychain.get("RefreshToken") ?? "")
        ]
        
        AF.request(url, method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            let data = response.data
            let json = JSON(data!)
            
            switch response.result{
            case .success(_):
                print("tokenRefresh")
                self.keychain.clear()
                self.keychain.set(json["RefreshToken"].stringValue, forKey: "RefreshToken")
                self.keychain.set(json["AccessToken"].stringValue, forKey: "AccessToken")
                completion(.retry)
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
            
            
        }
        
        /*
            RefreshTokenAPI.refreshToken { result in
                switch result {
                case .success(let accessToken):
                    KeychainServiceImpl.shared.accessToken = accessToken
                    completion(.retry)
                    
                case .failure(let error):
                    completion(.doNotRetryWithError(error))
                }
            }
        */
        }
    
    
}

