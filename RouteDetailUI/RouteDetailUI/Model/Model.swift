//
//  Model.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import Foundation

struct RouteDetail: Codable {
    let routeInfo: [RouteInfo]?
    let routeTimings: [String: [RouteTiming]]?
}

struct RouteInfo: Codable {
    let id: String?
    let name: String?
    let source: String?
    let tripDuration: String?
    let destination: String?
}

struct RouteTiming: Codable {
    let totalSeats: Int?
    let avaiable: Int?
    let tripStartTime: String?
}
