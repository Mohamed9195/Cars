//
//  CaresMakesModel.swift
//  Cars
//
//  Created by Mohamed Hashem on 23/02/2022.
//

import Foundation

struct CarMakes: Codable {
    var totalNumber: Int?
    var totalPages: Int?
    var results: [carMakesModel]? = []

    enum CodingKeys: String, CodingKey {
        case totalNumber = "totalNumber"
        case totalPages = "totalPages"
        case results = "results"
    }
}

struct carMakesModel: Codable {
    var id : Int?
    var name : String?
    var niceName : String?
    var adTargetId : String?
    var niceId : String?
    var useInUsed : String?
    var useInNew : String?
    var useInPreProduction : String?
    var useInFuture : String?
    var models : [CarModel]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case niceName = "niceName"
        case adTargetId = "adTargetId"
        case niceId = "niceId"
        case useInUsed = "useInUsed"
        case useInNew = "useInNew"
        case useInPreProduction = "useInPreProduction"
        case useInFuture = "useInFuture"
        case models = "models"
    }
}

struct CarModel: Codable {
    var id : String?
    var name : String?
    var niceName : String?
    var href : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case niceName = "niceName"
        case href = "href"
    }
}
