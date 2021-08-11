//
//  RouteInfoCellDetailViewModel.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class RouteInfoCellDetailViewModel: NSObject {
    let routeID: String?
    let routeNameLabel: String?
    let sourceStationLabel: String?
    let destinationNameLabel: String?
    let totalDuration: String?
    
    init(with model: RouteInfo?) {
        self.routeID = model?.id
        self.routeNameLabel = model?.name
        self.sourceStationLabel = model?.source
        self.destinationNameLabel = model?.destination
        self.totalDuration = model?.tripDuration
    }

}
