//
//  CarsEndPoints.swift
//  Cars
//
//  Created by Mohamed Hashem on 21/02/2022.
//

import Foundation
import Moya
import RxSwift

// MARK: - Provider support
final class CarsEndPoints {

    static var shared = CarsEndPoints()

    let provider = MoyaProvider<CarsEndpointSpecifications>(plugins: [AccessTokenPlugin { _ in "" }, CompleteUrlLoggerPlugin()])
}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print("##URL", request.request?.url?.absoluteString ?? "Something is wrong","  ##Body", request.request?.httpBody ?? "Something is wrong", "  ##header", request.request?.headers as Any)
    }
}
