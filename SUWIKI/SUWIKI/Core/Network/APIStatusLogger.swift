//
//  CustomLogger.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Alamofire

final class APIStatusLogger: EventMonitor {

    func requestDidFinish(_ request: Request) {
        print("======================= @Log requestDidFinish =======================")
        print("@Log ✅ URL - \(request.request?.url?.absoluteString ?? "")")
        print("@Log ✅ Method - \(request.request?.httpMethod ?? "")")
        print("@Log ✅ Header - \(request.request?.allHTTPHeaderFields ?? [:]) ")
        if let body = request.request?.httpBody?.toPrettyPrintedString {
            print("@Log ✅ body - \(body)")
        } else {
            print("@Log ✅ body - null")
        }
    }

    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        print("=================== @Log Response ==================")
        guard let statusCode = request.response?.statusCode else { return }
        switch response.result {
        case .success:
            print("@Log ✅ .success, statusCode : \(statusCode)")
        case .failure:
            print("@Log ❎ .failure, statusCode : \(statusCode)")
        }

        if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 400..<500:
                print("@Log ❎ 내 문제")
            case 500..<600:
                print("@Log ❎ 서버 문제")
            default:
                break
            }
        }

        if let response = response.data?.toPrettyPrintedString {
            print("@Log ✅ ResponseData : \(response)")
        }
        print("=========================================================")
    }

    func request(
        _ request: Request,
        didFailTask task: URLSessionTask,
        earlyWithError error: AFError
    ) {
        print("@Log ❎ didFailTask")
    }

    func request(
        _ request: Request,
        didFailToCreateURLRequestWithError error: AFError
    ) {
        print("@Log ❎ didFailToCreateURLRequestWithError")
        debugPrint("")
    }

    func requestDidCancel(_ request: Request) {
        print("@Log ✅ requestDidCancel")
    }

}

fileprivate extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else {
            return nil
        }
        return prettyPrintedString as String
    }
}
