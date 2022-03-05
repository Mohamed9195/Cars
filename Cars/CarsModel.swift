//
//  CarsModel.swift
//  Cars
//
//  Created by Mohamed Hashem on 05/03/2022.
//

import Foundation

struct CarModelsResponseModel : Codable {
    var totalNumber : Int?
    var totalPages : Int?
    var results : [CarModelInfo]?

    enum CodingKeys: String, CodingKey {
        case totalNumber = "totalNumber"
        case totalPages = "totalPages"
        case results = "results"
    }
}

struct CarModelInfo : Codable {
    var id : Int?
    var makeId : Int?
    var makeName : String?
    var makeNiceName : String?
    var makeNiceId : String?
    var modelId : String?
    var modelName : String?
    var modelNiceName : String?
    var modelNiceId : String?
    var modelLinkCode : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case makeId = "makeId"
        case makeName = "makeName"
        case makeNiceName = "makeNiceName"
        case makeNiceId = "makeNiceId"
        case modelId = "modelId"
        case modelName = "modelName"
        case modelNiceName = "modelNiceName"
        case modelNiceId = "modelNiceId"
        case modelLinkCode = "modelLinkCode"
        
    }
}
