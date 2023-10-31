//
//  MainModel.swift
//  MontyTask
//
//  Created by Hussein kandil on 30/10/2023.
//

import Foundation

struct LaunchesResponse: Codable {
    let links: LinksResponse
    let rocket: String?
    let id: String?
    let date_utc: String?
    let name: String?
    let flight_number: Int?
    let failures: [FailuresResponse]
}

struct LinksResponse: Codable {
    let wikipedia: String?
}

struct FailuresResponse: Codable {
    let reason: String?
}
