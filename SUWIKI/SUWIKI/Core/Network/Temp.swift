//
//  Temp.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation
import Alamofire

//private func dataTask<Value>(automaticallyCancelling shouldAutomaticallyCancel: Bool,
//                             forResponse onResponse: @escaping (@escaping (DataResponse<Value, AFError>) -> Void) -> Void)
//    -> DataTask<Value> {
//    let task = Task {
//        await withTaskCancellationHandler {
//            await withCheckedContinuation { continuation in
//                onResponse {
//                    continuation.resume(returning: $0)
//                }
//            }
//        } onCancel: {
//            self.cancel()
//        }
//    }
//
//    return DataTask<Value>(request: self, task: task, shouldAutomaticallyCancel: shouldAutomaticallyCancel)
//}
