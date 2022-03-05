//
//  CarsDetailsModel.swift
//  Cars
//
//  Created by Mohamed Hashem on 25/02/2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let totalNumber, totalPages: Int?
    let results: [CarsDetailsModel]?
}

// MARK: - Result
struct CarsDetailsModel: Codable {
    let id, makeID, year: Int?
    let makeName: String?
    let makeNiceName, makeNiceID: String?
    let modelID: String?
    let modelName: String?
    let modelNiceName, modelNiceID: String?
    let modelYearID: Int?
    let engineCylinder: Int?
    let engineSize: Double?
    let numberOfSeats: Int?
    let transmissionType: String?
    let engineType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case makeID = "makeId"
        case year, makeName, makeNiceName
        case makeNiceID = "makeNiceId"
        case modelID = "modelId"
        case modelName, modelNiceName
        case modelNiceID = "modelNiceId"
        case modelYearID = "modelYearId"
        case engineCylinder, engineSize, numberOfSeats, transmissionType, engineType
    }
}


struct CarsPhoto: Codable {
    let photos: [Photo]?
}

// MARK: - Photo
struct Photo: Codable {
    let sources: [Source]

    enum CodingKeys: String, CodingKey {
        case sources
    }
}

// MARK: - Source
struct Source: Codable {
    let link: Link
   
    enum CodingKeys: String, CodingKey {
        case link
    }
}

struct Link: Codable {
    let href: String
}
