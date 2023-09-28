//
//  RepoertsParameters.swift
//  IncidentManagementSystem
//
//  Created by MahmoudFares on 28/09/2023.
//

import Foundation
struct ReportParameters: Encodable {
    let description: String
    let typeID, subTypeID: Int
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case description
        case typeID = "typeId"
        case subTypeID = "subTypeId"
        case latitude, longitude
    }
}
