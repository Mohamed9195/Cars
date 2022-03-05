//
//  CarsEndpointSpecifications.swift
//  Cars
//
//  Created by Mohamed Hashem on 21/02/2022.
//

import Foundation
import UIKit
import Moya

// MARK: - Provider Specifications
enum CarsEndpointSpecifications {
    case getCarMakes(pageNo: Int, pageSize: Int)
    case getCarModel(carModel: String, pageNo: Int, pageSize: Int)
    case getCarModelDetail(makeNiceName: String, modelNiceName: String)
    case getCarPhoto(make: String, model: String)
}

// MARK: - Provider release url
let releaseURL = "http://api.edmunds.com/api/vehicle/v3/"
let releaseURLV2 = "https://api.edmunds.com/api/media/v2/"

// in real app should save it in keyChain
let key = "2ep93tpnyh6p5hgaxmp6pasq"

// MARK: - Provider target type
extension CarsEndpointSpecifications: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getCarModel, .getCarModelDetail, .getCarMakes:
            return URL(string: releaseURL)!
        case .getCarPhoto:
            return URL(string: releaseURLV2)!
        }
    }

    var path: String {
        switch self {
        case .getCarModel:
            return "modelYears"
        case .getCarModelDetail:
            return "styles/"
        case .getCarMakes:
            return "makes"
        case .getCarPhoto(let make, let model):
            return "\(make)/\(model)/photos"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCarModel, .getCarModelDetail, .getCarMakes, .getCarPhoto:
            return .get

        }
    }

    var headers: [String : String]? {
        switch self {
        case .getCarModel, .getCarModelDetail, .getCarMakes, .getCarPhoto:
            return  ["Accept": "application/json", "Content-Type": "application/json"]
        }
    }

    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)! as Data
    }

    var task: Task {
        switch self {
        case .getCarMakes(let pageNo, let pageSize):
            let parametersIs: [String : Any] = ["pageNum": pageNo,
                                                "pageSize": pageSize,
                                                "api_key": key]
            return .requestParameters(parameters: parametersIs, encoding: URLEncoding.default)
            
        case .getCarModel(carModel: let carModel, pageNo: let pageNo, pageSize: let pageSize):
            let parametersIs: [String : Any] = ["pageNum": pageNo,
                                                "pageSize": pageSize,
                                                "makeNiceName": carModel,
                                                "publicationStates": "NEW",
                                                "carType": "2022",
                                                "api_key": key]
            return .requestParameters(parameters: parametersIs, encoding: URLEncoding.default)
            
        case .getCarModelDetail(let makeNiceName, let modelNiceName):
            let parametersIs: [String : Any] = ["makeNiceName": makeNiceName,
                                                "modelNiceName": modelNiceName,
                                                "api_key": key]
            return .requestParameters(parameters: parametersIs, encoding: URLEncoding.default)
            
        case .getCarPhoto:
            let parametersIs: [String : Any] = ["fmt": "json",
                                                "api_key": key]
            return .requestParameters(parameters: parametersIs, encoding: URLEncoding.default)
        }
    }
}
