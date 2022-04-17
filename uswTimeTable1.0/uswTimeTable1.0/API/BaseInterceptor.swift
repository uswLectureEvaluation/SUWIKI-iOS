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
            guard urlRequest.url?.absoluteString.hasPrefix("https://api.agify.io") == true, // urlRequest.url은 주소 확인을 위해 체크를 하는건가요?
                  let accessToken = KeychainServiceImpl.shared.accessToken else {
                      completion(.success(urlRequest)) // 만약 주소 확인을 위해 체크를 하는거라면, 주소가 일치하지 않거나, accessToken이 없다면
                      return                           // completion(.success(urlRequest)를 해주는데, 일치하지 않는 경우도 진행이 된다는건데,
                                                       // 하단의 completion과 동일한 걸까요?
                  }

            var urlRequest = urlRequest // 또한 여기서 urlRequest를 선언해주는 이유가 뭔지.
            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
            completion(.success(urlRequest))
            // setValue를 하는 이유와, 괄호 기준으로 좌측에 넣어주는 값의 의미가 그냥 accessToken만 넣어주는건지 궁금하고
            // 또한 completion을 여기서도 해주는 이유가 뭔지 모르겠습니다.
        }
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
                // 위의 response 상수에 들어간 값이 어떤한 것을 의미하는지 모르겠습니다.
                completion(.doNotRetryWithError(error))
                return
            }

            RefreshTokenAPI.refreshToken { result in // 이 문법은 어떤 문법인지.. 잘 모르겠네요ㅠㅠ 내부는 switch case문인데
                                                     // 이런식으로 사용하는 이유를 잘 모르겠습니다.
                switch result {
                case .success(let accessToken):
                    KeychainServiceImpl.shared.accessToken = accessToken
                    completion(.retry) // accessToken이 유효하다면 키체인에 업데이트를 해주고 retry 하는게 맞을까요?
                                       // 아니면 유효기간은 지났는데 RefreshToken이 살아있을 때 해주는 동작인지 잘 모르겠습니다.
                    
                case .failure(let error): // 실패한 경우 doNotRetryWithError를 하는걸로 되있는데 이 실패는
                                          // statusCode가 401이 아닌경우를 의미하는 것 같습니다.
                                          // 그렇다면 서버에서 문제가 생긴 경우를 의미하는 것인가요?
                    completion(.doNotRetryWithError(error))
                }
            }
        }
    
    
}

